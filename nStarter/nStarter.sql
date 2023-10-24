CREATE TABLE `nstarter` (
  `identifier` varchar(60) NOT NULL,
  `starter` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `nstarter`
  ADD PRIMARY KEY (`identifier`);
COMMIT;