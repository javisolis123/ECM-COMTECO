-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 02-05-2020 a las 10:17:12
-- Versión del servidor: 10.3.22-MariaDB-0+deb10u1
-- Versión de PHP: 7.3.14-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Tuti`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ahora`
--

CREATE TABLE `ahora` (
  `id` int(11) NOT NULL,
  `temperatura` float DEFAULT NULL,
  `humedad` float DEFAULT NULL,
  `canal1` float DEFAULT NULL,
  `canal2` float DEFAULT NULL,
  `canal3` float DEFAULT NULL,
  `canal4` float DEFAULT NULL,
  `tempGabinete` float NOT NULL,
  `hora` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ahora`
--

INSERT INTO `ahora` (`id`, `temperatura`, `humedad`, `canal1`, `canal2`, `canal3`, `canal4`, `tempGabinete`, `hora`) VALUES
(1, 21, 17, 2.79965, 0.556329, 0.552017, 0.552017, 23.75, '11:47:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alarmas`
--

CREATE TABLE `alarmas` (
  `id` int(11) NOT NULL,
  `codigo` varchar(10) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `hora_inicial` time NOT NULL,
  `fec_inicial` date NOT NULL,
  `estado` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alarmas`
--

INSERT INTO `alarmas` (`id`, `codigo`, `descripcion`, `hora_inicial`, `fec_inicial`, `estado`) VALUES
(1, '0xE1001', 'Fallo en el sensor de temperatura y Humedad', '11:47:31', '2020-05-01', 'inactivo'),
(2, '0xE1002', 'Potencia por emcima de lo permitido', '13:47:15', '2020-04-18', 'inactivo'),
(3, '0xE1003', 'Potencia por debajo de la sensibilidad permitida', '14:33:10', '2020-04-27', 'inactivo'),
(4, '0xE2001', 'Problemas con el Voltaje AC gabinete', '06:16:16', '2020-04-11', 'inactivo'),
(5, '0xE2002', 'Temperatura gabinete encima de lo permitido', '13:55:55', '2020-04-18', 'inactivo'),
(6, '0xE2003', 'Temperatura gabinete por debajo de lo permitido', '13:58:56', '2020-04-18', 'inactivo'),
(7, '0xE2010', 'Falla Conexion hacia SMR', '14:49:55', '2020-04-27', 'inactivo'),
(8, '0xE2011', 'Falla Conexion hacia CCM', '16:01:45', '2020-04-29', 'inactivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `tipo` int(11) DEFAULT NULL,
  `frec` int(11) DEFAULT NULL,
  `potmax` float NOT NULL,
  `potmin` float NOT NULL,
  `tempmax` int(11) NOT NULL,
  `tempmin` int(11) NOT NULL,
  `checkbox` varchar(15) NOT NULL,
  `ip` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `tipo`, `frec`, `potmax`, `potmin`, `tempmax`, `tempmin`, `checkbox`, `ip`) VALUES
(1, 1, 30, 4.8, 1, 40, -3, 'con CCM', '3.19.38.144');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_conexion`
--

CREATE TABLE `estado_conexion` (
  `id` int(11) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `CCM` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estado_conexion`
--

INSERT INTO `estado_conexion` (`id`, `estado`, `CCM`) VALUES
(1, 'sin conexion', 'con conexion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnicos`
--

CREATE TABLE `tecnicos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telf` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tecnicos`
--

INSERT INTO `tecnicos` (`id`, `nombre`, `apellido`, `email`, `telf`) VALUES
(1, 'Javier', 'Solis', 'javier.solis.guardia1@gmail.com', '77947711'),
(2, 'Daniel', 'Soliz', 'daniel.soliz@ecm.com', '77436933'),
(3, 'Eduardo', 'McDonald', 'edu@mcdonald.com', '70745164');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temporal`
--

CREATE TABLE `temporal` (
  `id` int(11) NOT NULL,
  `temperatura` float NOT NULL,
  `humedad` float NOT NULL,
  `canal1` float NOT NULL,
  `canal2` float NOT NULL,
  `canal3` float NOT NULL,
  `canal4` float NOT NULL,
  `tempGabinete` float NOT NULL,
  `hora` time NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `todo`
--

CREATE TABLE `todo` (
  `id` int(11) NOT NULL,
  `temperatura` float DEFAULT NULL,
  `humedad` float DEFAULT NULL,
  `canal1` float DEFAULT NULL,
  `canal2` float DEFAULT NULL,
  `canal3` float DEFAULT NULL,
  `canal4` float DEFAULT NULL,
  `tempGabinete` float NOT NULL,
  `hora` time DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `todo`
--

INSERT INTO `todo` (`id`, `temperatura`, `humedad`, `canal1`, `canal2`, `canal3`, `canal4`, `tempGabinete`, `hora`, `fecha`) VALUES
(1, 17, 46, 2.80696, 0.559892, 0.534016, 0.543017, 24.25, '22:30:00', '2020-04-28'),
(2, 17, 47, 2.80884, 0.559142, 0.534016, 0.537016, 24.5, '23:00:00', '2020-04-28'),
(3, 16, 53, 2.80921, 0.547517, 0.534016, 0.537016, 24.5, '23:30:00', '2020-04-28'),
(4, 16, 49, 2.80959, 0.548079, 0.534016, 0.537016, 24.25, '00:00:00', '2020-04-29'),
(5, 16, 53, 2.81071, 0.547704, 0.537016, 0.537016, 24.25, '00:30:00', '2020-04-29'),
(6, 15, 53, 2.80996, 0.557079, 0.549017, 0.537016, 24, '01:00:00', '2020-04-29'),
(7, 15, 59, 2.80977, 0.551829, 0.549017, 0.537016, 23.75, '01:30:00', '2020-04-29'),
(8, 15, 55, 2.80921, 0.558392, 0.537016, 0.540016, 23.75, '02:00:00', '2020-04-29'),
(9, 15, 60, 2.8094, 0.550142, 0.552017, 0.543017, 23.75, '02:30:00', '2020-04-29'),
(10, 15, 65, 2.80921, 0.553517, 0.540016, 0.543017, 23.5, '03:00:00', '2020-04-29'),
(11, 15, 65, 2.80884, 0.551079, 0.540016, 0.540016, 23.25, '03:30:00', '2020-04-29'),
(12, 15, 66, 2.80902, 0.549954, 0.540016, 0.540016, 23.25, '04:00:00', '2020-04-29'),
(13, 14, 68, 2.80846, 0.559517, 0.543017, 0.543017, 23.25, '04:30:00', '2020-04-29'),
(14, 14, 68, 2.80902, 0.552954, 0.537016, 0.543017, 23, '05:00:00', '2020-04-29'),
(15, 15, 66, 2.80977, 0.552954, 0.540016, 0.540016, 23, '05:30:00', '2020-04-29'),
(16, 15, 66, 2.8094, 0.553329, 0.540016, 0.540016, 22.5, '06:00:00', '2020-04-29'),
(17, 15, 65, 2.80827, 0.562517, 0.549017, 0.540016, 22.75, '06:30:00', '2020-04-29'),
(18, 15, 67, 2.80809, 0.56383, 0.537016, 0.543017, 22.75, '07:00:00', '2020-04-29'),
(19, 16, 66, 2.80846, 0.562892, 0.543017, 0.543017, 22.75, '07:30:00', '2020-04-29'),
(20, 17, 64, 2.80865, 0.556329, 0.543017, 0.540016, 22.75, '08:00:00', '2020-04-29'),
(21, 18, 64, 2.80734, 0.550329, 0.540016, 0.540016, 22.5, '08:30:00', '2020-04-29'),
(22, 19, 57, 2.80865, 0.551267, 0.546017, 0.558017, 23, '09:00:00', '2020-04-29'),
(23, 18, 60, 2.80884, 0.551267, 0.540016, 0.543017, 23, '09:30:00', '2020-04-29'),
(24, 19, 55, 2.80977, 0.550892, 0.540016, 0.540016, 23, '10:00:00', '2020-04-29'),
(25, 19, 51, 2.80977, 0.552204, 0.540016, 0.540016, 23.25, '10:30:00', '2020-04-29'),
(26, 21, 48, 2.80959, 0.56383, 0.537016, 0.543017, 23.5, '11:00:00', '2020-04-29'),
(27, 21, 43, 2.8094, 0.550704, 0.537016, 0.540016, 23.75, '11:30:00', '2020-04-29'),
(28, 21, 39, 2.80977, 0.549017, 0.537016, 0.537016, 24, '12:00:00', '2020-04-29'),
(29, 23, 17, 2.80959, 0.562142, 0.534016, 0.540016, 24.25, '12:30:00', '2020-04-29'),
(30, 23, 17, 2.80846, 0.550329, 0.531016, 0.540016, 24.5, '13:00:00', '2020-04-29'),
(31, 23, 17, 2.81052, 0.552017, 0.543017, 0.549017, 25, '13:30:00', '2020-04-29'),
(32, 23, 17, 2.81015, 0.549017, 0.549017, 0.534016, 25.25, '14:00:00', '2020-04-29'),
(33, 24, 17, 2.81052, 0.561955, 0.531016, 0.534016, 26, '14:30:00', '2020-04-29'),
(34, 24, 16, 2.79871, 0.550892, 0.534016, 0.534016, 26.5, '15:00:00', '2020-04-29'),
(35, 24, 16, 2.79946, 0.561017, 0.534016, 0.537016, 27, '15:30:00', '2020-04-29'),
(36, 24, 16, 2.79965, 0.56158, 0.525016, 0.531016, 27.5, '16:00:00', '2020-04-29'),
(37, 24, 16, 2.79965, 0.56158, 0.525016, 0.531016, 27.5, '16:00:00', '2020-04-29'),
(38, 19, 24, 2.80059, 0.552579, 0.537016, 0.531016, 26.5, '19:00:00', '2020-04-29'),
(39, 19, 28, 2.80077, 0.549954, 0.540016, 0.537016, 26.25, '19:30:00', '2020-04-29'),
(40, 18, 35, 2.80002, 0.553517, 0.531016, 0.534016, 26, '20:00:00', '2020-04-29'),
(41, 18, 37, 2.80059, 0.545829, 0.534016, 0.534016, 25.75, '20:30:00', '2020-04-29'),
(42, 18, 36, 2.80115, 0.546017, 0.540016, 0.537016, 25.75, '21:00:00', '2020-04-29'),
(43, 15, 60, 2.79965, 0.552204, 0.543017, 0.543017, 22.5, '08:30:00', '2020-04-30'),
(44, 16, 53, 2.80059, 0.552204, 0.540016, 0.543017, 22.75, '09:00:00', '2020-04-30'),
(45, 17, 51, 2.79796, 0.551267, 0.540016, 0.540016, 22.75, '09:30:00', '2020-04-30'),
(46, 17, 48, 2.80209, 0.552017, 0.537016, 0.540016, 23, '10:00:00', '2020-04-30'),
(47, 18, 46, 2.80152, 0.550142, 0.540016, 0.543017, 23, '10:30:00', '2020-04-30'),
(48, 19, 42, 2.8004, 0.555767, 0.540016, 0.540016, 23.25, '11:00:00', '2020-04-30'),
(49, 20, 26, 2.8019, 0.564017, 0.537016, 0.543017, 23.5, '11:30:00', '2020-04-30'),
(50, 21, 19, 2.79871, 0.562892, 0.540016, 0.546017, 23.5, '12:00:00', '2020-04-30'),
(51, 21, 18, 2.79909, 0.562517, 0.540016, 0.540016, 23.75, '12:30:00', '2020-04-30'),
(52, 23, 17, 2.8019, 0.552392, 0.540016, 0.537016, 24, '13:00:00', '2020-04-30'),
(53, 23, 16, 2.80227, 0.550892, 0.537016, 0.537016, 24.5, '13:30:00', '2020-04-30'),
(54, 24, 16, 2.80227, 0.56308, 0.534016, 0.540016, 25.25, '14:00:00', '2020-04-30'),
(55, 24, 16, 2.80321, 0.551454, 0.537016, 0.534016, 25.75, '14:30:00', '2020-04-30'),
(56, 25, 14, 2.80209, 0.56008, 0.534016, 0.534016, 26.5, '15:00:00', '2020-04-30'),
(57, 24, 15, 2.8004, 0.546954, 0.540016, 0.534016, 27, '15:30:00', '2020-04-30'),
(58, 25, 14, 2.80096, 0.550704, 0.531016, 0.540016, 27.5, '16:00:00', '2020-04-30'),
(59, 25, 14, 2.80302, 0.547329, 0.546017, 0.534016, 27.75, '16:30:00', '2020-04-30'),
(60, 24, 15, 2.80246, 0.559705, 0.528016, 0.531016, 27.75, '17:00:00', '2020-04-30'),
(61, 23, 15, 2.80246, 0.548079, 0.534016, 0.528016, 27.75, '17:30:00', '2020-04-30'),
(62, 22, 17, 2.80209, 0.558017, 0.534016, 0.531016, 27.25, '18:00:00', '2020-04-30'),
(63, 20, 18, 2.80059, 0.550142, 0.546017, 0.534016, 27, '18:30:00', '2020-04-30'),
(64, 19, 18, 2.8019, 0.556892, 0.537016, 0.537016, 26.75, '19:00:00', '2020-04-30'),
(65, 19, 37, 2.80152, 0.557455, 0.531016, 0.534016, 26.75, '19:30:00', '2020-04-30'),
(66, 19, 21, 2.80021, 0.557267, 0.534016, 0.537016, 26.5, '20:00:00', '2020-04-30'),
(67, 17, 22, 2.79946, 0.548829, 0.534016, 0.534016, 26.25, '20:30:00', '2020-04-30'),
(68, 17, 33, 2.80059, 0.551454, 0.531016, 0.540016, 26.25, '21:00:00', '2020-04-30'),
(69, 17, 39, 2.80096, 0.556329, 0.531016, 0.540016, 26, '21:30:00', '2020-04-30'),
(70, 17, 43, 2.80021, 0.558017, 0.534016, 0.543017, 25.75, '22:00:00', '2020-04-30'),
(71, 16, 48, 2.80002, 0.552767, 0.540016, 0.537016, 25.5, '22:30:00', '2020-04-30'),
(72, 15, 49, 2.80077, 0.557079, 0.534016, 0.537016, 25.5, '23:00:00', '2020-04-30'),
(73, 15, 49, 2.79984, 0.546954, 0.537016, 0.537016, 25.25, '23:30:00', '2020-04-30'),
(74, 15, 46, 2.80115, 0.546767, 0.552017, 0.540016, 25, '00:00:00', '2020-05-01'),
(75, 15, 48, 2.80246, 0.552017, 0.540016, 0.543017, 24.75, '00:30:00', '2020-05-01'),
(76, 14, 51, 2.80021, 0.559705, 0.537016, 0.540016, 24.75, '01:00:00', '2020-05-01'),
(77, 14, 24, 2.80096, 0.557267, 0.537016, 0.537016, 24.5, '01:30:00', '2020-05-01'),
(78, 14, 24, 2.80171, 0.55933, 0.549017, 0.537016, 24.25, '02:00:00', '2020-05-01'),
(79, 14, 42, 2.80077, 0.549392, 0.537016, 0.540016, 24.25, '02:30:00', '2020-05-01'),
(80, 13, 48, 2.80115, 0.559142, 0.549017, 0.543017, 23.75, '03:00:00', '2020-05-01'),
(81, 13, 47, 2.80134, 0.555954, 0.540016, 0.537016, 23.75, '03:30:00', '2020-05-01'),
(82, 13, 50, 2.80096, 0.551267, 0.546017, 0.543017, 23.5, '04:00:00', '2020-05-01'),
(83, 13, 52, 2.80171, 0.552204, 0.540016, 0.540016, 23.5, '04:30:00', '2020-05-01'),
(84, 12, 54, 2.80115, 0.549767, 0.546017, 0.543017, 23, '05:00:00', '2020-05-01'),
(85, 12, 54, 2.80152, 0.555392, 0.546017, 0.543017, 23, '05:30:00', '2020-05-01'),
(86, 12, 53, 2.8004, 0.552767, 0.558017, 0.552017, 22.75, '06:00:00', '2020-05-01'),
(87, 12, 54, 2.8004, 0.550892, 0.543017, 0.540016, 22.75, '06:30:00', '2020-05-01'),
(88, 11, 54, 2.79759, 0.552579, 0.558017, 0.540016, 22.25, '07:00:00', '2020-05-01'),
(89, 13, 50, 2.79984, 0.565517, 0.543017, 0.540016, 22.25, '07:30:00', '2020-05-01'),
(90, 14, 47, 2.80096, 0.552579, 0.540016, 0.543017, 22.25, '08:00:00', '2020-05-01'),
(91, 15, 40, 2.80115, 0.551642, 0.549017, 0.549017, 22.5, '08:30:00', '2020-05-01'),
(92, 16, 37, 2.8004, 0.564017, 0.540016, 0.543017, 22.75, '09:00:00', '2020-05-01'),
(93, 17, 35, 2.80077, 0.551079, 0.558017, 0.540016, 22.75, '09:30:00', '2020-05-01'),
(94, 18, 33, 2.80077, 0.551454, 0.543017, 0.540016, 23, '10:00:00', '2020-05-01'),
(95, 19, 21, 2.80059, 0.550329, 0.540016, 0.543017, 23.25, '10:30:00', '2020-05-01'),
(96, 20, 21, 2.80096, 0.56233, 0.540016, 0.540016, 23.25, '11:00:00', '2020-05-01'),
(97, 21, 18, 2.80209, 0.551267, 0.552017, 0.543017, 23.5, '11:30:00', '2020-05-01');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ahora`
--
ALTER TABLE `ahora`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `alarmas`
--
ALTER TABLE `alarmas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estado_conexion`
--
ALTER TABLE `estado_conexion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `temporal`
--
ALTER TABLE `temporal`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `todo`
--
ALTER TABLE `todo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ahora`
--
ALTER TABLE `ahora`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `alarmas`
--
ALTER TABLE `alarmas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `estado_conexion`
--
ALTER TABLE `estado_conexion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `temporal`
--
ALTER TABLE `temporal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `todo`
--
ALTER TABLE `todo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
