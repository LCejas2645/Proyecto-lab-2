-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-02-2025 a las 21:41:13
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyectolab2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admistrativo`
--

CREATE TABLE `admistrativo` (
  `id` int(11) NOT NULL,
  `pass` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bioquimico`
--

CREATE TABLE `bioquimico` (
  `id` int(11) NOT NULL,
  `pass` int(4) NOT NULL,
  `updateAt` date NOT NULL,
  `createAt` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `determinacion`
--

CREATE TABLE `determinacion` (
  `id` int(11) NOT NULL,
  `examenId` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `unidadMedida` varchar(255) NOT NULL,
  `valorMin` varchar(100) NOT NULL,
  `valorMax` varchar(100) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `determinacion`
--

INSERT INTO `determinacion` (`id`, `examenId`, `descripcion`, `unidadMedida`, `valorMin`, `valorMax`, `activo`, `createdAt`, `updatedAt`) VALUES
(20, 34, 'Hemoglobina', 'g/dL', '12', '17.5', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(21, 34, 'Hematocrito', '%', '37', '50', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(22, 34, 'Leucocitos', '10^3/uL', '4', '11', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(23, 36, 'Colesterol Total', 'mg/dL', '0', '400', 1, '2024-07-29 01:34:21', '2024-08-08 01:43:07'),
(24, 36, 'Colesterol LDL (Lipoproteínas de baja densidad)', 'mg/dL', '0', '299', 1, '2024-07-29 22:07:53', '2024-07-29 22:07:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examen`
--

CREATE TABLE `examen` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `tiempoPromedio` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `examen`
--

INSERT INTO `examen` (`id`, `descripcion`, `tiempoPromedio`, `activo`, `createdAt`, `updatedAt`) VALUES
(34, 'Hemograma Completo', 3, 1, '0000-00-00 00:00:00', '2024-08-07 23:57:39'),
(36, 'Perfil Lipídico', 2, 1, '2024-07-29 01:01:18', '2024-08-08 01:14:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `muestra`
--

CREATE TABLE `muestra` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `examenId` int(11) NOT NULL,
  `detalles` varchar(255) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

CREATE TABLE `orden` (
  `id` int(11) NOT NULL,
  `id_Paciente` int(11) NOT NULL,
  `id_Administrativo` int(11) NOT NULL,
  `id_Examen` int(11) NOT NULL,
  `id_Tecnico` int(11) NOT NULL,
  `id_Bioquimico` int(11) NOT NULL,
  `diagnostico` varchar(50) NOT NULL,
  `estado` enum('esperando toma de muestra','Analitica','Para Validar','Informada') NOT NULL,
  `createAt` date NOT NULL,
  `fechaOut` date NOT NULL,
  `updateAt` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `id` int(11) NOT NULL,
  `edad` int(11) DEFAULT NULL,
  `nombreCompleto` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `dni` int(11) DEFAULT NULL,
  `sexo` enum('Masculino','Femenino','Otro') DEFAULT NULL,
  `embarazo` tinyint(1) DEFAULT NULL,
  `patologiaPre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`id`, `edad`, `nombreCompleto`, `mail`, `dni`, `sexo`, `embarazo`, `patologiaPre`) VALUES
(2, 5555555, 'luciano cejas edit final', 'lucasuoda@sadas.com', 334, 'Masculino', 0, ''),
(3, 44, 'Maxi ferrer', 'assasfasfa', 3443535, 'Otro', 0, ''),
(4, 44, 'lauti litke', '', 22222222, '', 0, ''),
(7, 0, 'zofia sssss', '', 999999, '', 0, ''),
(12, 0, 'marcos gil', '', 39993664, 'Masculino', 0, ''),
(19, 33, 'Roberto Carlos', 'asdasdasd', 345454545, 'Masculino', 0, 'best'),
(21, 0, 'new', '', 0, 'Masculino', 0, ''),
(22, 0, 'new 2', '', 0, 'Femenino', 1, ''),
(25, 20, 'alexis sanches', 'asd@sad', 134341, 'Masculino', 1, 'no'),
(26, 32, 'cavani ', 'asd@sad', 214142, 'Masculino', 1, 'no'),
(27, 22, 'carvajal', 'asd@sad', 2142, 'Masculino', 0, ''),
(28, 22, 'mc allister', 'asd@sad', 134124, 'Masculino', 1, 'si'),
(30, 33, 'de paul', 'asd@sad', 214214124, 'Masculino', 0, ''),
(31, 323, 'de jong', 'asd@sad', 324141, 'Masculino', 1, 'no'),
(32, 33, 'rodri', 'asd@sad', 21412, 'Masculino', 1, 'si'),
(33, 11, 'aspilicueta', 'asd@sad', 352234, 'Masculino', 1, 'no'),
(34, 11, 'rudiger', 'asd@sad', 342423234, 'Masculino', 1, 'no'),
(35, 11, 'rudiger', 'asd@sad', 342423234, 'Masculino', 1, 'no'),
(37, 3, 'abidal', 'asd@sad', 142323423, 'Masculino', 1, 'si'),
(38, 21, 'lukaku', 'asd@sad', 41423243, 'Masculino', 0, 'no'),
(39, 32, 'muller', 'asd@sad', 23123123, 'Masculino', 1, 'no'),
(40, 21, 'zlatan ibra', 'asd@sad', 213424234, 'Masculino', 0, 'si'),
(41, 32, 'kun', 'asd@sad', 431234234, 'Masculino', 0, 'no'),
(42, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(43, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(44, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(45, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(46, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(47, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(48, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(49, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(50, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(51, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(52, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(53, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(54, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(55, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(56, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(57, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(58, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(59, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(60, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(61, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(62, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(63, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(64, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(65, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(66, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(67, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(68, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(69, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(70, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(71, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(72, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(73, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(74, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(75, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(76, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(77, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(78, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(79, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(80, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(81, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(82, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(83, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(84, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(85, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(86, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(87, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(88, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(89, 22, 'messi', 'asd@sad', 3423421, 'Masculino', 0, 'no'),
(90, 23, 'fullkrug', 'asd@sad', 32423423, 'Masculino', 1, 'no');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnico`
--

CREATE TABLE `tecnico` (
  `id` int(11) NOT NULL,
  `pass` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnico`
--

INSERT INTO `tecnico` (`id`, `pass`) VALUES
(1, 'asda'),
(2, 'asda'),
(3, 'sisi');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoresreferencia`
--

CREATE TABLE `valoresreferencia` (
  `id` int(11) NOT NULL,
  `determinacionId` int(11) NOT NULL,
  `categoria` varchar(255) NOT NULL,
  `valorMin` varchar(100) NOT NULL,
  `valorMax` varchar(100) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `valoresreferencia`
--

INSERT INTO `valoresreferencia` (`id`, `determinacionId`, `categoria`, `valorMin`, `valorMax`, `activo`, `createdAt`, `updatedAt`) VALUES
(28, 22, 'Adultos Hombres', '13', '17', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(29, 21, 'Adultos Hombres', '40', '50', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(30, 20, 'Adultos Mujeres', '37', '47', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(31, 22, 'Adultos Mujeres', '12', '15', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(32, 20, 'Adultos', '4', '11', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(33, 23, 'todos', '200', '240', 1, '2024-07-29 01:34:21', '2024-08-08 01:51:24'),
(34, 24, 'todos', '99', '160', 1, '2024-07-29 22:07:54', '2024-07-29 22:07:54'),
(35, 24, 'Hombres', '40', '59', 1, '2024-07-29 22:07:54', '2024-07-29 22:07:54');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admistrativo`
--
ALTER TABLE `admistrativo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `bioquimico`
--
ALTER TABLE `bioquimico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `determinacion`
--
ALTER TABLE `determinacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `examenId` (`examenId`) USING BTREE;

--
-- Indices de la tabla `examen`
--
ALTER TABLE `examen`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `muestra`
--
ALTER TABLE `muestra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idExamen` (`examenId`);

--
-- Indices de la tabla `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_Administrativo` (`id_Administrativo`),
  ADD KEY `id_Bioquimico` (`id_Bioquimico`),
  ADD KEY `id_Examen` (`id_Examen`),
  ADD KEY `id_Paciente` (`id_Paciente`),
  ADD KEY `id_Tecnico` (`id_Tecnico`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `valoresreferencia`
--
ALTER TABLE `valoresreferencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `determinacionId` (`determinacionId`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admistrativo`
--
ALTER TABLE `admistrativo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bioquimico`
--
ALTER TABLE `bioquimico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `determinacion`
--
ALTER TABLE `determinacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `examen`
--
ALTER TABLE `examen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `muestra`
--
ALTER TABLE `muestra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `orden`
--
ALTER TABLE `orden`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `valoresreferencia`
--
ALTER TABLE `valoresreferencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `determinacion`
--
ALTER TABLE `determinacion`
  ADD CONSTRAINT `determinacion_ibfk_3` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `determinacion_ibfk_4` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`),
  ADD CONSTRAINT `determinacion_ibfk_5` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`),
  ADD CONSTRAINT `determinacion_ibfk_6` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`),
  ADD CONSTRAINT `determinacion_ibfk_7` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`),
  ADD CONSTRAINT `determinacion_ibfk_8` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `determinacion_ibfk_9` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `muestra`
--
ALTER TABLE `muestra`
  ADD CONSTRAINT `muestra_ibfk_1` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `muestra_ibfk_2` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`),
  ADD CONSTRAINT `muestra_ibfk_3` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`),
  ADD CONSTRAINT `muestra_ibfk_4` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `muestra_ibfk_5` FOREIGN KEY (`examenId`) REFERENCES `examen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_ibfk_1` FOREIGN KEY (`id_Administrativo`) REFERENCES `admistrativo` (`id`),
  ADD CONSTRAINT `orden_ibfk_2` FOREIGN KEY (`id_Bioquimico`) REFERENCES `bioquimico` (`id`),
  ADD CONSTRAINT `orden_ibfk_3` FOREIGN KEY (`id_Examen`) REFERENCES `examen` (`id`),
  ADD CONSTRAINT `orden_ibfk_4` FOREIGN KEY (`id_Paciente`) REFERENCES `paciente` (`id`),
  ADD CONSTRAINT `orden_ibfk_5` FOREIGN KEY (`id_Tecnico`) REFERENCES `tecnico` (`id`);

--
-- Filtros para la tabla `valoresreferencia`
--
ALTER TABLE `valoresreferencia`
  ADD CONSTRAINT `valoresreferencia_ibfk_1` FOREIGN KEY (`determinacionId`) REFERENCES `determinacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `valoresreferencia_ibfk_2` FOREIGN KEY (`determinacionId`) REFERENCES `determinacion` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `valoresreferencia_ibfk_3` FOREIGN KEY (`determinacionId`) REFERENCES `determinacion` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `valoresreferencia_ibfk_4` FOREIGN KEY (`determinacionId`) REFERENCES `determinacion` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `valoresreferencia_ibfk_5` FOREIGN KEY (`determinacionId`) REFERENCES `determinacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
