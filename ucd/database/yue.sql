CREATE DATABASE IF NOT EXISTS cards;

USE cards;

DROP TABLE IF EXISTS poker_values;

DROP TABLE IF EXISTS standard_deck;

CREATE TABLE standard_deck (
    ShortHand varchar(3) NOT NULL,
    Position tinyint NOT NULL,
    Suit varchar(10) NOT NULL,
    Sort tinyint NOT NULL,
    Type varchar(6),
    PRIMARY KEY(ShortHand)
);

INSERT INTO standard_deck VALUES("1S",1,"spades",1,"number");
INSERT INTO standard_deck VALUES("2S",2,"spades",2,"number");
INSERT INTO standard_deck VALUES("3S",3,"spades",3,"number");
INSERT INTO standard_deck VALUES("4S",4,"spades",4,"number");
INSERT INTO standard_deck VALUES("5S",5,"spades",5,"number");
INSERT INTO standard_deck VALUES("6S",6,"spades",6,"number");
INSERT INTO standard_deck VALUES("7S",7,"spades",7,"number");
INSERT INTO standard_deck VALUES("8S",8,"spades",8,"number");
INSERT INTO standard_deck VALUES("9S",9,"spades",9,"number");
INSERT INTO standard_deck VALUES("10S",10,"spades",10,"number");
INSERT INTO standard_deck VALUES("JS",11,"spades",11,"face");
INSERT INTO standard_deck VALUES("QS",12,"spades",12,"face");
INSERT INTO standard_deck VALUES("KS",13,"spades",13,"face");

INSERT INTO standard_deck VALUES("1C",14,"clubs",1,"number");
INSERT INTO standard_deck VALUES("2C",15,"clubs",2,"number");
INSERT INTO standard_deck VALUES("3C",16,"clubs",3,"number");
INSERT INTO standard_deck VALUES("4C",17,"clubs",4,"number");
INSERT INTO standard_deck VALUES("5C",18,"clubs",5,"number");
INSERT INTO standard_deck VALUES("6C",19,"clubs",6,"number");
INSERT INTO standard_deck VALUES("7C",20,"clubs",7,"number");
INSERT INTO standard_deck VALUES("8C",21,"clubs",8,"number");
INSERT INTO standard_deck VALUES("9C",22,"clubs",9,"number");
INSERT INTO standard_deck VALUES("10C",23,"clubs",10,"number");
INSERT INTO standard_deck VALUES("JC",24,"clubs",11,"face");
INSERT INTO standard_deck VALUES("QC",25,"clubs",12,"face");
INSERT INTO standard_deck VALUES("KC",26,"clubs",13,"face");

INSERT INTO standard_deck VALUES("1H",27,"hearts",1,"number");
INSERT INTO standard_deck VALUES("2H",28,"hearts",2,"number");
INSERT INTO standard_deck VALUES("3H",29,"hearts",3,"number");
INSERT INTO standard_deck VALUES("4H",30,"hearts",4,"number");
INSERT INTO standard_deck VALUES("5H",31,"hearts",5,"number");
INSERT INTO standard_deck VALUES("6H",32,"hearts",6,"number");
INSERT INTO standard_deck VALUES("7H",33,"hearts",7,"number");
INSERT INTO standard_deck VALUES("8H",34,"hearts",8,"number");
INSERT INTO standard_deck VALUES("9H",35,"hearts",9,"number");
INSERT INTO standard_deck VALUES("10H",36,"hearts",10,"number");
INSERT INTO standard_deck VALUES("JH",37,"hearts",11,"face");
INSERT INTO standard_deck VALUES("QH",38,"hearts",12,"face");
INSERT INTO standard_deck VALUES("KH",39,"hearts",13,"face");

INSERT INTO standard_deck VALUES("1D",40,"diamonds",1,"number");
INSERT INTO standard_deck VALUES("2D",41,"diamonds",2,"number");
INSERT INTO standard_deck VALUES("3D",42,"diamonds",3,"number");
INSERT INTO standard_deck VALUES("4D",43,"diamonds",4,"number");
INSERT INTO standard_deck VALUES("5D",44,"diamonds",5,"number");
INSERT INTO standard_deck VALUES("6D",45,"diamonds",6,"number");
INSERT INTO standard_deck VALUES("7D",46,"diamonds",7,"number");
INSERT INTO standard_deck VALUES("8D",47,"diamonds",8,"number");
INSERT INTO standard_deck VALUES("9D",48,"diamonds",9,"number");
INSERT INTO standard_deck VALUES("10D",49,"diamonds",10,"number");
INSERT INTO standard_deck VALUES("JD",50,"diamonds",11,"face");
INSERT INTO standard_deck VALUES("QD",51,"diamonds",12,"face");
INSERT INTO standard_deck VALUES("KD",52,"diamonds",13,"face");

CREATE TABLE poker_values (
    ShortHand varchar(3) NOT NULL,
    Value int NOT NULL,
    PRIMARY KEY (ShortHand),
    FOREIGN KEY (ShortHand) REFERENCES standard_deck(ShortHand)
);

INSERT INTO poker_values(ShortHand, value) VALUES("2S",2);
INSERT INTO poker_values(ShortHand, value) VALUES("3S",3);
INSERT INTO poker_values(ShortHand, value) VALUES("4S",4);
INSERT INTO poker_values(ShortHand, value) VALUES("5S",5);
INSERT INTO poker_values(ShortHand, value) VALUES("6S",6);
INSERT INTO poker_values(ShortHand, value) VALUES("7S",7);
INSERT INTO poker_values(ShortHand, value) VALUES("8S",8);
INSERT INTO poker_values(ShortHand, value) VALUES("9S",9);
INSERT INTO poker_values(ShortHand, value) VALUES("10S",10);
INSERT INTO poker_values(ShortHand, value) VALUES("JS",11);
INSERT INTO poker_values(ShortHand, value) VALUES("QS",12);
INSERT INTO poker_values(ShortHand, value) VALUES("KS",13);
INSERT INTO poker_values(ShortHand, value) VALUES("1S",14);

INSERT INTO poker_values(ShortHand, value) VALUES("2C",2);
INSERT INTO poker_values(ShortHand, value) VALUES("3C",3);
INSERT INTO poker_values(ShortHand, value) VALUES("4C",4);
INSERT INTO poker_values(ShortHand, value) VALUES("5C",5);
INSERT INTO poker_values(ShortHand, value) VALUES("6C",6);
INSERT INTO poker_values(ShortHand, value) VALUES("7C",7);
INSERT INTO poker_values(ShortHand, value) VALUES("8C",8);
INSERT INTO poker_values(ShortHand, value) VALUES("9C",9);
INSERT INTO poker_values(ShortHand, value) VALUES("10C",10);
INSERT INTO poker_values(ShortHand, value) VALUES("JC",11);
INSERT INTO poker_values(ShortHand, value) VALUES("QC",12);
INSERT INTO poker_values(ShortHand, value) VALUES("KC",13);
INSERT INTO poker_values(ShortHand, value) VALUES("1C",14);

INSERT INTO poker_values(ShortHand, value) VALUES("2H",2);
INSERT INTO poker_values(ShortHand, value) VALUES("3H",3);
INSERT INTO poker_values(ShortHand, value) VALUES("4H",4);
INSERT INTO poker_values(ShortHand, value) VALUES("5H",5);
INSERT INTO poker_values(ShortHand, value) VALUES("6H",6);
INSERT INTO poker_values(ShortHand, value) VALUES("7H",7);
INSERT INTO poker_values(ShortHand, value) VALUES("8H",8);
INSERT INTO poker_values(ShortHand, value) VALUES("9H",9);
INSERT INTO poker_values(ShortHand, value) VALUES("10H",10);
INSERT INTO poker_values(ShortHand, value) VALUES("JH",11);
INSERT INTO poker_values(ShortHand, value) VALUES("QH",12);
INSERT INTO poker_values(ShortHand, value) VALUES("KH",13);
INSERT INTO poker_values(ShortHand, value) VALUES("1H",14);

INSERT INTO poker_values(ShortHand, value) VALUES("2D",2);
INSERT INTO poker_values(ShortHand, value) VALUES("3D",3);
INSERT INTO poker_values(ShortHand, value) VALUES("4D",4);
INSERT INTO poker_values(ShortHand, value) VALUES("5D",5);
INSERT INTO poker_values(ShortHand, value) VALUES("6D",6);
INSERT INTO poker_values(ShortHand, value) VALUES("7D",7);
INSERT INTO poker_values(ShortHand, value) VALUES("8D",8);
INSERT INTO poker_values(ShortHand, value) VALUES("9D",9);
INSERT INTO poker_values(ShortHand, value) VALUES("10D",10);
INSERT INTO poker_values(ShortHand, value) VALUES("JD",11);
INSERT INTO poker_values(ShortHand, value) VALUES("QD",12);
INSERT INTO poker_values(ShortHand, value) VALUES("KD",13);
INSERT INTO poker_values(ShortHand, value) VALUES("1D",14);


DROP TABLE IF EXISTS poker_hands;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    ShortHand int NOT NULL AUTO_INCREMENT,
    Name varchar(30) NOT NULL,
    PRIMARY KEY(ShortHand)
);

INSERT INTO users (Name) VALUES("User1");
INSERT INTO users (Name) VALUES("User2");
INSERT INTO users (Name) VALUES("User3");
INSERT INTO users (Name) VALUES("User4");
INSERT INTO users (Name) VALUES("User5");


CREATE TABLE poker_hands (
    ShortHand int NOT NULL AUTO_INCREMENT,
    UserId int NOT NULL,
    GameId int NOT NULL,
    CardId varchar(3) NOT NULL,
    PRIMARY KEY(ShortHand),
    FOREIGN KEY (UserId) REFERENCES users(ShortHand) ON DELETE CASCADE
);

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 1, "7C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 1, "7D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 1, "7H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 1, "7S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 1, "2S");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 1, "5C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 1, "5D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 1, "5H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 1, "QD");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 1, "KH");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 1, "8C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 1, "9C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 1, "10C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 1, "JC");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 1, "QC");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 1, "6C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 1, "4S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 1, "9H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 1, "10H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 1, "1C");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 1, "KD");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 1, "10S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 1, "1H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 1, "JH");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 1, "3H");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 2, "KC");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 2, "KD");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 2, "KH");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 2, "KS");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 2, "6H");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 2, "3C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 2, "3D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 2, "3H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 2, "2D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 2, "4D");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 2, "8C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 2, "9C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 2, "10C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 2, "JC");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 2, "QC");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 2, "QS");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 2, "9H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 2, "4S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 2, "2H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 2, "7S");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 2, "10S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 2, "JD");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 2, "1C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 2, "8D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 2, "6S");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 3, "9C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 3, "9D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 3, "9H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 3, "9S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 3, "2D");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 3, "QC");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 3, "QD");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 3, "QH");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 3, "1H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 3, "1S");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 3, "4C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 3, "5C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 3, "6C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 3, "7C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 3, "8C");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 3, "6H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 3, "8H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 3, "KS");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 3, "10C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 3, "QS");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 3, "7S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 3, "2H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 3, "10D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 3, "3D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 3, "2C");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 4, "JC");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 4, "JD");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 4, "JH");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 4, "JS");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(1, 4, "7D");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 4, "5C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 4, "5D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 4, "5H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 4, "3H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(2, 4, "6S");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 4, "6C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 4, "7C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 4, "8C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 4, "9C");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(3, 4, "10C");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 4, "3D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 4, "5S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 4, "4H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 4, "2H");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(4, 4, "1C");

INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 4, "KC");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 4, "3S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 4, "10S");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 4, "9D");
INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(5, 4, "3C");

/* Q1 */
SELECT h1.CardId, h2.CardId, h3.CardId, h4.CardId, h5.CardId 
FROM poker_hands h1, poker_hands h2, poker_hands h3, poker_hands h4, poker_hands h5,
	 poker_values v1, poker_values v2, poker_values v3, poker_values v4, poker_values v5
WHERE h1.UserId = h2.UserId AND h2.UserId = h3.UserId AND h3.UserId = h4.UserId AND h4.UserId = h5.UserId
AND	h1.GameId = h2.GameId AND h2.GameId = h3.GameId AND h3.GameId = h4.GameId AND h4.GameId = h5.GameId
AND h1.CardId = v1.ShortHand AND h2.CardId = v2.ShortHand AND h3.CardId = v3.ShortHand AND h4.CardId = v4.ShortHand AND h5.CardId = v5.ShortHand
AND v1.value = v2.value AND v2.value = v3.value AND v3.value = v4.value AND v5.value <> v1.value
AND v1.ShortHand < v2.ShortHand AND v2.ShortHand < v3.ShortHand AND v3.ShortHand < v4.ShortHand;

/* Q2 */
SELECT h1.CardId, h2.CardId, h3.CardId, h4.CardId, h5.CardId 
FROM poker_hands h1, poker_hands h2, poker_hands h3, poker_hands h4, poker_hands h5,
	 poker_values v1, poker_values v2, poker_values v3, poker_values v4, poker_values v5
WHERE h1.UserId = h2.UserId AND h2.UserId = h3.UserId AND h3.UserId = h4.UserId AND h4.UserId = h5.UserId
AND	h1.GameId = h2.GameId AND h2.GameId = h3.GameId AND h3.GameId = h4.GameId AND h4.GameId = h5.GameId
AND h1.CardId = v1.ShortHand AND h2.CardId = v2.ShortHand AND h3.CardId = v3.ShortHand AND h4.CardId = v4.ShortHand AND h5.CardId = v5.ShortHand
AND v1.value = v2.value AND v2.value = v3.value AND v4.value <> v1.value AND v5.value <> v1.value
AND v1.ShortHand < v2.ShortHand AND v2.ShortHand < v3.ShortHand AND v4.ShortHand < v5.ShortHand;

/* Q3 */
SELECT h1.CardId card1, h2.CardId card2, h3.CardId card3, h4.CardId card4, h5.CardId card5
FROM poker_hands h1, poker_hands h2, poker_hands h3, poker_hands h4, poker_hands h5,
    poker_values v1, poker_values v2, poker_values v3, poker_values v4, poker_values v5,
    standard_deck d1, standard_deck d2, standard_deck d3, standard_deck d4, standard_deck d5
WHERE h1.UserId = h2.UserId AND h2.UserId = h3.UserId AND h3.UserId = h4.UserId AND h4.UserId = h5.UserId
AND	h1.GameId = h2.GameId AND h2.GameId = h3.GameId AND h3.GameId = h4.GameId AND h4.GameId = h5.GameId
AND h1.CardId = v1.ShortHand AND h2.CardId = v2.ShortHand AND h3.CardId = v3.ShortHand AND h4.CardId = v4.ShortHand AND h5.CardId = v5.ShortHand
AND v1.value = v2.value-1 AND v2.value = v3.value-1 AND v3.value = v4.value-1 AND v4.value = v5.value-1
AND h1.CardId = d1.ShortHand AND h2.CardId = d2.ShortHand AND h3.CardId = d3.ShortHand AND h4.CardId = d4.ShortHand AND h5.CardId = d5.ShortHand
AND d1.suit = d2.suit AND d2.suit = d3.suit AND d3.suit = d4.suit AND d4.suit = d5.suit;