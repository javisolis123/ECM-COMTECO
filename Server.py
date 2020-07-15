import socket
import select
from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey, create_engine, Float, DateTime, update, Date, Time
from sqlalchemy.sql import select as Select
import time
from adafruit_ads1x15.analog_in import AnalogIn
import board
import busio
import adafruit_ads1x15.ads1015 as ADS
import smbus


bus = smbus.SMBus(1)
address = 0x68

def obtenerTemp(address):
	byte_tmsb = bus.read_byte_data(address,0x11)
	byte_tlsb = bin(bus.read_byte_data(address,0x12))[2:].zfill(8)
	return byte_tmsb+int(byte_tlsb[0])*2**(-1)+int(byte_tlsb[1])*2**(-2)


#################Configuracion del conversor analogo digital#################

# Create the I2C bus
i2c = busio.I2C(board.SCL, board.SDA)

# Create the ADS object
ads = ADS.ADS1015(i2c)
#ads = ADS.ADS1115(i2c)

# Create a sinlge ended channel on Pin 0
#   Max counts for ADS1015 = 2047
#                  ADS1115 = 32767
chan0 = AnalogIn(ads, ADS.P0)
chan1 = AnalogIn(ads, ADS.P1)
chan2 = AnalogIn(ads, ADS.P2)
chan3 = AnalogIn(ads, ADS.P3)

# The ADS1015 and ADS1115 both have the same gain options.
#
#       GAIN    RANGE (V)
#       ----    ---------
#        2/3    +/- 6.144
#          1    +/- 4.096
#          2    +/- 2.048
#          4    +/- 1.024
#          8    +/- 0.512
#         16    +/- 0.256

#Creamos una lista de las posibles combinaciones de amplificacion
gains = (2/3, 1, 2, 4, 8, 16)
#Seleccionamos la opcion de 2/3
ads.gain = gains[0]
#Creamos una instancia  metadata para poder ejecutar comandos de SQLAlchemy
metadata = MetaData()

#Estructura de la tabla todo
todo = Table('todo', metadata,
             Column('id', Integer, primary_key = True),
             Column('temperatura', Float()),
             Column('humedad', Float()),
             Column('canal1', Float()),
             Column('canal2', Float()),
             Column('canal3', Float()),
             Column('canal4', Float()),
             Column('tempGabinete', Float()),
             Column('hora', Time()),
             Column('fecha', Date()),
             )

#Estructura de la tabla configuracion             
configuracion = Table('configuracion', metadata,
                      Column('id', Integer, primary_key = True),
                      Column('tipo', Integer),
                      Column('frec', Integer),
                      Column('checkbox', String(15)),
                      Column('ip', String(15))
                      )

#Estructura de la tabla ahora                
ahora = Table('ahora', metadata,
              Column('id', Integer, primary_key = True),
              Column('temperatura', Float()),
              Column('humedad', Float()),
              Column('canal1', Float()),
              Column('canal2', Float()),
              Column('canal3', Float()),
              Column('canal4', Float()),
              Column('tempGabinete', Float()),
              Column('hora', Time()),
              )

#Estructura de la tabla estado_conexion
estado_conexion = Table('estado_conexion', metadata,
                Column('id', Integer, primary_key = True),
                Column('estado', String(20))
)

#Se crea un objeto con la conexion a la base de datos de MariaDB
engine = create_engine('mysql+pymysql://javi:javiersolis12@localhost/Tuti')
connection = engine.connect()
metadata.create_all(engine)

#Tamaño maximo de la cabecer del paquete
HEADER_LENGTH = 10
#Direccion IP del servidor y puerto
IP = "192.168.10.20"
PORT = 1235

# Create a socket
# socket.AF_INET - address family, IPv4, some otehr possible are AF_INET6, AF_BLUETOOTH, AF_UNIX
# socket.SOCK_STREAM - TCP, conection-based, socket.SOCK_DGRAM - UDP, connectionless, datagrams, socket.SOCK_RAW - raw IP packets
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# SO_ - socket option
# SOL_ - socket option level
# Sets REUSEADDR (as a socket option) to 1 on socket
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

# Bind, so server informs operating system that it's going to use given IP and port
# For a server using 0.0.0.0 means to listen on all available interfaces, useful to connect locally to 127.0.0.1 and remotely to LAN interface IP
server_socket.bind((IP, PORT))

# This makes server listen to new connections
server_socket.listen()

# List of sockets for select.select()
sockets_list = [server_socket]

# List of connected clients - socket as a key, user header and name as data
clients = {}

print(f'Listening for connections on {IP}:{PORT}...')
query_estado_conexion = update(estado_conexion).where(estado_conexion.c.id == 1).values(estado = "sin conexion")
connection.execute(query_estado_conexion)
# Handles message receiving


def receive_message(client_socket):

    try:

        # Receive our "header" containing message length, it's size is defined and constant
        message_header = client_socket.recv(HEADER_LENGTH)

        # If we received no data, client gracefully closed a connection, for example using socket.close() or socket.shutdown(socket.SHUT_RDWR)
        if not len(message_header):
            return False

        # Convert header to int value
        message_length = int(message_header.decode('utf-8').strip())

        # Return an object of message header and message data
        return {'header': message_header, 'data': client_socket.recv(message_length)}

    except:

        # If we are here, client closed connection violently, for example by pressing ctrl+c on his script
        # or just lost his connection
        # socket.close() also invokes socket.shutdown(socket.SHUT_RDWR) what sends information about closing the socket (shutdown read/write)
        # and that's also a cause when we receive an empty message
        return False


while True:
    # Calls Unix select() system call or Windows select() WinSock call with three parameters:
    #   - rlist - sockets to be monitored for incoming data
    #   - wlist - sockets for data to be send to (checks if for example buffers are not full and socket is ready to send some data)
    #   - xlist - sockets to be monitored for exceptions (we want to monitor all sockets for errors, so we can use rlist)
    # Returns lists:
    #   - reading - sockets we received some data on (that way we don't have to check sockets manually)
    #   - writing - sockets ready for data to be send thru them
    #   - errors  - sockets with some exceptions
    # This is a blocking call, code execution will "wait" here and "get" notified in case any action should be taken
    read_sockets, _, exception_sockets = select.select(
    sockets_list, [], sockets_list)
    # Iterate over notified sockets
    for notified_socket in read_sockets:
            # If notified socket is a server socket - new connection, accept it
        if notified_socket == server_socket:
            # Accept new connection
            # That gives us new socket - client socket, connected to this given client only, it's unique for that client
            # The other returned object is ip/port set
            client_socket, client_address = server_socket.accept()
            # Client should send his name right away, receive it
            user = receive_message(client_socket)
            # If False - client disconnected before he sent his name
            if user is False:
                continue
            # Add accepted socket to select.select() list
            sockets_list.append(client_socket)
            # Also save username and username header
            clients[client_socket] = user
            print('Accepted new connection from {}:{}, username: {}'.format(*client_address, user['data'].decode('utf-8')))
            query_estado_conexion = update(estado_conexion).where(estado_conexion.c.id == 1).values(estado = "con conexion")
            connection.execute(query_estado_conexion)
        # Else existing socket is sending a message
        else:
            # Receive message
            message = receive_message(notified_socket)
            # If False, client disconnected, cleanup
            if message is False:
                print('Closed connection from: {}'.format(clients[notified_socket]['data'].decode('utf-8')))
                query_estado_conexion = update(estado_conexion).where(estado_conexion.c.id == 1).values(estado = "sin conexion")
                connection.execute(query_estado_conexion)
                # Remove from list for socket.socket()
                sockets_list.remove(notified_socket)
                # Remove from our list of users
                del clients[notified_socket]
                continue
            # Get user by notified socket, so we will know who sent the message
            user = clients[notified_socket]
            # Guardamos el mensaje recibido del cliente en datos
            datos = message["data"].decode("utf-8")
            # Separamos la cadena de datos por comas en sus respectivas variables
            temp, hum, ch1, ch2, hora = datos.split(",")
            # Selecciona el valor de la columna tipo de la tabla config
            t = Select([configuracion])
            # Ejecutamos la seleccion anterior
            get_confi = connection.execute(t).fetchone()
            # Preguntamos que tipo de antena es 1: para DragonWave 2: para Siemens
            if(int(get_confi.tipo) == 1):
                actual = update(ahora).where(ahora.c.id == 1).values(temperatura=temp,
                                                                     humedad=hum,
                                                                     canal1=ch1,
                                                                     canal2=ch2,
                                                                     canal3=chan2.voltage,
                                                                     canal4=chan3.voltage,
                                                                     tempGabinete = obtenerTemp(address),
                                                                     hora=time.strftime("%H:%M:%S"))
                connection.execute(actual)
                print("Se actualizo la tabla ahora")
                time.sleep(0.5)
            if(int(get_confi.tipo) == 2):
                actual = update(ahora).where(ahora.c.id == 1).values(temperatura=temp,
                                                                     humedad=hum,
                                                                     canal1=chan0.voltage,
                                                                     canal2=chan1.voltage,
                                                                     canal3=chan2.voltage,
                                                                     canal4=chan3.voltage,
                                                                     tempGabinete = obtenerTemp(address),
                                                                     hora=time.strftime("%H:%M:%S"))
                connection.execute(actual)
                print("Se actualizo la tabla ahora")
                time.sleep(0.5)
            # Iterate over connected clients and broadcast message
            for client_socket in clients:
                # But don't sent it to sender
                if client_socket != notified_socket:
                    # Send user and message (both with their headers)
                    # We are reusing here message header sent by sender, and saved username header send by user when he connected
                    client_socket.send(
                        user['header'] + user['data'] + message['header'] + message['data'])
    # It's not really necessary to have this, but will handle some socket exceptions just in case
    for notified_socket in exception_sockets:
        # Remove from list for socket.socket()
        sockets_list.remove(notified_socket)
        # Remove from our list of users
        del clients[notified_socket]
