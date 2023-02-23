CREATE SCHEMA IF NOT EXISTS cards;

USE cards;

DROP TABLE IF EXISTS poker_values;
DROP TABLE IF EXISTS standard_deck;

CREATE TABLE standard_deck (
    id varchar(3) NOT NULL COMMENT 'short hand name',
    position tinyint NOT NULL,
    suit varchar(8) NOT NULL,
    `rank` tinyint NOT NULL,
    `type` varchar(6),
    PRIMARY KEY(id)
);

INSERT INTO standard_deck VALUES("1H",1,"hearts",1,"number");
INSERT INTO standard_deck VALUES("2H",2,"hearts",2,"number");
INSERT INTO standard_deck VALUES("3H",3,"hearts",3,"number");
INSERT INTO standard_deck VALUES("4H",4,"hearts",4,"number");
INSERT INTO standard_deck VALUES("5H",5,"hearts",5,"number");
INSERT INTO standard_deck VALUES("6H",6,"hearts",6,"number");
INSERT INTO standard_deck VALUES("7H",7,"hearts",7,"number");
INSERT INTO standard_deck VALUES("8H",8,"hearts",8,"number");
INSERT INTO standard_deck VALUES("9H",9,"hearts",9,"number");
INSERT INTO standard_deck VALUES("10H",10,"hearts",10,"number");
INSERT INTO standard_deck VALUES("JH",11,"hearts",11,"face");
INSERT INTO standard_deck VALUES("QH",12,"hearts",12,"face");
INSERT INTO standard_deck VALUES("KH",13,"hearts",13,"face");

INSERT INTO standard_deck VALUES("1D",14,"diamonds",1,"number");
INSERT INTO standard_deck VALUES("2D",15,"diamonds",2,"number");
INSERT INTO standard_deck VALUES("3D",16,"diamonds",3,"number");
INSERT INTO standard_deck VALUES("4D",17,"diamonds",4,"number");
INSERT INTO standard_deck VALUES("5D",18,"diamonds",5,"number");
INSERT INTO standard_deck VALUES("6D",19,"diamonds",6,"number");
INSERT INTO standard_deck VALUES("7D",20,"diamonds",7,"number");
INSERT INTO standard_deck VALUES("8D",21,"diamonds",8,"number");
INSERT INTO standard_deck VALUES("9D",22,"diamonds",9,"number");
INSERT INTO standard_deck VALUES("10D",23,"diamonds",10,"number");
INSERT INTO standard_deck VALUES("JD",24,"diamonds",11,"face");
INSERT INTO standard_deck VALUES("QD",25,"diamonds",12,"face");
INSERT INTO standard_deck VALUES("KD",26,"diamonds",13,"face");

INSERT INTO standard_deck VALUES("1C",27,"clubs",1,"number");
INSERT INTO standard_deck VALUES("2C",28,"clubs",2,"number");
INSERT INTO standard_deck VALUES("3C",29,"clubs",3,"number");
INSERT INTO standard_deck VALUES("4C",30,"clubs",4,"number");
INSERT INTO standard_deck VALUES("5C",31,"clubs",5,"number");
INSERT INTO standard_deck VALUES("6C",32,"clubs",6,"number");
INSERT INTO standard_deck VALUES("7C",33,"clubs",7,"number");
INSERT INTO standard_deck VALUES("8C",34,"clubs",8,"number");
INSERT INTO standard_deck VALUES("9C",35,"clubs",9,"number");
INSERT INTO standard_deck VALUES("10C",36,"clubs",10,"number");
INSERT INTO standard_deck VALUES("JC",37,"clubs",11,"face");
INSERT INTO standard_deck VALUES("QC",38,"clubs",12,"face");
INSERT INTO standard_deck VALUES("KC",39,"clubs",13,"face");

INSERT INTO standard_deck VALUES("1S",40,"spades",1,"number");
INSERT INTO standard_deck VALUES("2S",41,"spades",2,"number");
INSERT INTO standard_deck VALUES("3S",42,"spades",3,"number");
INSERT INTO standard_deck VALUES("4S",43,"spades",4,"number");
INSERT INTO standard_deck VALUES("5S",44,"spades",5,"number");
INSERT INTO standard_deck VALUES("6S",45,"spades",6,"number");
INSERT INTO standard_deck VALUES("7S",46,"spades",7,"number");
INSERT INTO standard_deck VALUES("8S",47,"spades",8,"number");
INSERT INTO standard_deck VALUES("9S",48,"spades",9,"number");
INSERT INTO standard_deck VALUES("10S",49,"spades",10,"number");
INSERT INTO standard_deck VALUES("JS",50,"spades",11,"face");
INSERT INTO standard_deck VALUES("QS",51,"spades",12,"face");
INSERT INTO standard_deck VALUES("KS",52,"spades",13,"face");

CREATE TABLE poker_values (
    id varchar(3) NOT NULL,
    `value` int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES standard_deck(id)
);

INSERT INTO poker_values(id, value) VALUES("2H",2);
INSERT INTO poker_values(id, value) VALUES("3H",3);
INSERT INTO poker_values(id, value) VALUES("4H",4);
INSERT INTO poker_values(id, value) VALUES("5H",5);
INSERT INTO poker_values(id, value) VALUES("6H",6);
INSERT INTO poker_values(id, value) VALUES("7H",7);
INSERT INTO poker_values(id, value) VALUES("8H",8);
INSERT INTO poker_values(id, value) VALUES("9H",9);
INSERT INTO poker_values(id, value) VALUES("10H",10);
INSERT INTO poker_values(id, value) VALUES("JH",11);
INSERT INTO poker_values(id, value) VALUES("QH",12);
INSERT INTO poker_values(id, value) VALUES("KH",13);
INSERT INTO poker_values(id, value) VALUES("1H",14);

INSERT INTO poker_values(id, value) VALUES("2D",2);
INSERT INTO poker_values(id, value) VALUES("3D",3);
INSERT INTO poker_values(id, value) VALUES("4D",4);
INSERT INTO poker_values(id, value) VALUES("5D",5);
INSERT INTO poker_values(id, value) VALUES("6D",6);
INSERT INTO poker_values(id, value) VALUES("7D",7);
INSERT INTO poker_values(id, value) VALUES("8D",8);
INSERT INTO poker_values(id, value) VALUES("9D",9);
INSERT INTO poker_values(id, value) VALUES("10D",10);
INSERT INTO poker_values(id, value) VALUES("JD",11);
INSERT INTO poker_values(id, value) VALUES("QD",12);
INSERT INTO poker_values(id, value) VALUES("KD",13);
INSERT INTO poker_values(id, value) VALUES("1D",14);

INSERT INTO poker_values(id, value) VALUES("2C",2);
INSERT INTO poker_values(id, value) VALUES("3C",3);
INSERT INTO poker_values(id, value) VALUES("4C",4);
INSERT INTO poker_values(id, value) VALUES("5C",5);
INSERT INTO poker_values(id, value) VALUES("6C",6);
INSERT INTO poker_values(id, value) VALUES("7C",7);
INSERT INTO poker_values(id, value) VALUES("8C",8);
INSERT INTO poker_values(id, value) VALUES("9C",9);
INSERT INTO poker_values(id, value) VALUES("10C",10);
INSERT INTO poker_values(id, value) VALUES("JC",11);
INSERT INTO poker_values(id, value) VALUES("QC",12);
INSERT INTO poker_values(id, value) VALUES("KC",13);
INSERT INTO poker_values(id, value) VALUES("1C",14);

INSERT INTO poker_values(id, value) VALUES("2S",2);
INSERT INTO poker_values(id, value) VALUES("3S",3);
INSERT INTO poker_values(id, value) VALUES("4S",4);
INSERT INTO poker_values(id, value) VALUES("5S",5);
INSERT INTO poker_values(id, value) VALUES("6S",6);
INSERT INTO poker_values(id, value) VALUES("7S",7);
INSERT INTO poker_values(id, value) VALUES("8S",8);
INSERT INTO poker_values(id, value) VALUES("9S",9);
INSERT INTO poker_values(id, value) VALUES("10S",10);
INSERT INTO poker_values(id, value) VALUES("JS",11);
INSERT INTO poker_values(id, value) VALUES("QS",12);
INSERT INTO poker_values(id, value) VALUES("KS",13);
INSERT INTO poker_values(id, value) VALUES("1S",14);


DROP TABLE IF EXISTS poker_hands;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id int NOT NULL AUTO_INCREMENT,
    `name` varchar(30) NOT NULL,
    PRIMARY KEY(id)
);

INSERT INTO users (name) VALUES("James Bond");
INSERT INTO users (name) VALUES("John Wick");
INSERT INTO users (name) VALUES("Harry Poter");
INSERT INTO users (name) VALUES("Yan Huan");


CREATE TABLE poker_hands (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    game_id int NOT NULL,
    card_id varchar(3) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

/* Five games, and each game has four users */
/* game 1 - user 1 - four of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 1, "KC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 1, "KD");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 1, "KH");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 1, "KS");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 1, "5S");

/* game 1 - user 2 - three of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 1, "7C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 1, "7D");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 1, "7H");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 1, "9S");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 1, "QD");

/* game 1 - user 3 - straight flush */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 1, "2C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 1, "3C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 1, "4C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 1, "5C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 1, "6C");

/* game 1 - user 4 - bad hand */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 1, "1C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 1, "9C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 1, "QC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 1, "JC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 1, "8C");

/* game 2 - user 1 - four of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 2, "QC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 2, "QD");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 2, "QH");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 2, "QS");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 2, "8H");

/* game 2 - user 2 - three of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 2, "3C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 2, "3D");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 2, "3H");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 2, "KH");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 2, "5D");

/* game 2 - user 3 - straight flush */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 2, "7C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 2, "8C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 2, "9C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 2, "10C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 2, "JC");

/* game 2 - user 4 - bad hand */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 2, "6C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 2, "1C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 2, "5C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 2, "2C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 2, "KC");

/* game 3 - user 1 - four of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 3, "10C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 3, "10D");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 3, "10H");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 3, "10S");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 3, "QH");

/* game 3 - user 2 - three of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 3, "1C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 3, "1D");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 3, "1H");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 3, "8S");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 3, "5D");

/* game 3 - user 3 - straight flush */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 3, "3C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 3, "4C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 3, "5C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 3, "6C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 3, "7C");

/* game 3 - user 4 - bad hand */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 3, "8C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 3, "QC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 3, "JC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 3, "2C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 3, "9C");

/* game 4 - user 1 - four of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 4, "JC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 4, "JD");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 4, "JH");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 4, "JS");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 4, "4H");

/* game 4 - user 2 - three of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 4, "5C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 4, "5D");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 4, "5H");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 4, "4S");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 4, "1S");

/* game 4 - user 3 - straight flush */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 4, "6C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 4, "7C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 4, "8C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 4, "9C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 4, "10C");

/* game 4 - user 4 - bad hand */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 4, "QC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 4, "1C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 4, "4C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 4, "3C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 4, "KC");

/* game 5 - user 1 - four of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 5, "3C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 5, "3D");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 5, "3H");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 5, "3S");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(1, 5, "8D");

/* game 5 - user 2 - three of a kind */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 5, "9C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 5, "9D");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 5, "9H");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 5, "10D");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(2, 5, "KD");

/* game 5 - user 3 - straight flush */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 5, "4C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 5, "5C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 5, "6C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 5, "7C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(3, 5, "8C");

/* game 5 - user 4 - bad hand */
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 5, "KC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 5, "2C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 5, "JC");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 5, "1C");
INSERT INTO poker_hands (user_id, game_id, card_id) VALUES(4, 5, "QC");


/* Q1 */
SELECT h1.card_id as card1, h2.card_id as card2, h3.card_id as card3, h4.card_id as card4, h5.card_id as card5
FROM poker_hands as h1, poker_hands as h2, poker_hands as h3, poker_hands as h4, poker_hands as h5, 
    poker_values as v1, poker_values as v2, poker_values as v3, poker_values as v4, poker_values as v5
WHERE h1.user_id = h2.user_id AND h2.user_id = h3.user_id AND h3.user_id = h4.user_id AND h4.user_id = h5.user_id
AND	h1.game_id = h2.game_id AND h1.game_id = h3.game_id AND h1.game_id = h4.game_id AND h1.game_id = h5.game_id
AND h1.card_id = v1.id AND h2.card_id = v2.id AND h3.card_id = v3.id AND h4.card_id = v4.id AND h5.card_id = v5.id
AND v1.value = v2.value AND v1.value = v3.value AND v1.value = v4.value
AND v1.value <> v5.value
AND v1.id < v2.id AND v2.id < v3.id AND v3.id < v4.id;


/* Q2 */
SELECT h1.card_id as card1, h2.card_id as card2, h3.card_id as card3, h4.card_id as card4, h5.card_id as card5
FROM poker_hands as h1, poker_hands as h2, poker_hands as h3, poker_hands as h4, poker_hands as h5,
    poker_values as v1, poker_values as v2, poker_values as v3, poker_values as v4, poker_values as v5
WHERE h1.user_id = h2.user_id AND h2.user_id = h3.user_id AND h3.user_id = h4.user_id AND h4.user_id = h5.user_id
AND	h1.game_id = h2.game_id AND h2.game_id = h3.game_id AND h3.game_id = h4.game_id AND h4.game_id = h5.game_id
AND h1.card_id = v1.id AND h2.card_id = v2.id AND h3.card_id = v3.id AND h4.card_id = v4.id AND h5.card_id = v5.id
AND v1.value = v2.value AND v2.value = v3.value
AND v4.value <> v1.value
AND v5.value <> v1.value
AND v1.id < v2.id AND v2.id < v3.id AND v4.id < v5.id;

/* Q3 */
SELECT h1.card_id as card1, h2.card_id as card2, h3.card_id as card3, h4.card_id as card4, h5.card_id as card5
FROM poker_hands as h1, poker_hands as h2, poker_hands as h3, poker_hands as h4, poker_hands as h5,
    poker_values as v1, poker_values as v2, poker_values as v3, poker_values as v4, poker_values as v5,
    standard_deck as d1, standard_deck as d2, standard_deck as d3, standard_deck as d4, standard_deck as d5
WHERE h1.user_id = h2.user_id AND h2.user_id = h3.user_id AND h3.user_id = h4.user_id AND h4.user_id = h5.user_id
AND	h1.game_id = h2.game_id AND h2.game_id = h3.game_id AND h3.game_id = h4.game_id AND h4.game_id = h5.game_id
AND h1.card_id = v1.id AND h2.card_id = v2.id AND h3.card_id = v3.id AND h4.card_id = v4.id AND h5.card_id = v5.id
AND v1.value = v2.value-1 AND v2.value = v3.value-1 AND v3.value = v4.value-1 AND v4.value = v5.value-1
AND h1.card_id = d1.id AND h2.card_id = d2.id AND h3.card_id = d3.id AND h4.card_id = d4.id AND h5.card_id = d5.id
AND d1.suit = d2.suit AND d2.suit = d3.suit AND d3.suit = d4.suit AND d4.suit = d5.suit;