# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: aws3.remote.lucadanelutti.it (MySQL 5.7.32)
# Database: marketing_application
# Generation Time: 2021-02-20 18:03:01 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table login_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `login_logs`;

CREATE TABLE `login_logs` (
  `timestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `user_id` int(10) unsigned NOT NULL,
  `compilation_requested` tinyint(1) NOT NULL,
  `compilation_completed` tinyint(1) NOT NULL,
  PRIMARY KEY (`timestamp`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `login_logs` WRITE;
/*!40000 ALTER TABLE `login_logs` DISABLE KEYS */;

INSERT INTO `login_logs` (`timestamp`, `user_id`, `compilation_requested`, `compilation_completed`)
VALUES
	('2021-02-20 17:59:25.813',1,1,0);

/*!40000 ALTER TABLE `login_logs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table offensive_words
# ------------------------------------------------------------

DROP TABLE IF EXISTS `offensive_words`;

CREATE TABLE `offensive_words` (
  `word` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `offensive_words` WRITE;
/*!40000 ALTER TABLE `offensive_words` DISABLE KEYS */;

INSERT INTO `offensive_words` (`word`)
VALUES
	('db2'),
	('jpa');

/*!40000 ALTER TABLE `offensive_words` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_reviews
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_reviews`;

CREATE TABLE `product_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionnaire_id` int(10) unsigned NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `questionnaire_id` (`questionnaire_id`),
  CONSTRAINT `product_reviews_ibfk_1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;

INSERT INTO `product_reviews` (`id`, `questionnaire_id`, `value`)
VALUES
	(1,1,'Good product'),
	(3,1,'Excellent choice!'),
	(4,2,'WOW'),
	(5,2,'Good choice!');

/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table questionnaires
# ------------------------------------------------------------

DROP TABLE IF EXISTS `questionnaires`;

CREATE TABLE `questionnaires` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `image` blob NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

LOCK TABLES `questionnaires` WRITE;
/*!40000 ALTER TABLE `questionnaires` DISABLE KEYS */;

INSERT INTO `questionnaires` (`id`, `name`, `image`, `date`)
VALUES
	(1,'Example past questionnaire',X'4141','2021-02-01'),
	(2,'Example questionnaire',X'4141','2021-02-20');

/*!40000 ALTER TABLE `questionnaires` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table questions_marketing
# ------------------------------------------------------------

DROP TABLE IF EXISTS `questions_marketing`;

CREATE TABLE `questions_marketing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionnaire_id` int(10) unsigned NOT NULL,
  `question` varchar(256) NOT NULL DEFAULT '',
  `type` enum('BOOL','STRING','NUMBER','RATING') NOT NULL DEFAULT 'STRING',
  PRIMARY KEY (`id`),
  KEY `questionnaire_id` (`questionnaire_id`),
  CONSTRAINT `questions_marketing_ibfk_1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

LOCK TABLES `questions_marketing` WRITE;
/*!40000 ALTER TABLE `questions_marketing` DISABLE KEYS */;

INSERT INTO `questions_marketing` (`id`, `questionnaire_id`, `question`, `type`)
VALUES
	(1,2,'Test marketing question type STRING','STRING'),
	(2,2,'Test marketing question type BOOL','BOOL'),
	(3,2,'Test marketing question type NUMBER','NUMBER');

/*!40000 ALTER TABLE `questions_marketing` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table questions_stats
# ------------------------------------------------------------

DROP TABLE IF EXISTS `questions_stats`;

CREATE TABLE `questions_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` varchar(256) NOT NULL DEFAULT '',
  `type` enum('BOOL','STRING','NUMBER','RATING') NOT NULL DEFAULT 'STRING',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

LOCK TABLES `questions_stats` WRITE;
/*!40000 ALTER TABLE `questions_stats` DISABLE KEYS */;

INSERT INTO `questions_stats` (`id`, `question`, `type`)
VALUES
	(1,'Test stats quesion type STRING','STRING'),
	(2,'Test stats quesion type BOOL','BOOL'),
	(3,'Test stats quesion type NUMBER','NUMBER');

/*!40000 ALTER TABLE `questions_stats` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table replies_marketing
# ------------------------------------------------------------

DROP TABLE IF EXISTS `replies_marketing`;

CREATE TABLE `replies_marketing` (
  `questions_marketing_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`questions_marketing_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `replies_marketing_ibfk_1` FOREIGN KEY (`questions_marketing_id`) REFERENCES `questions_marketing` (`id`),
  CONSTRAINT `replies_marketing_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`%` */ /*!50003 TRIGGER `new_reply_marketing` AFTER INSERT ON `replies_marketing` FOR EACH ROW BEGIN
	if exists(select * from marketing_application.scores where new.user_id=user_id and questionnaire_id=(select questionnaire_id from questions_marketing where id=new.questions_marketing_id) ) then
		update scores set score=score+1 where new.user_id=user_id and questionnaire_id=(select questionnaire_id from questions_marketing where id=new.questions_marketing_id);
    else
		insert into scores values ( (select questionnaire_id from questions_marketing where id=new.questions_marketing_id),new.user_id, 1);
	end if;
END */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table replies_stats
# ------------------------------------------------------------

DROP TABLE IF EXISTS `replies_stats`;

CREATE TABLE `replies_stats` (
  `questionnaire_id` int(10) unsigned NOT NULL,
  `question_stats_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`questionnaire_id`,`question_stats_id`,`user_id`),
  KEY `question_stats_id` (`question_stats_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `replies_stats_ibfk_1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`),
  CONSTRAINT `replies_stats_ibfk_2` FOREIGN KEY (`question_stats_id`) REFERENCES `questions_stats` (`id`),
  CONSTRAINT `replies_stats_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`%` */ /*!50003 TRIGGER `new_reply_stats` AFTER INSERT ON `replies_stats` FOR EACH ROW BEGIN

	if exists(select * from marketing_application.scores where new.user_id=user_id and questionnaire_id=new.questionnaire_id) then
		update scores set score=score+2 where new.user_id=user_id  and questionnaire_id=new.questionnaire_id;
	else
		insert into scores values ( new.questionnaire_id,new.user_id, 1);
	end if;
END */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table scores
# ------------------------------------------------------------

DROP TABLE IF EXISTS `scores`;

CREATE TABLE `scores` (
  `questionnaire_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `score` int(11) NOT NULL,
  PRIMARY KEY (`questionnaire_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`),
  CONSTRAINT `scores_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;

INSERT INTO `scores` (`questionnaire_id`, `user_id`, `score`)
VALUES
	(1,1,4),
	(1,2,3),
	(2,1,39);

/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(32) NOT NULL DEFAULT '',
  `banned` float NOT NULL DEFAULT '0',
  `isAdmin` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `password`, `email`, `banned`, `isAdmin`)
VALUES
	(1,'user1','user','example@example.com',0,0),
	(2,'user2','user','example@example.com',1,0),
	(3,'admin','admin','admin@admin.com',0,1);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
