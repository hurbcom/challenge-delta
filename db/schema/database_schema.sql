USE `packages`

CREATE TABLE `offer` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Text` varchar(255) NOT NULL,
  `CreateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

INSERT INTO offer (`Text`) VALUES ('Offer 1');
INSERT INTO offer (`Text`) VALUES ('Offer 2');
INSERT INTO offer (`Text`) VALUES ('Offer 3');
INSERT INTO offer (`Text`) VALUES ('Offer 4');
INSERT INTO offer (`Text`) VALUES ('Offer 5');