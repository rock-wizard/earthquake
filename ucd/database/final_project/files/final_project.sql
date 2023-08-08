-- Active: 1680187088573@@127.0.0.1@3306

DROP DATABASE IF EXISTS comics;
CREATE DATABASE IF NOT EXISTS comics;

USE comics;

# Tables

# Symbol quality
CREATE TABLE comic_quality (
    symbol VARCHAR(20) NOT NULL,
    min_grade FLOAT(3, 1) NOT NULL,
    max_grade FLOAT(3, 1) NOT NULL,

    PRIMARY KEY (symbol)
);

# Publisher
CREATE TABLE publisher (
    publisher VARCHAR(20) NOT NULL,

    PRIMARY KEY (publisher)
);

CREATE TABLE title (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    publisher VARCHAR(20) NOT NULL,

    PRIMARY KEY (id),
    UNIQUE KEY(title, publisher),
    FOREIGN KEY (publisher) REFERENCES publisher(publisher) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE special (
    special VARCHAR(20),

    PRIMARY KEY (special)
);

CREATE TABLE comic_book (
    id INT NOT NULL AUTO_INCREMENT,
    title_id INT NOT NULL,
    issue INT NOT NULL,
    `year` INT NOT NULL,
    grade FLOAT(3, 1) NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (title_id) REFERENCES title(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE comic_book_price (
    comic_book_id INT NOT NULL,
    symbol VARCHAR(20) NOT NULL,
    `signed` TINYINT NOT NULL,
    collected_by VARCHAR(20),
    purchase_price FLOAT(10, 2) NOT NULL,
    original_price FLOAT(10, 2) NOT NULL,
    special VARCHAR(20) NOT NULL,
    offering_price FLOAT(10, 2) NOT NULL,
    existed TINYINT NOT NULL DEFAULT 1,

    PRIMARY KEY (comic_book_id),
    FOREIGN KEY (comic_book_id) REFERENCES comic_book(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (symbol) REFERENCES comic_quality(symbol) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (special) REFERENCES special(special) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE graphic_novel (
    id INT NOT NULL AUTO_INCREMENT,
    title_id INT NOT NULL,
    `edition` INT NOT NULL,
    `year` INT NOT NULL,
    grade FLOAT(3, 1) NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (title_id) REFERENCES title(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE graphic_novel_price (
    graphic_novel_id INT NOT NULL,
    symbol VARCHAR(20) NOT NULL,
    `signed` TINYINT NOT NULL,
    collected_by VARCHAR(20),
    purchase_price FLOAT(10, 2) NOT NULL,
    original_price FLOAT(10, 2) NOT NULL,
    special VARCHAR(20),
    offering_price FLOAT(10, 2) NOT NULL,
    existed TINYINT NOT NULL DEFAULT 1,

    PRIMARY KEY (graphic_novel_id),
    FOREIGN KEY (graphic_novel_id) REFERENCES graphic_novel(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (symbol) REFERENCES comic_quality(symbol) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (special) REFERENCES special(special) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE character_info (
    id INT NOT NULL AUTO_INCREMENT,
    character_name VARCHAR(50) NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE first_appearance (
    character_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    issue INT NOT NULL,

    PRIMARY KEY (character_id),
    FOREIGN KEY (character_id) REFERENCES character_info(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE relation_comic_character (
    title_id INT NOT NULL,
    character_id INT NOT NULL,

    PRIMARY KEY (title_id, character_id),
    FOREIGN KEY (title_id) REFERENCES title(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (character_id) REFERENCES character_info(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE author_info (
    id INT NOT NULL AUTO_INCREMENT,
    author_name VARCHAR(30) NOT NULL,
    author_type VARCHAR(20) NOT NULL,

    PRIMARY KEY (id),
    UNIQUE KEY (author_name, author_type)
);

CREATE TABLE relation_comic_author (
    title_id INT NOT NULL,
    author_id INT NOT NULL,

    PRIMARY KEY (title_id, author_id),
    FOREIGN KEY (title_id) REFERENCES title(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author_info(id) ON DELETE CASCADE ON UPDATE CASCADE
);

# TABLE comic_quality
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("MINT", 9.9, 10.0);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("NEAR MINT/MINT", 9.8, 10.0);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("NEAR MINT", 9.2, 9.7);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("VERY FINE/NEAR MINT", 9.0, 9.0);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("VERY FINE", 7.5, 8.5);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("FINE/VERY FINE", 7.0, 7.0);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("FINE", 5.5, 6.5);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("VERY GOOD/FINE", 5.0, 5.0);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("VERY GOOD", 3.5, 4.5);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("GOOD/VERY GOOD", 3.0, 3.0);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("GOOD", 1.8, 2.5);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("FAIR/GOOD", 1.5, 1.5);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("FAIR", 1.0, 1.0);
INSERT INTO comic_quality (symbol, min_grade, max_grade) VALUES ("POOR", 0.5, 0.5);
INSERT INTO publisher (publisher) VALUES ("CGC Comics");
INSERT INTO publisher (publisher) VALUES ("DC Comics");
INSERT INTO publisher (publisher) VALUES ("Dark Horse Comics");
INSERT INTO publisher (publisher) VALUES ("Image Comics");
INSERT INTO publisher (publisher) VALUES ("Image Top Cow");
INSERT INTO publisher (publisher) VALUES ("Marvel Comics");
INSERT INTO publisher (publisher) VALUES ("Viz Comics");
INSERT INTO title (title, publisher) VALUES ("AVENGERS (1963) (#1-402) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AVENGERS (2010) (#1-34) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AVENGERS, THOR, & CAPTAIN AMERICA: OFFICIAL INDEX (2010)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("CAPTAIN AMERICA (1968) (#100-454) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("DAREDEVIL (1964) (#1-380) (MAN WITHOUT FEAR) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("BEFORE THE FANTASTIC FOUR: BEN GRIMM AND LOGAN (2000)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("BEFORE THE FANTASTIC FOUR: REED RICHARDS (2000)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("BEFORE THE FANTASTIC FOUR: THE STORMS (2000)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ESSENTIAL FANTASTIC FOUR TPB (1998)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("FANTASTIC FOUR (1961) (#1-416) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ESSENTIAL IRON MAN TPB (2000)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ESSENTIAL IRON MAN TPB (2ND EDITION) (2005)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ESSENTIAL IRON MAN TPB (3RD EDITION) (2008)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("HULK (1962) (#1-6, #102-474, #600-635)(INCREDIBLE)(MV)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("INVINCIBLE IRON MAN (2008) (#1-33 & 500-527) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("IRON MAN (1968) (#1-332) (INVINCIBLE IRON MAN)(MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ADVENTURES OF SPIDER-MAN (1996)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ADVENTURES OF THE X-MEN (1996)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN (2014) (#1-20.1) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN (2015) (#1-32) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN (2018) (#1-93) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN 500 COVERS HC (2004)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN ANNUAL (2008)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN COLLECTED EDITION (2001)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN FREE COMIC BOOK DAY (2018)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN MOVIE ADAPTATION (2014)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN PRESENTS AMERICAN SON (2010)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AMAZING SPIDER-MAN PRESENTS BLACK CAT (2010)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING SPIDER-MAN/WOLVERINE (2010)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AVENGING SPIDER-MAN (2011)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("AVENGING SPIDER-MAN: MY FRIENDS PREMIERE HC (2012)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("BACKPACK MARVELS SPIDER-MAN: MURDER BY SPIDER TPB (2000)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("DEADLY FOES OF SPIDER-MAN (1991)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("DEADLY FOES OF SPIDER-MAN TPB (1993)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("EDGE OF SPIDER-VERSE (2014)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ESSENTIAL SPIDER-MAN TPB (1996)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ESSENTIAL SPIDER-MAN TPB (2ND EDITION) (2005)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("MARVEL AGE SPIDER-MAN (2004)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("KING THOR (2019)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("MIGHTY THOR (2011) (#1-23) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("MIGHTY THOR (2015) (#1-23) (FEMALE THOR) (JANE FOSTER)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("THOR (1962) (#83-125 JOURNEY INTO MYSTERY, 126-502)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ALL-NEW X-MEN (2012) (#1-41)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN (1996) (#1-4) (AGE OF APOCALYPSE)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN (1999) (#1-3) (MARVEL)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN (2004) (#1-68) (MARVEL)(JOSS WHEDON)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN ANNUAL (2012)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN SAGA (JOSS WHEDON) (2005)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN VOL. 1: GIFTED HC (2010)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN VOL. 1: GIFTED TPB (2004)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN VOL. 2: DANGEROUS TPB (2005)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN VOL. 3: TORN TPB (2006)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN VOL. 4: UNSTOPPABLE TPB (2008)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN: CHILDREN OF BROOD PREMIERE HC (2012)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN: EXALTED HC (2012)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN: EXOGENETIC PREMIERE HC (2010)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN: GHOST BOX HC (2009)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN: MONSTROUS PREMIERE HC (2011)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN: XENOGENESIS (WARREN ELLIS) (2010)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ASTONISHING X-MEN: XENOGENESIS HC (WARREN ELLIS) (2011)", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("ALL-NEW BATMAN: BRAVE & THE BOLD (2011)", "DC Comics");
INSERT INTO title (title, publisher) VALUES ("FLASH (1959) (#105-350) (DC)", "DC Comics");
INSERT INTO title (title, publisher) VALUES ("FLASH (1987) (#0-247) (DC)", "DC Comics");
INSERT INTO title (title, publisher) VALUES ("GREEN LANTERN (1960) (#1-224) (DC)", "DC Comics");
INSERT INTO title (title, publisher) VALUES ("JLA (1996)", "Viz Comics");
INSERT INTO title (title, publisher) VALUES ("1001 NIGHTS OF BACCHUS (1993)", "Dark Horse Comics");
INSERT INTO title (title, publisher) VALUES ("1963 (IMAGE) (1993)", "Image Comics");
INSERT INTO title (title, publisher) VALUES ("21 (IMAGE TOP COW) (1996)", "Image Top Cow");
INSERT INTO title (title, publisher) VALUES ("Avengers Disassembled", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("New Avengers: Breakout", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("The Ultimates", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Avengers Forever", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("The Infinity Gauntlet", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Iron Man: Extremis", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Iron Man: The Armor Wars", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Iron Man: Demon in a Bottle", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Iron Man: The Coming of the Melter!", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Iron Man: The Iron Age", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Captain America: Winter Soldier", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Captain America: Man Out of Time", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Captain America: The Death of Captain America", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Captain America: The Captain", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Captain America: The Legacy of Captain America", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Incredible Hulk: Planet Hulk", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Incredible Hulk: The End", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("The Immortal Hulk", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Hulk: Gray", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Incredible Hulk: Future Imperfect", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("The Amazing Spider-Man: The Gauntlet", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Spider-Man: Blue", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Ultimate Spider-Man: Ultimate Collection, Vol. 1", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Spider-Man: Life Story", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Spider-Man: Kraven's Last Hunt", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Thor: God of Thunder, Vol. 1", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("The Mighty Thor: Walter Simonson, Vol. 1", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Thor by J. Michael Straczynski, Vol. 1", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Thor: The Dark World Prelude", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("The Unworthy Thor", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("X-Men: Grand Design", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("X-Men: Age of Apocalypse Omnibus", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Giant-Size X-Men", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("X-Men: Days of Future Past", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("X-Men: God Loves, Man Kills", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Green Lantern: Secret Origin", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Green Lantern: Earth One, Vol. 1", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Green Lantern: Rebirth", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Green Lantern Corps: Recharge", "Marvel Comics");
INSERT INTO title (title, publisher) VALUES ("Green Lantern: Emerald Twilight/New Dawn", "Marvel Comics");
INSERT INTO special (special) VALUES ("None");
INSERT INTO special (special) VALUES ("Super Bargains");
INSERT INTO special (special) VALUES ("Weekly Specials");
# TABLE comic_book and comic_book_price
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1, "FAIR", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (2, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (3, "VERY GOOD", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (4, "FINE", 0, NULL, 28.7, 41.00, "None", 41.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (5, "VERY FINE", 0, NULL, 47.599999999999994, 68.00, "None", 68.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (6, "NEAR MINT", 0, NULL, 67.19999999999999, 96.00, "None", 96.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (7, "FAIR", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (8, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (9, "VERY GOOD", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (10, "FINE", 0, NULL, 28.7, 41.00, "None", 41.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (11, "VERY FINE", 0, NULL, 47.599999999999994, 68.00, "None", 68.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (12, "NEAR MINT", 0, NULL, 67.19999999999999, 96.00, "None", 96.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (13, "FAIR", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (14, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (15, "VERY GOOD", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (16, "FINE", 0, NULL, 28.7, 41.00, "None", 41.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (17, "VERY FINE", 0, NULL, 47.599999999999994, 68.00, "None", 68.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (18, "NEAR MINT", 0, NULL, 67.19999999999999, 96.00, "None", 96.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (19, "FAIR", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (20, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (21, "VERY GOOD", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (22, "FINE", 0, NULL, 28.7, 41.00, "None", 41.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (23, "VERY FINE", 0, NULL, 47.599999999999994, 68.00, "None", 68.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 180, 1963, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (24, "NEAR MINT", 0, NULL, 67.19999999999999, 96.00, "None", 96.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 111, 1963, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (25, "FINE", 0, NULL, 79.8, 114.00, "None", 114.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 155, 1963, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (26, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 155, 1963, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (27, "VERY GOOD", 0, NULL, 14.174999999999999, 20.25, "None", 20.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 155, 1963, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (28, "FINE", 0, NULL, 19.599999999999998, 28.00, "None", 28.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 155, 1963, 7.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (29, "VERY FINE", 0, NULL, 32.9, 47.00, "None", 47.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 101, 1963, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (30, "GOOD", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 101, 1963, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (31, "VERY GOOD", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 101, 1963, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (32, "FINE", 0, NULL, 44.8, 64.00, "None", 64.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 101, 1963, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (33, "VERY FINE", 0, NULL, 75.6, 108.00, "None", 108.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (34, "GOOD", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (35, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (36, "FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (37, "VERY FINE", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (38, "GOOD", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (39, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (40, "FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (41, "VERY FINE", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (42, "GOOD", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (43, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (44, "FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (45, "VERY FINE", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (46, "GOOD", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (47, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (48, "FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 148, 1963, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (49, "VERY FINE", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 18, 1963, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (50, "GOOD", 0, NULL, 118.3, 169.00, "None", 169.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 18, 1963, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (51, "VERY GOOD", 0, NULL, 226.1, 323.00, "None", 323.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 18, 1963, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (52, "FINE", 0, NULL, 334.59999999999997, 478.00, "None", 478.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 131, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (53, "FAIR", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 131, 1963, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (54, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 131, 1963, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (55, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 131, 1963, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (56, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 135, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (57, "FAIR", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 135, 1963, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (58, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 135, 1963, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (59, "VERY GOOD", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 135, 1963, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (60, "FINE", 0, NULL, 51.099999999999994, 73.00, "None", 73.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 135, 1963, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (61, "VERY FINE", 0, NULL, 78.39999999999999, 112.00, "None", 112.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 153, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (62, "FAIR", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 153, 1963, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (63, "GOOD", 0, NULL, 7.175, 10.25, "None", 10.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 153, 1963, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (64, "VERY GOOD", 0, NULL, 14.174999999999999, 20.25, "None", 20.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 153, 1963, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (65, "FINE", 0, NULL, 19.599999999999998, 28.00, "None", 28.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 153, 1963, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (66, "VERY FINE", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 19, 1963, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (67, "VERY GOOD", 0, NULL, 291.2, 416.00, "None", 416.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 122, 1963, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (68, "GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 122, 1963, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (69, "VERY GOOD", 0, NULL, 29.4, 42.00, "None", 42.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 122, 1963, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (70, "FINE", 0, NULL, 40.599999999999994, 58.00, "None", 58.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 132, 1963, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (71, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 132, 1963, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (72, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 132, 1963, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (73, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 132, 1963, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (74, "VERY FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 166, 1963, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (75, "GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 166, 1963, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (76, "VERY GOOD", 0, NULL, 29.4, 42.00, "None", 42.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 166, 1963, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (77, "FINE", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 166, 1963, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (78, "VERY FINE", 0, NULL, 68.6, 98.00, "None", 98.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 166, 1963, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (79, "NEAR MINT", 0, NULL, 91.0, 130.00, "None", 130.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 133, 1963, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (80, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 133, 1963, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (81, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 133, 1963, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (82, "FINE", 0, NULL, 30.099999999999998, 43.00, "None", 43.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 138, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (83, "FAIR", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 138, 1963, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (84, "VERY GOOD", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 138, 1963, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (85, "FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 138, 1963, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (86, "VERY FINE", 0, NULL, 51.099999999999994, 73.00, "None", 73.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 142, 1963, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (87, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 142, 1963, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (88, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 186, 1963, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (89, "VERY GOOD", 0, NULL, 44.099999999999994, 63.00, "None", 63.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 186, 1963, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (90, "FINE", 0, NULL, 61.599999999999994, 88.00, "None", 88.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 114, 1963, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (91, "VERY GOOD", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 114, 1963, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (92, "FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 114, 1963, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (93, "VERY FINE", 0, NULL, 86.1, 123.00, "None", 123.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 139, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (94, "FAIR", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 139, 1963, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (95, "GOOD", 0, NULL, 10.85, 15.50, "None", 15.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 139, 1963, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (96, "VERY GOOD", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 139, 1963, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (97, "FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 140, 1963, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (98, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 140, 1963, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (99, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 140, 1963, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (100, "FINE", 0, NULL, 30.099999999999998, 43.00, "None", 43.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 144, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (101, "FAIR", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 144, 1963, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (102, "VERY GOOD", 0, NULL, 81.89999999999999, 117.00, "None", 117.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 144, 1963, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (103, "VERY FINE", 0, NULL, 205.1, 293.00, "None", 293.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 145, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (104, "FAIR", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 145, 1963, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (105, "GOOD", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 145, 1963, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (106, "VERY GOOD", 0, NULL, 16.974999999999998, 24.25, "None", 24.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 145, 1963, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (107, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (1, 145, 1963, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (108, "VERY FINE", 0, NULL, 40.599999999999994, 58.00, "None", 58.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 29, 2010, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (109, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 29, 2010, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (110, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 29, 2010, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (111, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 29, 2010, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (112, "VERY FINE", 0, NULL, 13.649999999999999, 19.50, "None", 19.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 29, 2010, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (113, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 27, 2010, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (114, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 27, 2010, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (115, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 27, 2010, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (116, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 27, 2010, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (117, "VERY FINE", 0, NULL, 13.299999999999999, 19.00, "None", 19.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 27, 2010, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (118, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 30, 2010, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (119, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 30, 2010, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (120, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 30, 2010, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (121, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 30, 2010, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (122, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 28, 2010, 2.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (123, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 28, 2010, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (124, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 28, 2010, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (125, "FINE", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 28, 2010, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (126, "VERY FINE", 0, NULL, 12.774999999999999, 18.25, "None", 18.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 28, 2010, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (127, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (128, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (129, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (130, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (131, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (132, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (133, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (134, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (135, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (136, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (137, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (138, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (139, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (140, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (141, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (142, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 2.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (143, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (144, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (145, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (146, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 25, 2010, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (147, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 26, 2010, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (148, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 26, 2010, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (149, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 26, 2010, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (150, "FINE", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 26, 2010, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (151, "VERY FINE", 0, NULL, 13.649999999999999, 19.50, "None", 19.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (2, 26, 2010, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (152, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 6, 2010, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (153, "NEAR MINT", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 4, 2010, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (154, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 4, 2010, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (155, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 4, 2010, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (156, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 4, 2010, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (157, "NEAR MINT", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 5, 2010, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (158, "NEAR MINT", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 1, 2010, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (159, "VERY GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 1, 2010, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (160, "FINE", 0, NULL, 5.949999999999999, 8.50, "None", 8.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 1, 2010, 7.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (161, "VERY FINE", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 1, 2010, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (162, "NEAR MINT", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 2, 2010, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (163, "VERY FINE", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 2, 2010, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (164, "NEAR MINT", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 3, 2010, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (165, "VERY GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 3, 2010, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (166, "FINE", 0, NULL, 5.949999999999999, 8.50, "None", 8.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 3, 2010, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (167, "VERY FINE", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (3, 3, 2010, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (168, "NEAR MINT", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 194, 1968, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (169, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 194, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (170, "VERY GOOD", 0, NULL, 14.35, 20.50, "None", 20.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 194, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (171, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 194, 1968, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (172, "VERY FINE", 0, NULL, 32.9, 47.00, "None", 47.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 209, 1968, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (173, "VERY GOOD", 0, NULL, 11.725, 16.75, "None", 16.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 209, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (174, "FINE", 0, NULL, 15.225, 21.75, "None", 21.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 209, 1968, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (175, "VERY FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 136, 1968, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (176, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 136, 1968, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (177, "VERY GOOD", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 136, 1968, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (178, "FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 136, 1968, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (179, "NEAR MINT", 0, NULL, 114.1, 163.00, "None", 163.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 159, 1968, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (180, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 104, 1968, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (181, "GOOD", 0, NULL, 47.599999999999994, 68.00, "None", 68.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 104, 1968, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (182, "VERY GOOD", 0, NULL, 93.8, 134.00, "None", 134.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 104, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (183, "FINE", 0, NULL, 131.6, 188.00, "None", 188.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 104, 1968, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (184, "VERY FINE", 0, NULL, 223.29999999999998, 319.00, "None", 319.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (185, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (186, "FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (187, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (188, "FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (189, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (190, "FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (191, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (192, "FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 4.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (193, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 200, 1968, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (194, "FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 132, 1968, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (195, "GOOD", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 132, 1968, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (196, "VERY GOOD", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 132, 1968, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (197, "FINE", 0, NULL, 47.599999999999994, 68.00, "None", 68.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 132, 1968, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (198, "VERY FINE", 0, NULL, 73.5, 105.00, "None", 105.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 132, 1968, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (199, "NEAR MINT", 0, NULL, 108.5, 155.00, "None", 155.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 207, 1968, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (200, "GOOD", 0, NULL, 5.949999999999999, 8.50, "None", 8.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 207, 1968, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (201, "VERY GOOD", 0, NULL, 11.2, 16.00, "None", 16.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 207, 1968, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (202, "FINE", 0, NULL, 15.225, 21.75, "None", 21.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 207, 1968, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (203, "VERY FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 207, 1968, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (204, "NEAR MINT", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 121, 1968, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (205, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 121, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (206, "VERY GOOD", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 121, 1968, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (207, "FINE", 0, NULL, 51.099999999999994, 73.00, "None", 73.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 121, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (208, "NEAR MINT", 0, NULL, 114.1, 163.00, "None", 163.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 115, 1968, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (209, "VERY FINE", 0, NULL, 121.1, 173.00, "None", 173.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 131, 1968, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (210, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 131, 1968, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (211, "VERY GOOD", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 131, 1968, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (212, "FINE", 0, NULL, 51.099999999999994, 73.00, "None", 73.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 184, 1968, 4.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (213, "VERY GOOD", 0, NULL, 10.85, 15.50, "None", 15.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 184, 1968, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (214, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 184, 1968, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (215, "VERY FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 120, 1968, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (216, "GOOD", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 120, 1968, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (217, "VERY GOOD", 0, NULL, 50.4, 72.00, "None", 72.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 120, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (218, "FINE", 0, NULL, 70.0, 100.00, "None", 100.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 120, 1968, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (219, "VERY FINE", 0, NULL, 121.1, 173.00, "None", 173.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 129, 1968, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (220, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 129, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (221, "VERY GOOD", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 129, 1968, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (222, "FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 129, 1968, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (223, "NEAR MINT", 0, NULL, 114.1, 163.00, "None", 163.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 153, 1968, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (224, "VERY GOOD", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 153, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (225, "FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 208, 1968, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (226, "VERY GOOD", 0, NULL, 11.725, 16.75, "None", 16.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 208, 1968, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (227, "FINE", 0, NULL, 15.225, 21.75, "None", 21.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 208, 1968, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (228, "VERY FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 175, 1968, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (229, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 175, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (230, "FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (231, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (232, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (233, "VERY FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (234, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (235, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (236, "VERY FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (237, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (238, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (239, "VERY FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (240, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (241, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 158, 1968, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (242, "VERY FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 196, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (243, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 196, 1968, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (244, "VERY GOOD", 0, NULL, 13.825, 19.75, "None", 19.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 196, 1968, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (245, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 196, 1968, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (246, "VERY FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 196, 1968, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (247, "NEAR MINT", 0, NULL, 45.5, 65.00, "None", 65.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 162, 1968, 4.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (248, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 162, 1968, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (249, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 130, 1968, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (250, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 130, 1968, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (251, "FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 125, 1968, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (252, "VERY GOOD", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 125, 1968, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (253, "FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 172, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (254, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 172, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (255, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 177, 1968, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (256, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 177, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (257, "FINE", 0, NULL, 19.599999999999998, 28.00, "None", 28.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 177, 1968, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (258, "VERY FINE", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 193, 1968, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (259, "GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 193, 1968, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (260, "VERY GOOD", 0, NULL, 39.199999999999996, 56.00, "None", 56.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 193, 1968, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (261, "FINE", 0, NULL, 60.9, 87.00, "None", 87.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 193, 1968, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (262, "VERY FINE", 0, NULL, 102.89999999999999, 147.00, "None", 147.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 134, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (263, "FINE", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 134, 1968, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (264, "NEAR MINT", 0, NULL, 114.1, 163.00, "None", 163.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 147, 1968, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (265, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 146, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (266, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 146, 1968, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (267, "FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 266, 1968, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (268, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 266, 1968, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (269, "VERY FINE", 0, NULL, 20.299999999999997, 29.00, "None", 29.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 266, 1968, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (270, "NEAR MINT", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 112, 1968, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (271, "VERY GOOD", 0, NULL, 118.3, 169.00, "None", 169.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 112, 1968, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (272, "FINE", 0, NULL, 163.79999999999998, 234.00, "None", 234.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 112, 1968, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (273, "NEAR MINT", 0, NULL, 364.0, 520.00, "None", 520.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 111, 1968, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (274, "VERY GOOD", 0, NULL, 175.7, 251.00, "None", 251.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 111, 1968, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (275, "FINE", 0, NULL, 245.7, 351.00, "None", 351.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 111, 1968, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (276, "VERY FINE", 0, NULL, 409.5, 585.00, "None", 585.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 138, 1968, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (277, "FAIR", 0, NULL, 12.774999999999999, 18.25, "None", 18.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 138, 1968, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (278, "GOOD", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 138, 1968, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (279, "VERY GOOD", 0, NULL, 48.3, 69.00, "None", 69.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 138, 1968, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (280, "FINE", 0, NULL, 72.1, 103.00, "None", 103.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 138, 1968, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (281, "VERY FINE", 0, NULL, 121.1, 173.00, "None", 173.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 197, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (282, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 197, 1968, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (283, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 197, 1968, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (284, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 197, 1968, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (285, "VERY FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 178, 1968, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (286, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 178, 1968, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (287, "FINE", 0, NULL, 20.299999999999997, 29.00, "None", 29.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 119, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (288, "GOOD", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 119, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (289, "VERY GOOD", 0, NULL, 51.099999999999994, 73.00, "None", 73.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 119, 1968, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (290, "FINE", 0, NULL, 70.0, 100.00, "None", 100.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 119, 1968, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (291, "VERY FINE", 0, NULL, 121.1, 173.00, "None", 173.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 101, 1968, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (292, "GOOD", 0, NULL, 72.8, 104.00, "None", 104.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 101, 1968, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (293, "VERY GOOD", 0, NULL, 145.6, 208.00, "None", 208.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 101, 1968, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (294, "FINE", 0, NULL, 191.1, 273.00, "None", 273.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 182, 1968, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (295, "VERY GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 182, 1968, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (296, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 206, 1968, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (297, "GOOD", 0, NULL, 5.949999999999999, 8.50, "None", 8.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 206, 1968, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (298, "VERY GOOD", 0, NULL, 11.549999999999999, 16.50, "None", 16.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 206, 1968, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (299, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 206, 1968, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (300, "VERY FINE", 0, NULL, 27.299999999999997, 39.00, "None", 39.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 206, 1968, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (301, "NEAR MINT", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 198, 1968, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (302, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 198, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (303, "VERY GOOD", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 198, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (304, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 198, 1968, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (305, "VERY FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 198, 1968, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (306, "NEAR MINT", 0, NULL, 44.8, 64.00, "None", 64.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 204, 1968, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (307, "GOOD", 0, NULL, 5.949999999999999, 8.50, "None", 8.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 204, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (308, "VERY GOOD", 0, NULL, 11.549999999999999, 16.50, "None", 16.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 204, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (309, "FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 204, 1968, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (310, "VERY FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 201, 1968, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (311, "GOOD", 0, NULL, 5.949999999999999, 8.50, "None", 8.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 201, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (312, "VERY GOOD", 0, NULL, 11.375, 16.25, "None", 16.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 201, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (313, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 137, 1968, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (314, "GOOD", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 137, 1968, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (315, "FINE", 0, NULL, 72.1, 103.00, "None", 103.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 137, 1968, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (316, "VERY FINE", 0, NULL, 121.1, 173.00, "None", 173.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 113, 1968, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (317, "FAIR", 0, NULL, 44.099999999999994, 63.00, "None", 63.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 113, 1968, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (318, "GOOD", 0, NULL, 87.5, 125.00, "None", 125.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 113, 1968, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (319, "VERY GOOD", 0, NULL, 172.89999999999998, 247.00, "None", 247.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 113, 1968, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (320, "FINE", 0, NULL, 245.7, 351.00, "None", 351.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 113, 1968, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (321, "VERY FINE", 0, NULL, 409.5, 585.00, "None", 585.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 195, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (322, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 195, 1968, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (323, "VERY GOOD", 0, NULL, 13.825, 19.75, "None", 19.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 195, 1968, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (324, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 195, 1968, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (325, "VERY FINE", 0, NULL, 32.199999999999996, 46.00, "None", 46.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 141, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (326, "GOOD", 0, NULL, 14.35, 20.50, "None", 20.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 141, 1968, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (327, "VERY GOOD", 0, NULL, 28.7, 41.00, "None", 41.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 141, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (328, "FINE", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (4, 160, 1968, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (329, "FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 48, 1964, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (330, "VERY GOOD", 0, NULL, 53.9, 77.00, "None", 77.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 48, 1964, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (331, "FINE", 0, NULL, 79.8, 114.00, "None", 114.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 120, 1964, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (332, "VERY GOOD", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 120, 1964, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (333, "FINE", 0, NULL, 30.099999999999998, 43.00, "None", 43.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 120, 1964, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (334, "VERY FINE", 0, NULL, 51.099999999999994, 73.00, "None", 73.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 74, 1964, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (335, "VERY GOOD", 0, NULL, 28.7, 41.00, "None", 41.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 74, 1964, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (336, "FINE", 0, NULL, 39.9, 57.00, "None", 57.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 16, 1964, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (337, "GOOD", 0, NULL, 182.0, 260.00, "None", 260.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 16, 1964, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (338, "VERY GOOD", 0, NULL, 341.59999999999997, 488.00, "None", 488.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 75, 1964, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (339, "GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 75, 1964, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (340, "VERY GOOD", 0, NULL, 29.4, 42.00, "None", 42.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 75, 1964, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (341, "FINE", 0, NULL, 39.9, 57.00, "None", 57.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 38, 1964, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (342, "GOOD", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 38, 1964, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (343, "VERY GOOD", 0, NULL, 72.8, 104.00, "None", 104.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 38, 1964, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (344, "FINE", 0, NULL, 102.89999999999999, 147.00, "None", 147.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (5, 38, 1964, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (345, "VERY FINE", 0, NULL, 168.0, 240.00, "None", 240.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (6, 2, 2000, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (346, "FINE", 0, NULL, 9.274999999999999, 13.25, "None", 13.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (6, 2, 2000, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (347, "VERY FINE", 0, NULL, 13.825, 19.75, "None", 19.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (6, 2, 2000, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (348, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (6, 3, 2000, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (349, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (6, 3, 2000, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (350, "NEAR MINT", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (7, 3, 2000, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (351, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (7, 3, 2000, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (352, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (7, 3, 2000, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (353, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (7, 1, 2000, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (354, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (7, 1, 2000, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (355, "FINE", 0, NULL, 9.274999999999999, 13.25, "None", 13.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (7, 1, 2000, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (356, "VERY FINE", 0, NULL, 13.825, 19.75, "None", 19.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (7, 1, 2000, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (357, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (8, 1, 2000, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (358, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (8, 1, 2000, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (359, "FINE", 0, NULL, 9.274999999999999, 13.25, "None", 13.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (8, 1, 2000, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (360, "VERY FINE", 0, NULL, 12.95, 18.50, "None", 18.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (8, 1, 2000, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (361, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (8, 2, 2000, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (362, "VERY GOOD", 0, NULL, 5.425, 7.75, "None", 7.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (8, 2, 2000, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (363, "FINE", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (8, 2, 2000, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (364, "VERY FINE", 0, NULL, 13.475, 19.25, "None", 19.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (8, 2, 2000, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (365, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (9, 1, 1998, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (366, "VERY GOOD", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (9, 1, 1998, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (367, "VERY FINE", 0, NULL, 37.8, 54.00, "None", 54.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (9, 1, 1998, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (368, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (9, 3, 1998, 7.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (369, "VERY FINE", 0, NULL, 37.8, 54.00, "None", 54.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (9, 5, 1998, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (370, "VERY FINE", 0, NULL, 37.8, 54.00, "None", 54.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (9, 7, 1998, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (371, "VERY GOOD", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (9, 7, 1998, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (372, "FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (9, 7, 1998, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (373, "VERY FINE", 0, NULL, 37.8, 54.00, "None", 54.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (9, 7, 1998, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (374, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 134, 1961, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (375, "VERY GOOD", 0, NULL, 29.4, 42.00, "None", 42.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 134, 1961, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (376, "FINE", 0, NULL, 39.9, 57.00, "None", 57.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 134, 1961, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (377, "VERY FINE", 0, NULL, 67.19999999999999, 96.00, "None", 96.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 162, 1961, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (378, "FAIR", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 162, 1961, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (379, "GOOD", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 162, 1961, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (380, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 162, 1961, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (381, "FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 179, 1961, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (382, "FAIR", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 179, 1961, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (383, "GOOD", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 179, 1961, 4.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (384, "VERY GOOD", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 179, 1961, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (385, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 179, 1961, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (386, "VERY FINE", 0, NULL, 40.599999999999994, 58.00, "None", 58.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 179, 1961, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (387, "NEAR MINT", 0, NULL, 57.4, 82.00, "None", 82.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 169, 1961, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (388, "GOOD", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 169, 1961, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (389, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 169, 1961, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (390, "FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 169, 1961, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (391, "VERY FINE", 0, NULL, 43.4, 62.00, "None", 62.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 107, 1961, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (392, "FAIR", 0, NULL, 13.299999999999999, 19.00, "None", 19.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 107, 1961, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (393, "GOOD", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 107, 1961, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (394, "VERY GOOD", 0, NULL, 51.8, 74.00, "None", 74.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 107, 1961, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (395, "FINE", 0, NULL, 72.8, 104.00, "None", 104.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 12, 1961, 4.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (396, "VERY GOOD", 0, NULL, 10556.0, 15080.00, "None", 15080.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 137, 1961, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (397, "VERY GOOD", 0, NULL, 28.7, 41.00, "None", 41.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 137, 1961, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (398, "FINE", 0, NULL, 39.199999999999996, 56.00, "None", 56.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 137, 1961, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (399, "VERY FINE", 0, NULL, 67.19999999999999, 96.00, "None", 96.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 165, 1961, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (400, "GOOD", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 165, 1961, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (401, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 165, 1961, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (402, "FINE", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 165, 1961, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (403, "VERY FINE", 0, NULL, 43.4, 62.00, "None", 62.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 184, 1961, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (404, "FAIR", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 184, 1961, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (405, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 184, 1961, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (406, "VERY GOOD", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 184, 1961, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (407, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 184, 1961, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (408, "VERY FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 184, 1961, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (409, "NEAR MINT", 0, NULL, 45.5, 65.00, "None", 65.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 133, 1961, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (410, "FAIR", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 133, 1961, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (411, "GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 133, 1961, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (412, "FINE", 0, NULL, 61.599999999999994, 88.00, "None", 88.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 133, 1961, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (413, "VERY FINE", 0, NULL, 102.89999999999999, 147.00, "None", 147.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 163, 1961, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (414, "FAIR", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 163, 1961, 2.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (415, "GOOD", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 163, 1961, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (416, "VERY GOOD", 0, NULL, 17.15, 24.50, "None", 24.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 163, 1961, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (417, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 163, 1961, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (418, "VERY FINE", 0, NULL, 43.4, 62.00, "None", 62.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 131, 1961, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (419, "VERY GOOD", 0, NULL, 43.4, 62.00, "None", 62.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 131, 1961, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (420, "FINE", 0, NULL, 58.8, 84.00, "None", 84.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (10, 131, 1961, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (421, "VERY FINE", 0, NULL, 102.89999999999999, 147.00, "None", 147.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (11, 2, 2000, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (422, "VERY GOOD", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (11, 2, 2000, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (423, "FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (11, 2, 2000, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (424, "VERY FINE", 0, NULL, 37.8, 54.00, "None", 54.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (11, 1, 2000, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (425, "GOOD", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (11, 3, 2000, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (426, "FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (11, 5, 2000, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (427, "FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (11, 5, 2000, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (428, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (12, 1, 2005, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (429, "VERY FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (12, 1, 2005, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (430, "NEAR MINT", 0, NULL, 35.0, 50.00, "None", 50.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (13, 1, 2008, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (431, "FINE", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 102, 1962, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (432, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 102, 1962, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (433, "VERY GOOD", 0, NULL, 10.85, 15.50, "None", 15.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 102, 1962, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (434, "FINE", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 102, 1962, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (435, "VERY FINE", 0, NULL, 27.299999999999997, 39.00, "None", 39.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 102, 1962, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (436, "NEAR MINT", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 103, 1962, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (437, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 103, 1962, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (438, "VERY GOOD", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 103, 1962, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (439, "FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 103, 1962, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (440, "VERY FINE", 0, NULL, 40.599999999999994, 58.00, "None", 58.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 103, 1962, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (441, "NEAR MINT", 0, NULL, 54.599999999999994, 78.00, "None", 78.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 104, 1962, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (442, "GOOD", 0, NULL, 13.649999999999999, 19.50, "None", 19.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 104, 1962, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (443, "FINE", 0, NULL, 32.9, 47.00, "None", 47.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 105, 1962, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (444, "VERY GOOD", 0, NULL, 13.649999999999999, 19.50, "None", 19.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 105, 1962, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (445, "FINE", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 106, 1962, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (446, "VERY FINE", 0, NULL, 83.3, 119.00, "None", 119.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 107, 1962, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (447, "VERY FINE", 0, NULL, 61.599999999999994, 88.00, "None", 88.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 108, 1962, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (448, "GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 108, 1962, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (449, "VERY GOOD", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 108, 1962, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (450, "FINE", 0, NULL, 27.299999999999997, 39.00, "None", 39.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 108, 1962, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (451, "VERY FINE", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 109, 1962, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (452, "GOOD", 0, NULL, 29.4, 42.00, "None", 42.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 109, 1962, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (453, "VERY GOOD", 0, NULL, 56.699999999999996, 81.00, "None", 81.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 109, 1962, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (454, "FINE", 0, NULL, 81.19999999999999, 116.00, "None", 116.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 109, 1962, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (455, "VERY FINE", 0, NULL, 136.5, 195.00, "None", 195.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 110, 1962, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (456, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 110, 1962, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (457, "VERY GOOD", 0, NULL, 27.299999999999997, 39.00, "None", 39.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 110, 1962, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (458, "FINE", 0, NULL, 44.099999999999994, 63.00, "None", 63.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 110, 1962, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (459, "VERY FINE", 0, NULL, 68.6, 98.00, "None", 98.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (14, 110, 1962, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (460, "NEAR MINT", 0, NULL, 91.0, 130.00, "None", 130.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 15, 2008, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (461, "VERY FINE", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 15, 2008, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (462, "NEAR MINT", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 5, 2008, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (463, "VERY FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 5, 2008, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (464, "NEAR MINT", 0, NULL, 12.6, 18.00, "None", 18.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 25, 2008, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (465, "VERY GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 26, 2008, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (466, "FINE", 0, NULL, 4.199999999999999, 6.00, "None", 6.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 26, 2008, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (467, "VERY FINE", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 26, 2008, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (468, "NEAR MINT", 0, NULL, 7.699999999999999, 11.00, "None", 11.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 8, 2008, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (469, "NEAR MINT", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 27, 2008, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (470, "FINE", 0, NULL, 4.199999999999999, 6.00, "None", 6.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 27, 2008, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (471, "VERY FINE", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 27, 2008, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (472, "NEAR MINT", 0, NULL, 7.0, 10.00, "None", 10.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 29, 2008, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (473, "NEAR MINT", 0, NULL, 7.699999999999999, 11.00, "None", 11.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 22, 2008, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (474, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 22, 2008, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (475, "NEAR MINT", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 526, 2008, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (476, "VERY GOOD", 0, NULL, 3.5, 5.00, "None", 5.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 526, 2008, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (477, "FINE", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 526, 2008, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (478, "VERY FINE", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 526, 2008, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (479, "NEAR MINT", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 9, 2008, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (480, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 9, 2008, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (481, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 9, 2008, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (482, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 9, 2008, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (483, "NEAR MINT", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 14, 2008, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (484, "FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 14, 2008, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (485, "VERY FINE", 0, NULL, 55.3, 79.00, "None", 79.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (15, 14, 2008, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (486, "NEAR MINT", 0, NULL, 73.5, 105.00, "None", 105.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 150, 1968, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (487, "VERY FINE", 0, NULL, 61.599999999999994, 88.00, "None", 88.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 13, 1968, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (488, "FAIR", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 13, 1968, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (489, "GOOD", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 13, 1968, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (490, "VERY GOOD", 0, NULL, 72.1, 103.00, "None", 103.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 13, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (491, "FINE", 0, NULL, 100.8, 144.00, "None", 144.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 13, 1968, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (492, "VERY FINE", 0, NULL, 170.79999999999998, 244.00, "None", 244.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 143, 1968, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (493, "VERY GOOD", 0, NULL, 13.299999999999999, 19.00, "None", 19.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 143, 1968, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (494, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 143, 1968, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (495, "VERY FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 143, 1968, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (496, "NEAR MINT", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (497, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (498, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (499, "FINE", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (500, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (501, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (502, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (503, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (504, "FINE", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (505, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (506, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (507, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (508, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (509, "FINE", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (510, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (511, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (512, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (513, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (514, "FINE", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (515, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (516, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (517, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (518, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (519, "FINE", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (520, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (521, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (522, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (523, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (524, "FINE", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (525, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 177, 1968, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (526, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 112, 1968, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (527, "FAIR", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 112, 1968, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (528, "GOOD", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 112, 1968, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (529, "VERY GOOD", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 112, 1968, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (530, "FINE", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 112, 1968, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (531, "VERY FINE", 0, NULL, 40.599999999999994, 58.00, "None", 58.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 112, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (532, "NEAR MINT", 0, NULL, 53.9, 77.00, "None", 77.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 169, 1968, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (533, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 169, 1968, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (534, "VERY GOOD", 0, NULL, 14.35, 20.50, "None", 20.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 169, 1968, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (535, "FINE", 0, NULL, 19.599999999999998, 28.00, "None", 28.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 169, 1968, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (536, "VERY FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 169, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (537, "NEAR MINT", 0, NULL, 43.4, 62.00, "None", 62.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 165, 1968, 2.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (538, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 165, 1968, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (539, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 165, 1968, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (540, "FINE", 0, NULL, 9.625, 13.75, "None", 13.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 165, 1968, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (541, "VERY FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 165, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (542, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 158, 1968, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (543, "GOOD", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 158, 1968, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (544, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 158, 1968, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (545, "FINE", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 158, 1968, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (546, "VERY FINE", 0, NULL, 40.599999999999994, 58.00, "None", 58.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 158, 1968, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (547, "NEAR MINT", 0, NULL, 54.599999999999994, 78.00, "None", 78.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 109, 1968, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (548, "GOOD", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 109, 1968, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (549, "VERY GOOD", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 109, 1968, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (550, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 109, 1968, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (551, "VERY FINE", 0, NULL, 39.9, 57.00, "None", 57.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 127, 1968, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (552, "FAIR", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 127, 1968, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (553, "VERY GOOD", 0, NULL, 58.8, 84.00, "None", 84.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 127, 1968, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (554, "FINE", 0, NULL, 81.89999999999999, 117.00, "None", 117.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 127, 1968, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (555, "NEAR MINT", 0, NULL, 179.2, 256.00, "None", 256.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 187, 1968, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (556, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 187, 1968, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (557, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 187, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (558, "FINE", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 187, 1968, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (559, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 187, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (560, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 15, 1968, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (561, "GOOD", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 15, 1968, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (562, "VERY GOOD", 0, NULL, 72.1, 103.00, "None", 103.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 15, 1968, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (563, "FINE", 0, NULL, 98.0, 140.00, "None", 140.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 15, 1968, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (564, "VERY FINE", 0, NULL, 170.79999999999998, 244.00, "None", 244.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 185, 1968, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (565, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 185, 1968, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (566, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 185, 1968, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (567, "FINE", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 185, 1968, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (568, "VERY FINE", 0, NULL, 16.625, 23.75, "None", 23.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 185, 1968, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (569, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (570, "FINE", 0, NULL, 9.625, 13.75, "None", 13.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (571, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (572, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (573, "FINE", 0, NULL, 9.625, 13.75, "None", 13.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (574, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (575, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (576, "FINE", 0, NULL, 9.625, 13.75, "None", 13.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (577, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (578, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (579, "FINE", 0, NULL, 9.625, 13.75, "None", 13.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (580, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (581, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (582, "FINE", 0, NULL, 9.625, 13.75, "None", 13.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (583, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (584, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (585, "FINE", 0, NULL, 9.625, 13.75, "None", 13.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (586, "VERY FINE", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 159, 1968, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (587, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 174, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (588, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 174, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (589, "VERY GOOD", 0, NULL, 7.175, 10.25, "None", 10.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 174, 1968, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (590, "FINE", 0, NULL, 9.799999999999999, 14.00, "None", 14.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 174, 1968, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (591, "VERY FINE", 0, NULL, 16.625, 23.75, "None", 23.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 174, 1968, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (592, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 104, 1968, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (593, "FAIR", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 104, 1968, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (594, "GOOD", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 104, 1968, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (595, "VERY GOOD", 0, NULL, 16.974999999999998, 24.25, "None", 24.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 104, 1968, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (596, "FINE", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 104, 1968, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (597, "VERY FINE", 0, NULL, 40.599999999999994, 58.00, "None", 58.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 104, 1968, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (598, "NEAR MINT", 0, NULL, 54.599999999999994, 78.00, "None", 78.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 114, 1968, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (599, "FAIR", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 114, 1968, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (600, "GOOD", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 114, 1968, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (601, "VERY GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 114, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (602, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 114, 1968, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (603, "VERY FINE", 0, NULL, 39.9, 57.00, "None", 57.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 148, 1968, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (604, "GOOD", 0, NULL, 6.6499999999999995, 9.50, "None", 9.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 148, 1968, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (605, "VERY GOOD", 0, NULL, 13.299999999999999, 19.00, "None", 19.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 148, 1968, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (606, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 148, 1968, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (607, "VERY FINE", 0, NULL, 30.099999999999998, 43.00, "None", 43.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 148, 1968, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (608, "NEAR MINT", 0, NULL, 39.199999999999996, 56.00, "None", 56.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 1, 1968, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (609, "FAIR", 0, NULL, 728.0, 1040.00, "None", 1040.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 1, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (610, "NEAR MINT", 0, NULL, 9100.0, 13000.00, "None", 13000.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 12, 1968, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (611, "GOOD", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 12, 1968, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (612, "VERY GOOD", 0, NULL, 72.8, 104.00, "None", 104.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 12, 1968, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (613, "FINE", 0, NULL, 100.8, 144.00, "None", 144.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 183, 1968, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (614, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 183, 1968, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (615, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 183, 1968, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (616, "FINE", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 183, 1968, 7.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (617, "VERY FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 183, 1968, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (618, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 181, 1968, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (619, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 181, 1968, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (620, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 181, 1968, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (621, "FINE", 0, NULL, 11.2, 16.00, "None", 16.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 181, 1968, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (622, "VERY FINE", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (16, 181, 1968, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (623, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 3, 1996, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (624, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 3, 1996, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (625, "FINE", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 3, 1996, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (626, "VERY FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 7, 1996, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (627, "GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 7, 1996, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (628, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 7, 1996, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (629, "FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 7, 1996, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (630, "VERY FINE", 0, NULL, 53.9, 77.00, "None", 77.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 7, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (631, "NEAR MINT", 0, NULL, 73.5, 105.00, "None", 105.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 10, 1996, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (632, "FINE", 0, NULL, 47.599999999999994, 68.00, "None", 68.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 10, 1996, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (633, "VERY FINE", 0, NULL, 73.5, 105.00, "None", 105.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 10, 1996, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (634, "NEAR MINT", 0, NULL, 86.8, 124.00, "None", 124.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 8, 1996, 4.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (635, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 8, 1996, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (636, "FINE", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 8, 1996, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (637, "VERY FINE", 0, NULL, 32.9, 47.00, "None", 47.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 8, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (638, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 9, 1996, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (639, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 9, 1996, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (640, "FINE", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 9, 1996, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (641, "VERY FINE", 0, NULL, 32.9, 47.00, "None", 47.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 9, 1996, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (642, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 2, 1996, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (643, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 2, 1996, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (644, "FINE", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 2, 1996, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (645, "VERY FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 2, 1996, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (646, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 11, 1996, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (647, "VERY GOOD", 0, NULL, 29.4, 42.00, "None", 42.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 11, 1996, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (648, "FINE", 0, NULL, 46.199999999999996, 66.00, "None", 66.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 6, 1996, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (649, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 12, 1996, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (650, "VERY FINE", 0, NULL, 92.39999999999999, 132.00, "None", 132.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 1, 1996, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (651, "VERY GOOD", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 1, 1996, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (652, "FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 1, 1996, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (653, "VERY FINE", 0, NULL, 55.3, 79.00, "None", 79.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 5, 1996, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (654, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 5, 1996, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (655, "VERY FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 5, 1996, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (656, "NEAR MINT", 0, NULL, 44.8, 64.00, "None", 64.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 4, 1996, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (657, "GOOD", 0, NULL, 9.799999999999999, 14.00, "None", 14.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 4, 1996, 4.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (658, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (17, 4, 1996, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (659, "FINE", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 9, 1996, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (660, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 9, 1996, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (661, "VERY FINE", 0, NULL, 12.774999999999999, 18.25, "None", 18.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 9, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (662, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 6, 1996, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (663, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 6, 1996, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (664, "VERY FINE", 0, NULL, 12.774999999999999, 18.25, "None", 18.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 6, 1996, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (665, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 1, 1996, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (666, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 1, 1996, 7.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (667, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 1, 1996, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (668, "NEAR MINT", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 7, 1996, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (669, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 7, 1996, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (670, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 7, 1996, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (671, "FINE", 0, NULL, 8.049999999999999, 11.50, "None", 11.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 7, 1996, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (672, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (18, 7, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (673, "NEAR MINT", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 2, 2014, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (674, "FAIR", 0, NULL, 3.15, 4.50, "None", 4.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 2, 2014, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (675, "GOOD", 0, NULL, 6.125, 8.75, "None", 8.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 2, 2014, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (676, "VERY GOOD", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 2, 2014, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (677, "FINE", 0, NULL, 15.049999999999999, 21.50, "None", 21.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 2, 2014, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (678, "VERY FINE", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 2, 2014, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (679, "NEAR MINT", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 3, 2014, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (680, "GOOD", 0, NULL, 6.125, 8.75, "None", 8.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 3, 2014, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (681, "VERY GOOD", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 3, 2014, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (682, "FINE", 0, NULL, 15.049999999999999, 21.50, "None", 21.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 3, 2014, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (683, "VERY FINE", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 3, 2014, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (684, "NEAR MINT", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 1, 2014, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (685, "FAIR", 0, NULL, 6.125, 8.75, "None", 8.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 1, 2014, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (686, "GOOD", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 1, 2014, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (687, "VERY GOOD", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 1, 2014, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (688, "FINE", 0, NULL, 29.4, 42.00, "None", 42.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 1, 2014, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (689, "VERY FINE", 0, NULL, 42.699999999999996, 61.00, "None", 61.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (19, 1, 2014, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (690, "NEAR MINT", 0, NULL, 52.5, 75.00, "None", 75.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 2, 2015, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (691, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 2, 2015, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (692, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 2, 2015, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (693, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 2, 2015, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (694, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 1, 2015, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (695, "FAIR", 0, NULL, 3.15, 4.50, "None", 4.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 1, 2015, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (696, "GOOD", 0, NULL, 6.125, 8.75, "None", 8.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 1, 2015, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (697, "VERY GOOD", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 1, 2015, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (698, "FINE", 0, NULL, 15.575, 22.25, "None", 22.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 1, 2015, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (699, "VERY FINE", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 1, 2015, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (700, "NEAR MINT", 0, NULL, 27.299999999999997, 39.00, "None", 39.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 3, 2015, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (701, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 3, 2015, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (702, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 3, 2015, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (703, "NEAR MINT", 0, NULL, 17.5, 25.00, "None", 25.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 4, 2015, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (704, "GOOD", 0, NULL, 2.8, 4.00, "None", 4.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 4, 2015, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (705, "VERY GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 4, 2015, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (706, "FINE", 0, NULL, 6.125, 8.75, "None", 8.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 4, 2015, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (707, "VERY FINE", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (20, 4, 2015, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (708, "NEAR MINT", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (21, 1, 2018, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (709, "GOOD", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (21, 1, 2018, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (710, "FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (21, 1, 2018, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (711, "NEAR MINT", 0, NULL, 54.599999999999994, 78.00, "None", 78.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (22, 1, 2004, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (712, "NEAR MINT", 0, NULL, 70.0, 100.00, "None", 100.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 37, 2008, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (713, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 37, 2008, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (714, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 37, 2008, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (715, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 37, 2008, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (716, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 37, 2008, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (717, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 1, 2008, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (718, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 1, 2008, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (719, "FINE", 0, NULL, 11.2, 16.00, "None", 16.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 1, 2008, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (720, "VERY FINE", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 1, 2008, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (721, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 36, 2008, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (722, "FAIR", 0, NULL, 2.4499999999999997, 3.50, "None", 3.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 36, 2008, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (723, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 36, 2008, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (724, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 36, 2008, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (725, "FINE", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 36, 2008, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (726, "VERY FINE", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 36, 2008, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (727, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 38, 2008, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (728, "VERY GOOD", 0, NULL, 9.274999999999999, 13.25, "None", 13.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 38, 2008, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (729, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 38, 2008, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (730, "VERY FINE", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 38, 2008, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (731, "NEAR MINT", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 39, 2008, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (732, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 39, 2008, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (733, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 39, 2008, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (734, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 39, 2008, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (735, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (23, 39, 2008, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (736, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (24, 1, 2001, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (737, "FINE", 0, NULL, 15.575, 22.25, "None", 22.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (24, 1, 2001, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (738, "NEAR MINT", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (25, 1, 2018, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (739, "FINE", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (25, 1, 2018, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (740, "VERY FINE", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (25, 1, 2018, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (741, "NEAR MINT", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (26, 1, 2014, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (742, "NEAR MINT", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 2, 2010, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (743, "FINE", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 2, 2010, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (744, "VERY FINE", 0, NULL, 7.0, 10.00, "None", 10.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 2, 2010, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (745, "NEAR MINT", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 3, 2010, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (746, "FINE", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 3, 2010, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (747, "VERY FINE", 0, NULL, 6.6499999999999995, 9.50, "None", 9.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 3, 2010, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (748, "NEAR MINT", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 1, 2010, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (749, "FINE", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 1, 2010, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (750, "VERY FINE", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 1, 2010, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (751, "NEAR MINT", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 4, 2010, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (752, "VERY FINE", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (27, 4, 2010, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (753, "NEAR MINT", 0, NULL, 7.699999999999999, 11.00, "None", 11.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (28, 1, 2010, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (754, "FINE", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (28, 1, 2010, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (755, "VERY FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (28, 1, 2010, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (756, "NEAR MINT", 0, NULL, 46.199999999999996, 66.00, "None", 66.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (28, 3, 2010, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (757, "NEAR MINT", 0, NULL, 61.599999999999994, 88.00, "None", 88.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (28, 4, 2010, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (758, "FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (28, 4, 2010, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (759, "NEAR MINT", 0, NULL, 73.5, 105.00, "None", 105.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (28, 2, 2010, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (760, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (28, 2, 2010, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (761, "VERY FINE", 0, NULL, 27.299999999999997, 39.00, "None", 39.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (28, 2, 2010, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (762, "NEAR MINT", 0, NULL, 32.9, 47.00, "None", 47.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 3, 2010, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (763, "FINE", 0, NULL, 5.949999999999999, 8.50, "None", 8.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 3, 2010, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (764, "VERY FINE", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 3, 2010, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (765, "NEAR MINT", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 2, 2010, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (766, "FINE", 0, NULL, 6.125, 8.75, "None", 8.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 2, 2010, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (767, "VERY FINE", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 2, 2010, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (768, "NEAR MINT", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 1, 2010, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (769, "VERY GOOD", 0, NULL, 3.5, 5.00, "None", 5.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 1, 2010, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (770, "FINE", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 1, 2010, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (771, "VERY FINE", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (29, 1, 2010, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (772, "NEAR MINT", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 18, 2011, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (773, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 18, 2011, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (774, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 18, 2011, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (775, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 18, 2011, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (776, "VERY FINE", 0, NULL, 13.299999999999999, 19.00, "None", 19.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 18, 2011, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (777, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 19, 2011, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (778, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 19, 2011, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (779, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 19, 2011, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (780, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 19, 2011, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (781, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (30, 19, 2011, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (782, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (31, 1, 2012, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (783, "NEAR MINT", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (32, 1, 2000, 4.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (784, "VERY GOOD", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (32, 1, 2000, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (785, "FINE", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (32, 1, 2000, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (786, "VERY FINE", 0, NULL, 47.25, 67.50, "None", 67.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 1, 1991, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (787, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 1, 1991, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (788, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 1, 1991, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (789, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 1, 1991, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (790, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 1, 1991, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (791, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 2, 1991, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (792, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 2, 1991, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (793, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 2, 1991, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (794, "VERY FINE", 0, NULL, 12.424999999999999, 17.75, "None", 17.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 2, 1991, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (795, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 4, 1991, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (796, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 4, 1991, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (797, "VERY GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 4, 1991, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (798, "FINE", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 4, 1991, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (799, "VERY FINE", 0, NULL, 12.424999999999999, 17.75, "None", 17.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 4, 1991, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (800, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 3, 1991, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (801, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 3, 1991, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (802, "VERY GOOD", 0, NULL, 5.074999999999999, 7.25, "None", 7.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 3, 1991, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (803, "FINE", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 3, 1991, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (804, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (33, 3, 1991, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (805, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (34, 1, 1993, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (806, "FINE", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (34, 1, 1993, 7.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (807, "VERY FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (34, 1, 1993, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (808, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (35, 1, 2014, 2.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (809, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (35, 1, 2014, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (810, "VERY GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (35, 1, 2014, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (811, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (35, 1, 2014, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (812, "VERY FINE", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (35, 1, 2014, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (813, "NEAR MINT", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 7, 1996, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (814, "FINE", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 6, 1996, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (815, "VERY GOOD", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 6, 1996, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (816, "FINE", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 5, 1996, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (817, "FAIR", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 5, 1996, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (818, "VERY GOOD", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 10, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (819, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 2, 1996, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (820, "GOOD", 0, NULL, 11.2, 16.00, "None", 16.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 2, 1996, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (821, "FINE", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 2, 1996, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (822, "VERY FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 2, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (823, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 8, 1996, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (824, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 4, 1996, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (825, "VERY GOOD", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 1, 1996, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (826, "VERY GOOD", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 1, 1996, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (827, "VERY FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 1, 1996, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (828, "NEAR MINT", 0, NULL, 35.0, 50.00, "None", 50.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 3, 1996, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (829, "GOOD", 0, NULL, 11.2, 16.00, "None", 16.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 3, 1996, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (830, "FINE", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 3, 1996, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (831, "VERY FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (36, 3, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (832, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (37, 2, 2005, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (833, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (37, 4, 2005, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (834, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (37, 5, 2005, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (835, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 19, 2004, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (836, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 15, 2004, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (837, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 15, 2004, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (838, "VERY FINE", 0, NULL, 13.649999999999999, 19.50, "None", 19.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 15, 2004, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (839, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 16, 2004, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (840, "FINE", 0, NULL, 8.575, 12.25, "None", 12.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 16, 2004, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (841, "VERY FINE", 0, NULL, 13.649999999999999, 19.50, "None", 19.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 16, 2004, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (842, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 13, 2004, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (843, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 13, 2004, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (844, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 13, 2004, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (845, "VERY FINE", 0, NULL, 13.299999999999999, 19.00, "None", 19.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 13, 2004, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (846, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 4, 2004, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (847, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 4, 2004, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (848, "FINE", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 4, 2004, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (849, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 4, 2004, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (850, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 3, 2004, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (851, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 3, 2004, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (852, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 3, 2004, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (853, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 3, 2004, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (854, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 5, 2004, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (855, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 5, 2004, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (856, "VERY FINE", 0, NULL, 12.424999999999999, 17.75, "None", 17.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 5, 2004, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (857, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 2, 2004, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (858, "FAIR", 0, NULL, 2.0999999999999996, 3.00, "None", 3.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 2, 2004, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (859, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 2, 2004, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (860, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 2, 2004, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (861, "FINE", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 2, 2004, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (862, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 2, 2004, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (863, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 8, 2004, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (864, "FINE", 0, NULL, 8.575, 12.25, "None", 12.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 8, 2004, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (865, "VERY FINE", 0, NULL, 12.424999999999999, 17.75, "None", 17.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 8, 2004, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (866, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 14, 2004, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (867, "FINE", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 14, 2004, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (868, "VERY FINE", 0, NULL, 12.424999999999999, 17.75, "None", 17.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 14, 2004, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (869, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 9, 2004, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (870, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 9, 2004, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (871, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 9, 2004, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (872, "FINE", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 9, 2004, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (873, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 9, 2004, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (874, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 17, 2004, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (875, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 17, 2004, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (876, "VERY FINE", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 17, 2004, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (877, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 11, 2004, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (878, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 11, 2004, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (879, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 11, 2004, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (880, "FINE", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 11, 2004, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (881, "VERY FINE", 0, NULL, 12.424999999999999, 17.75, "None", 17.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 11, 2004, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (882, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 20, 2004, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (883, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 7, 2004, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (884, "FINE", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 7, 2004, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (885, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 7, 2004, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (886, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 10, 2004, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (887, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 10, 2004, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (888, "FINE", 0, NULL, 8.924999999999999, 12.75, "None", 12.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 10, 2004, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (889, "VERY FINE", 0, NULL, 12.424999999999999, 17.75, "None", 17.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 10, 2004, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (890, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 12, 2004, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (891, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 12, 2004, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (892, "FINE", 0, NULL, 8.575, 12.25, "None", 12.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 12, 2004, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (893, "VERY FINE", 0, NULL, 12.424999999999999, 17.75, "None", 17.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 12, 2004, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (894, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 18, 2004, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (895, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 18, 2004, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (896, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 18, 2004, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (897, "NEAR MINT", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 6, 2004, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (898, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 6, 2004, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (899, "FINE", 0, NULL, 8.575, 12.25, "None", 12.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 6, 2004, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (900, "VERY FINE", 0, NULL, 12.424999999999999, 17.75, "None", 17.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 6, 2004, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (901, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 1, 2004, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (902, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 1, 2004, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (903, "VERY FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (38, 1, 2004, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (904, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 3, 2019, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (905, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 3, 2019, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (906, "VERY FINE", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 4, 2019, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (907, "GOOD", 0, NULL, 4.0249999999999995, 5.75, "None", 5.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 4, 2019, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (908, "VERY GOOD", 0, NULL, 5.949999999999999, 8.50, "None", 8.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 4, 2019, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (909, "FINE", 0, NULL, 9.799999999999999, 14.00, "None", 14.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 4, 2019, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (910, "VERY FINE", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 4, 2019, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (911, "NEAR MINT", 0, NULL, 19.599999999999998, 28.00, "None", 28.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 2, 2019, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (912, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 2, 2019, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (913, "NEAR MINT", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 1, 2019, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (914, "FINE", 0, NULL, 15.575, 22.25, "None", 22.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 1, 2019, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (915, "VERY FINE", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (39, 1, 2019, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (916, "NEAR MINT", 0, NULL, 30.099999999999998, 43.00, "None", 43.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 17, 2011, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (917, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 17, 2011, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (918, "NEAR MINT", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 19, 2011, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (919, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 19, 2011, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (920, "NEAR MINT", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 20, 2011, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (921, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 20, 2011, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (922, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 20, 2011, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (923, "NEAR MINT", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 21, 2011, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (924, "VERY GOOD", 0, NULL, 3.5, 5.00, "None", 5.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 21, 2011, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (925, "FINE", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 21, 2011, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (926, "VERY FINE", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 21, 2011, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (927, "NEAR MINT", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 22, 2011, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (928, "VERY GOOD", 0, NULL, 3.5, 5.00, "None", 5.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 22, 2011, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (929, "FINE", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 22, 2011, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (930, "VERY FINE", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 22, 2011, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (931, "NEAR MINT", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 18, 2011, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (932, "NEAR MINT", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 16, 2011, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (933, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 16, 2011, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (934, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 16, 2011, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (935, "NEAR MINT", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 15, 2011, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (936, "VERY GOOD", 0, NULL, 3.5, 5.00, "None", 5.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 15, 2011, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (937, "FINE", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 15, 2011, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (938, "VERY FINE", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (40, 15, 2011, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (939, "NEAR MINT", 0, NULL, 9.799999999999999, 14.00, "None", 14.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (41, 1, 2015, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (940, "VERY GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (41, 1, 2015, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (941, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (41, 1, 2015, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (942, "VERY FINE", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (41, 1, 2015, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (943, "NEAR MINT", 0, NULL, 35.699999999999996, 51.00, "None", 51.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 102, 1962, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (944, "FAIR", 0, NULL, 209.29999999999998, 299.00, "None", 299.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 117, 1962, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (945, "GOOD", 0, NULL, 121.8, 174.00, "None", 174.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 117, 1962, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (946, "VERY GOOD", 0, NULL, 244.29999999999998, 349.00, "None", 349.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 117, 1962, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (947, "FINE", 0, NULL, 348.59999999999997, 498.00, "None", 498.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 117, 1962, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (948, "VERY FINE", 0, NULL, 580.3, 829.00, "None", 829.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 116, 1962, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (949, "FAIR", 0, NULL, 62.3, 89.00, "None", 89.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 116, 1962, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (950, "GOOD", 0, NULL, 125.3, 179.00, "None", 179.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 116, 1962, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (951, "FINE", 0, NULL, 348.59999999999997, 498.00, "None", 498.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 188, 1962, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (952, "FAIR", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 188, 1962, 2.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (953, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 188, 1962, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (954, "VERY GOOD", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 188, 1962, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (955, "FINE", 0, NULL, 51.099999999999994, 73.00, "None", 73.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 188, 1962, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (956, "VERY FINE", 0, NULL, 86.1, 123.00, "None", 123.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 83, 1962, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (957, "FINE", 0, NULL, 102375.0, 146250.00, "None", 146250.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 83, 1962, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (958, "FINE", 0, NULL, 102375.0, 146250.00, "None", 146250.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 83, 1962, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (959, "FINE", 0, NULL, 102375.0, 146250.00, "None", 146250.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 83, 1962, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (960, "FINE", 0, NULL, 102375.0, 146250.00, "None", 146250.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 131, 1962, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (961, "GOOD", 0, NULL, 47.599999999999994, 68.00, "None", 68.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 131, 1962, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (962, "VERY GOOD", 0, NULL, 91.69999999999999, 131.00, "None", 131.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 131, 1962, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (963, "FINE", 0, NULL, 132.29999999999998, 189.00, "None", 189.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 99, 1962, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (964, "VERY GOOD", 0, NULL, 758.0999999999999, 1083.00, "None", 1083.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 99, 1962, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (965, "FINE", 0, NULL, 1064.7, 1521.00, "None", 1521.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 93, 1962, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (966, "VERY FINE", 0, NULL, 2389.1, 3413.00, "None", 3413.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 142, 1962, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (967, "GOOD", 0, NULL, 40.599999999999994, 58.00, "None", 58.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 142, 1962, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (968, "VERY GOOD", 0, NULL, 80.5, 115.00, "None", 115.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 142, 1962, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (969, "FINE", 0, NULL, 112.0, 160.00, "None", 160.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 170, 1962, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (970, "GOOD", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 170, 1962, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (971, "VERY GOOD", 0, NULL, 48.3, 69.00, "None", 69.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 170, 1962, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (972, "FINE", 0, NULL, 66.5, 95.00, "None", 95.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 170, 1962, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (973, "VERY FINE", 0, NULL, 111.3, 159.00, "None", 159.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (974, "GOOD", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (975, "VERY GOOD", 0, NULL, 50.4, 72.00, "None", 72.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (976, "FINE", 0, NULL, 70.0, 100.00, "None", 100.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (977, "VERY FINE", 0, NULL, 118.99999999999999, 170.00, "None", 170.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (978, "GOOD", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (979, "VERY GOOD", 0, NULL, 50.4, 72.00, "None", 72.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (980, "FINE", 0, NULL, 70.0, 100.00, "None", 100.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (981, "VERY FINE", 0, NULL, 118.99999999999999, 170.00, "None", 170.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (982, "GOOD", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (983, "VERY GOOD", 0, NULL, 50.4, 72.00, "None", 72.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (984, "FINE", 0, NULL, 70.0, 100.00, "None", 100.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (985, "VERY FINE", 0, NULL, 118.99999999999999, 170.00, "None", 170.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (986, "GOOD", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (987, "VERY GOOD", 0, NULL, 50.4, 72.00, "None", 72.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (988, "FINE", 0, NULL, 70.0, 100.00, "None", 100.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 175, 1962, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (989, "VERY FINE", 0, NULL, 118.99999999999999, 170.00, "None", 170.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 107, 1962, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (990, "FAIR", 0, NULL, 114.1, 163.00, "None", 163.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 189, 1962, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (991, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 168, 1962, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (992, "GOOD", 0, NULL, 68.6, 98.00, "None", 98.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 166, 1962, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (993, "GOOD", 0, NULL, 87.5, 125.00, "None", 125.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 166, 1962, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (994, "FINE", 0, NULL, 245.7, 351.00, "None", 351.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 166, 1962, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (995, "VERY FINE", 0, NULL, 409.5, 585.00, "None", 585.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 166, 1962, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (996, "NEAR MINT", 0, NULL, 546.0, 780.00, "None", 780.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 179, 1962, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (997, "GOOD", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 179, 1962, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (998, "VERY GOOD", 0, NULL, 51.099999999999994, 73.00, "None", 73.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 179, 1962, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (999, "FINE", 0, NULL, 68.6, 98.00, "None", 98.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 179, 1962, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1000, "VERY FINE", 0, NULL, 121.1, 173.00, "None", 173.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 163, 1962, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1001, "GOOD", 0, NULL, 28.7, 41.00, "None", 41.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 163, 1962, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1002, "FINE", 0, NULL, 79.8, 114.00, "None", 114.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 163, 1962, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1003, "VERY FINE", 0, NULL, 136.5, 195.00, "None", 195.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 187, 1962, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1004, "GOOD", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 112, 1962, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1005, "GOOD", 0, NULL, 637.0, 910.00, "None", 910.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 112, 1962, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1006, "VERY FINE", 0, NULL, 2987.6, 4268.00, "None", 4268.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 88, 1962, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1007, "GOOD", 0, NULL, 891.8, 1274.00, "None", 1274.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 111, 1962, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1008, "FAIR", 0, NULL, 81.89999999999999, 117.00, "None", 117.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 111, 1962, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1009, "GOOD", 0, NULL, 163.79999999999998, 234.00, "None", 234.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 111, 1962, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1010, "FINE", 0, NULL, 461.99999999999994, 660.00, "None", 660.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 111, 1962, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1011, "VERY FINE", 0, NULL, 769.3, 1099.00, "None", 1099.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 138, 1962, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1012, "FAIR", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 138, 1962, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1013, "GOOD", 0, NULL, 46.199999999999996, 66.00, "None", 66.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 138, 1962, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1014, "VERY GOOD", 0, NULL, 88.19999999999999, 126.00, "None", 126.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 138, 1962, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1015, "FINE", 0, NULL, 125.99999999999999, 180.00, "None", 180.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 138, 1962, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1016, "VERY FINE", 0, NULL, 223.29999999999998, 319.00, "None", 319.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 105, 1962, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1017, "FAIR", 0, NULL, 114.1, 163.00, "None", 163.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 105, 1962, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1018, "FINE", 0, NULL, 641.9, 917.00, "None", 917.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 174, 1962, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1019, "VERY GOOD", 0, NULL, 50.4, 72.00, "None", 72.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 174, 1962, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1020, "FINE", 0, NULL, 67.89999999999999, 97.00, "None", 97.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 174, 1962, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1021, "VERY FINE", 0, NULL, 121.1, 173.00, "None", 173.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 151, 1962, 2.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1022, "GOOD", 0, NULL, 51.099999999999994, 73.00, "None", 73.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 151, 1962, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1023, "VERY GOOD", 0, NULL, 100.8, 144.00, "None", 144.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (42, 151, 1962, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1024, "FINE", 0, NULL, 141.39999999999998, 202.00, "None", 202.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 1, 2012, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1025, "GOOD", 0, NULL, 6.125, 8.75, "None", 8.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 1, 2012, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1026, "VERY GOOD", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 1, 2012, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1027, "FINE", 0, NULL, 13.299999999999999, 19.00, "None", 19.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 1, 2012, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1028, "VERY FINE", 0, NULL, 20.299999999999997, 29.00, "None", 29.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 1, 2012, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1029, "NEAR MINT", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 10, 2012, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1030, "FAIR", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 10, 2012, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1031, "GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 10, 2012, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1032, "VERY GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 10, 2012, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1033, "FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 10, 2012, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1034, "VERY FINE", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 10, 2012, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1035, "NEAR MINT", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 9, 2012, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1036, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 9, 2012, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1037, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 9, 2012, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1038, "FINE", 0, NULL, 8.575, 12.25, "None", 12.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 9, 2012, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1039, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 9, 2012, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1040, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 8, 2012, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1041, "FAIR", 0, NULL, 2.4499999999999997, 3.50, "None", 3.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 8, 2012, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1042, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 8, 2012, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1043, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 8, 2012, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1044, "FINE", 0, NULL, 11.549999999999999, 16.50, "None", 16.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 8, 2012, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1045, "VERY FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (43, 8, 2012, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1046, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 3, 1996, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1047, "FAIR", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 3, 1996, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1048, "GOOD", 0, NULL, 9.799999999999999, 14.00, "None", 14.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 3, 1996, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1049, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 3, 1996, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1050, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 3, 1996, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1051, "VERY FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 3, 1996, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1052, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 1, 1996, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1053, "FAIR", 0, NULL, 6.125, 8.75, "None", 8.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 1, 1996, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1054, "GOOD", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 1, 1996, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1055, "VERY GOOD", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 1, 1996, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1056, "FINE", 0, NULL, 29.4, 42.00, "None", 42.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 1, 1996, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1057, "VERY FINE", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 1, 1996, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1058, "NEAR MINT", 0, NULL, 52.5, 75.00, "None", 75.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 2, 1996, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1059, "FAIR", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 2, 1996, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1060, "GOOD", 0, NULL, 9.799999999999999, 14.00, "None", 14.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 2, 1996, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1061, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 2, 1996, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1062, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 2, 1996, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1063, "VERY FINE", 0, NULL, 35.699999999999996, 51.00, "None", 51.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 2, 1996, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1064, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 4, 1996, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1065, "FAIR", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 4, 1996, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1066, "GOOD", 0, NULL, 9.799999999999999, 14.00, "None", 14.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 4, 1996, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1067, "VERY GOOD", 0, NULL, 14.7, 21.00, "None", 21.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 4, 1996, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1068, "FINE", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 4, 1996, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1069, "VERY FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (44, 4, 1996, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1070, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 2, 1999, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1071, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 2, 1999, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1072, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 2, 1999, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1073, "FINE", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 2, 1999, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1074, "VERY FINE", 0, NULL, 13.649999999999999, 19.50, "None", 19.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 2, 1999, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1075, "NEAR MINT", 0, NULL, 17.5, 25.00, "None", 25.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 3, 1999, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1076, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 3, 1999, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1077, "VERY FINE", 0, NULL, 13.299999999999999, 19.00, "None", 19.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 3, 1999, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1078, "NEAR MINT", 0, NULL, 17.5, 25.00, "None", 25.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 1, 1999, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1079, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 1, 1999, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1080, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (45, 1, 1999, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1081, "NEAR MINT", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 22, 2004, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1082, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 22, 2004, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1083, "FINE", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 22, 2004, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1084, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 22, 2004, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1085, "NEAR MINT", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 30, 2004, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1086, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 30, 2004, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1087, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 30, 2004, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1088, "FINE", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 30, 2004, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1089, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 30, 2004, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1090, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 29, 2004, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1091, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 29, 2004, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1092, "FINE", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 29, 2004, 7.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1093, "VERY FINE", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 29, 2004, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1094, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 8, 2004, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1095, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 8, 2004, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1096, "FINE", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 8, 2004, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1097, "VERY FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 8, 2004, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1098, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 12, 2004, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1099, "FINE", 0, NULL, 11.549999999999999, 16.50, "None", 16.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 12, 2004, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1100, "VERY FINE", 0, NULL, 15.749999999999998, 22.50, "None", 22.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 12, 2004, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1101, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 17, 2004, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1102, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 17, 2004, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1103, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 17, 2004, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1104, "VERY FINE", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 17, 2004, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1105, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 23, 2004, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1106, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 23, 2004, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1107, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 23, 2004, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1108, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 23, 2004, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1109, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 23, 2004, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1110, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 32, 2004, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1111, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 32, 2004, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1112, "FINE", 0, NULL, 11.2, 16.00, "None", 16.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 32, 2004, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1113, "VERY FINE", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 32, 2004, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1114, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 4, 2004, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1115, "FAIR", 0, NULL, 2.4499999999999997, 3.50, "None", 3.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 4, 2004, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1116, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 4, 2004, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1117, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 4, 2004, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1118, "FINE", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 4, 2004, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1119, "VERY FINE", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 4, 2004, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1120, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 28, 2004, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1121, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 28, 2004, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1122, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 28, 2004, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1123, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 28, 2004, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1124, "NEAR MINT", 0, NULL, 21.7, 31.00, "None", 31.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 6, 2004, 2.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1125, "GOOD", 0, NULL, 49.0, 70.00, "None", 70.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 6, 2004, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1126, "FINE", 0, NULL, 118.99999999999999, 170.00, "None", 170.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 6, 2004, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1127, "VERY FINE", 0, NULL, 184.1, 263.00, "None", 263.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 6, 2004, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1128, "NEAR MINT", 0, NULL, 237.99999999999997, 340.00, "None", 340.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 27, 2004, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1129, "FAIR", 0, NULL, 2.4499999999999997, 3.50, "None", 3.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 27, 2004, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1130, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 27, 2004, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1131, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 27, 2004, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1132, "FINE", 0, NULL, 11.899999999999999, 17.00, "None", 17.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 27, 2004, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1133, "VERY FINE", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 27, 2004, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1134, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 18, 2004, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1135, "FAIR", 0, NULL, 2.4499999999999997, 3.50, "None", 3.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 18, 2004, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1136, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 18, 2004, 3.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1137, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 18, 2004, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1138, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 18, 2004, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1139, "VERY FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 18, 2004, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1140, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 14, 2004, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1141, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 14, 2004, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1142, "FINE", 0, NULL, 11.2, 16.00, "None", 16.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 14, 2004, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1143, "VERY FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 14, 2004, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1144, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 20, 2004, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1145, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 20, 2004, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1146, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 20, 2004, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1147, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 20, 2004, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1148, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 20, 2004, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1149, "NEAR MINT", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 31, 2004, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1150, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 31, 2004, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1151, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 31, 2004, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1152, "VERY FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 31, 2004, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1153, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 35, 2004, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1154, "FINE", 0, NULL, 11.549999999999999, 16.50, "None", 16.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 35, 2004, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1155, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (46, 35, 2004, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1156, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (47, 1, 2012, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1157, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (47, 1, 2012, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1158, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (47, 1, 2012, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1159, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (47, 1, 2012, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1160, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (47, 1, 2012, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1161, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (48, 1, 2005, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1162, "VERY GOOD", 0, NULL, 3.5, 5.00, "None", 5.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (48, 1, 2005, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1163, "FINE", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (48, 1, 2005, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1164, "VERY FINE", 0, NULL, 6.6499999999999995, 9.50, "None", 9.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (48, 1, 2005, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1165, "NEAR MINT", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (49, 1, 2010, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1166, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (50, 1, 2004, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1167, "GOOD", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (50, 1, 2004, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1168, "VERY GOOD", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (50, 1, 2004, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1169, "FINE", 0, NULL, 33.599999999999994, 48.00, "None", 48.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (50, 1, 2004, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1170, "VERY FINE", 0, NULL, 37.8, 54.00, "None", 54.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (50, 1, 2004, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1171, "NEAR MINT", 0, NULL, 42.0, 60.00, "None", 60.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (51, 1, 2005, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1172, "FINE", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (51, 1, 2005, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1173, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (51, 1, 2005, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1174, "NEAR MINT", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (52, 1, 2006, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1175, "FINE", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (52, 1, 2006, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1176, "VERY FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (52, 1, 2006, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1177, "NEAR MINT", 0, NULL, 35.0, 50.00, "None", 50.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (53, 1, 2008, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1178, "GOOD", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (53, 1, 2008, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1179, "VERY GOOD", 0, NULL, 21.0, 30.00, "None", 30.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (53, 1, 2008, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1180, "FINE", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (53, 1, 2008, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1181, "VERY FINE", 0, NULL, 31.499999999999996, 45.00, "None", 45.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (53, 1, 2008, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1182, "NEAR MINT", 0, NULL, 35.0, 50.00, "None", 50.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (54, 1, 2012, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1183, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (55, 1, 2012, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1184, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (56, 1, 2010, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1185, "VERY FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (56, 1, 2010, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1186, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (57, 1, 2009, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1187, "NEAR MINT", 0, NULL, 35.0, 50.00, "None", 50.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (58, 1, 2011, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1188, "VERY FINE", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (58, 1, 2011, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1189, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 2, 2010, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1190, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 2, 2010, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1191, "VERY GOOD", 0, NULL, 5.425, 7.75, "None", 7.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 2, 2010, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1192, "FINE", 0, NULL, 8.575, 12.25, "None", 12.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 2, 2010, 7.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1193, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 2, 2010, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1194, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 1, 2010, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1195, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 1, 2010, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1196, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 1, 2010, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1197, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 1, 2010, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1198, "VERY FINE", 0, NULL, 12.774999999999999, 18.25, "None", 18.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (59, 1, 2010, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1199, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (60, 1, 2011, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1200, "NEAR MINT", 0, NULL, 28.0, 40.00, "None", 40.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 1, 2011, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1201, "FINE", 0, NULL, 30.799999999999997, 44.00, "None", 44.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 1, 2011, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1202, "VERY FINE", 0, NULL, 44.8, 64.00, "None", 64.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 11, 2011, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1203, "NEAR MINT", 0, NULL, 35.0, 50.00, "None", 50.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 2, 2011, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1204, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 8, 2011, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1205, "VERY GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 8, 2011, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1206, "NEAR MINT", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 7, 2011, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1207, "NEAR MINT", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 6, 2011, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1208, "NEAR MINT", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 5, 2011, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1209, "FINE", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 5, 2011, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1210, "VERY FINE", 0, NULL, 37.099999999999994, 53.00, "None", 53.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (61, 5, 2011, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1211, "NEAR MINT", 0, NULL, 49.0, 70.00, "None", 70.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 133, 1959, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1212, "GOOD", 0, NULL, 145.6, 208.00, "None", 208.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 151, 1959, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1213, "FAIR", 0, NULL, 36.4, 52.00, "None", 52.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 151, 1959, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1214, "GOOD", 0, NULL, 72.1, 103.00, "None", 103.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 151, 1959, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1215, "VERY GOOD", 0, NULL, 141.39999999999998, 202.00, "None", 202.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 139, 1959, 2.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1216, "GOOD", 0, NULL, 1456.0, 2080.00, "None", 2080.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 139, 1959, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1217, "VERY GOOD", 0, NULL, 2867.2, 4096.00, "None", 4096.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 194, 1959, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1218, "VERY GOOD", 0, NULL, 41.3, 59.00, "None", 59.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 194, 1959, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1219, "FINE", 0, NULL, 61.599999999999994, 88.00, "None", 88.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 127, 1959, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1220, "VERY GOOD", 0, NULL, 412.29999999999995, 589.00, "None", 589.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 127, 1959, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1221, "FINE", 0, NULL, 614.5999999999999, 878.00, "None", 878.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 183, 1959, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1222, "FAIR", 0, NULL, 12.774999999999999, 18.25, "None", 18.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 183, 1959, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1223, "GOOD", 0, NULL, 25.2, 36.00, "None", 36.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 183, 1959, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1224, "VERY GOOD", 0, NULL, 48.3, 69.00, "None", 69.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 183, 1959, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1225, "FINE", 0, NULL, 70.0, 100.00, "None", 100.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 183, 1959, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1226, "VERY FINE", 0, NULL, 121.1, 173.00, "None", 173.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 137, 1959, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1227, "GOOD", 0, NULL, 347.2, 496.00, "None", 496.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 137, 1959, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1228, "VERY GOOD", 0, NULL, 672.0, 960.00, "None", 960.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 185, 1959, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1229, "VERY GOOD", 0, NULL, 49.0, 70.00, "None", 70.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 185, 1959, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1230, "FINE", 0, NULL, 70.0, 100.00, "None", 100.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 185, 1959, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1231, "VERY FINE", 0, NULL, 121.1, 173.00, "None", 173.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 156, 1959, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1232, "GOOD", 0, NULL, 55.3, 79.00, "None", 79.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 156, 1959, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1233, "VERY GOOD", 0, NULL, 113.39999999999999, 162.00, "None", 162.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 170, 1959, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1234, "GOOD", 0, NULL, 27.299999999999997, 39.00, "None", 39.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 170, 1959, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1235, "VERY GOOD", 0, NULL, 52.5, 75.00, "None", 75.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 170, 1959, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1236, "FINE", 0, NULL, 76.3, 109.00, "None", 109.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 166, 1959, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1237, "FAIR", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 166, 1959, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1238, "GOOD", 0, NULL, 44.099999999999994, 63.00, "None", 63.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (62, 166, 1959, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1239, "VERY GOOD", 0, NULL, 84.69999999999999, 121.00, "None", 121.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (63, 69, 1987, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1240, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (63, 69, 1987, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1241, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (63, 69, 1987, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1242, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (63, 69, 1987, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1243, "NEAR MINT", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 150, 1960, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1244, "FINE", 0, NULL, 10.325, 14.75, "None", 14.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 150, 1960, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1245, "VERY FINE", 0, NULL, 17.15, 24.50, "None", 24.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 150, 1960, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1246, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 105, 1960, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1247, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 105, 1960, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1248, "VERY FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 105, 1960, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1249, "NEAR MINT", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 119, 1960, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1250, "GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 119, 1960, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1251, "VERY GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 119, 1960, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1252, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 119, 1960, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1253, "VERY FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 119, 1960, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1254, "NEAR MINT", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 19, 1960, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1255, "FAIR", 0, NULL, 72.8, 104.00, "None", 104.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 19, 1960, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1256, "GOOD", 0, NULL, 143.5, 205.00, "None", 205.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 19, 1960, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1257, "VERY GOOD", 0, NULL, 291.2, 416.00, "None", 416.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 148, 1960, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1258, "FINE", 0, NULL, 10.325, 14.75, "None", 14.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 148, 1960, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1259, "VERY FINE", 0, NULL, 17.15, 24.50, "None", 24.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 148, 1960, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1260, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 108, 1960, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1261, "GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 108, 1960, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1262, "FINE", 0, NULL, 15.575, 22.25, "None", 22.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 108, 1960, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1263, "VERY FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 108, 1960, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1264, "NEAR MINT", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 110, 1960, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1265, "VERY FINE", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 115, 1960, 6.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1266, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 115, 1960, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1267, "VERY FINE", 0, NULL, 26.599999999999998, 38.00, "None", 38.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 115, 1960, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1268, "NEAR MINT", 0, NULL, 34.3, 49.00, "None", 49.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 155, 1960, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1269, "FINE", 0, NULL, 10.325, 14.75, "None", 14.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 155, 1960, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1270, "VERY FINE", 0, NULL, 16.275, 23.25, "None", 23.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 155, 1960, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1271, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 117, 1960, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1272, "GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 117, 1960, 3.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1273, "VERY GOOD", 0, NULL, 11.024999999999999, 15.75, "None", 15.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 117, 1960, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1274, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 117, 1960, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1275, "VERY FINE", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 176, 1960, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1276, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 176, 1960, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1277, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 177, 1960, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1278, "GOOD", 0, NULL, 4.55, 6.50, "None", 6.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 177, 1960, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1279, "FINE", 0, NULL, 11.375, 16.25, "None", 16.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 177, 1960, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1280, "VERY FINE", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 177, 1960, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1281, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 174, 1960, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1282, "FINE", 0, NULL, 11.375, 16.25, "None", 16.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 174, 1960, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1283, "VERY FINE", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 174, 1960, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1284, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 159, 1960, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1285, "VERY FINE", 0, NULL, 17.15, 24.50, "None", 24.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 159, 1960, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1286, "NEAR MINT", 0, NULL, 22.4, 32.00, "None", 32.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 184, 1960, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1287, "FINE", 0, NULL, 11.375, 16.25, "None", 16.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 184, 1960, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1288, "VERY FINE", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 131, 1960, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1289, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 131, 1960, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1290, "FINE", 0, NULL, 10.325, 14.75, "None", 14.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 131, 1960, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1291, "VERY FINE", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 13, 1960, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1292, "FAIR", 0, NULL, 145.6, 208.00, "None", 208.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 13, 1960, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1293, "GOOD", 0, NULL, 287.0, 410.00, "None", 410.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 152, 1960, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1294, "VERY FINE", 0, NULL, 17.15, 24.50, "None", 24.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 152, 1960, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1295, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 179, 1960, 4.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1296, "VERY GOOD", 0, NULL, 6.824999999999999, 9.75, "None", 9.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 179, 1960, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1297, "FINE", 0, NULL, 11.375, 16.25, "None", 16.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 179, 1960, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1298, "VERY FINE", 0, NULL, 17.325, 24.75, "None", 24.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 179, 1960, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1299, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 121, 1960, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1300, "GOOD", 0, NULL, 5.425, 7.75, "None", 7.75);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 121, 1960, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1301, "FINE", 0, NULL, 15.399999999999999, 22.00, "None", 22.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (64, 139, 1960, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1302, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 4, 1996, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1303, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 4, 1996, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1304, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 4, 1996, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1305, "FINE", 0, NULL, 11.549999999999999, 16.50, "None", 16.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 4, 1996, 8.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1306, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 4, 1996, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1307, "NEAR MINT", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 43, 1996, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1308, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 43, 1996, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1309, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 43, 1996, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1310, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 43, 1996, 8.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1311, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 43, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1312, "NEAR MINT", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 24, 1996, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1313, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 24, 1996, 6.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1314, "FINE", 0, NULL, 9.1, 13.00, "None", 13.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 24, 1996, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1315, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 24, 1996, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1316, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 76, 1996, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1317, "FAIR", 0, NULL, 2.4499999999999997, 3.50, "None", 3.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 76, 1996, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1318, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 76, 1996, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1319, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 76, 1996, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1320, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 76, 1996, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1321, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 76, 1996, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1322, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 100, 1996, 4.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1323, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 100, 1996, 6.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1324, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 100, 1996, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1325, "VERY FINE", 0, NULL, 13.299999999999999, 19.00, "None", 19.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 100, 1996, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1326, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 1.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1327, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 4.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1328, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1329, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 8.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1330, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1331, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1332, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 4.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1333, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1334, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 7.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1335, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1336, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 2.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1337, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 4.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1338, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1339, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1340, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1341, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 1.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1342, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1343, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 5.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1344, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 8.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1345, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 71, 1996, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1346, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 46, 1996, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1347, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 46, 1996, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1348, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 46, 1996, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1349, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 46, 1996, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1350, "VERY FINE", 0, NULL, 18.2, 26.00, "None", 26.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 46, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1351, "NEAR MINT", 0, NULL, 24.5, 35.00, "None", 35.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 3, 1996, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1352, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 3, 1996, 5.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1353, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 3, 1996, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1354, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 3, 1996, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1355, "NEAR MINT", 0, NULL, 23.799999999999997, 34.00, "None", 34.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 11, 1996, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1356, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 11, 1996, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1357, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 11, 1996, 6.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1358, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 11, 1996, 7.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1359, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 11, 1996, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1360, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 74, 1996, 2.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1361, "GOOD", 0, NULL, 4.8999999999999995, 7.00, "None", 7.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 74, 1996, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1362, "VERY GOOD", 0, NULL, 7.35, 10.50, "None", 10.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 74, 1996, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1363, "FINE", 0, NULL, 12.25, 17.50, "None", 17.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 74, 1996, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1364, "VERY FINE", 0, NULL, 18.9, 27.00, "None", 27.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 74, 1996, 9.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1365, "NEAR MINT", 0, NULL, 23.099999999999998, 33.00, "None", 33.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 57, 1996, 3.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1366, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 57, 1996, 5.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1367, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 57, 1996, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1368, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 57, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1369, "NEAR MINT", 0, NULL, 16.799999999999997, 24.00, "None", 24.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 16, 1996, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1370, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 16, 1996, 3.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1371, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 16, 1996, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1372, "FINE", 0, NULL, 8.399999999999999, 12.00, "None", 12.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 16, 1996, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1373, "VERY FINE", 0, NULL, 12.075, 17.25, "None", 17.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 16, 1996, 9.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1374, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1375, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1376, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1377, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1378, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1379, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1380, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 7.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1381, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1382, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1383, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1384, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 7.9);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1385, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1386, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1387, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 6.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1388, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 8.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1389, "VERY FINE", 0, NULL, 14.0, 20.00, "None", 20.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (65, 112, 1996, 9.3);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1390, "NEAR MINT", 0, NULL, 16.099999999999998, 23.00, "None", 23.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (66, 1, 1001, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1391, "FAIR", 0, NULL, 25.9, 37.00, "None", 37.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (66, 1, 1001, 2.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1392, "GOOD", 0, NULL, 39.199999999999996, 56.00, "None", 56.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (66, 1, 1001, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1393, "VERY GOOD", 0, NULL, 61.599999999999994, 88.00, "None", 88.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (66, 1, 1001, 6.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1394, "FINE", 0, NULL, 76.3, 109.00, "None", 109.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (66, 1, 1001, 9.7);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1395, "NEAR MINT", 0, NULL, 87.5, 125.00, "None", 125.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (67, 1, 1963, 1.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1396, "FAIR", 0, NULL, 2.0999999999999996, 3.00, "None", 3.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (67, 1, 1963, 2.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1397, "GOOD", 0, NULL, 2.8, 4.00, "None", 4.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (67, 1, 1963, 3.8);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1398, "VERY GOOD", 0, NULL, 3.5, 5.00, "None", 5.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (67, 1, 1963, 5.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1399, "FINE", 0, NULL, 5.25, 7.50, "None", 7.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (67, 1, 1963, 8.1);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1400, "VERY FINE", 0, NULL, 8.049999999999999, 11.50, "None", 11.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (67, 1, 1963, 9.4);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1401, "NEAR MINT", 0, NULL, 10.5, 15.00, "None", 15.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (68, 1, 1996, 2.0);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1402, "GOOD", 0, NULL, 3.675, 5.25, "None", 5.25);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (68, 1, 1996, 4.2);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1403, "VERY GOOD", 0, NULL, 5.6, 8.00, "None", 8.00);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (68, 1, 1996, 5.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1404, "FINE", 0, NULL, 9.45, 13.50, "None", 13.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (68, 1, 1996, 7.5);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1405, "VERY FINE", 0, NULL, 11.549999999999999, 16.50, "None", 16.50);
INSERT INTO comic_book (title_id, issue, year, grade) VALUES (68, 1, 1996, 9.6);
INSERT INTO comic_book_price (comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1406, "NEAR MINT", 0, NULL, 14.0, 20.00, "None", 20.00);
# TABLE graphic_novel and graphic_novel_price
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (69, 1, 2005, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (1, "FAIR", 0, NULL, 588.6999999999999, 841, "None", 841);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (69, 1, 2005, 2.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (2, "GOOD", 0, NULL, 456.4, 652, "None", 652);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (69, 1, 2005, 4.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (3, "VERY GOOD", 0, NULL, 336.7, 481, "None", 481);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (69, 1, 2005, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (4, "NEAR MINT", 0, NULL, 149.1, 213, "None", 213);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (70, 1, 2005, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (5, "FAIR", 0, NULL, 646.8, 924, "None", 924);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (70, 1, 2005, 1.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (6, "GOOD", 0, NULL, 415.79999999999995, 594, "None", 594);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (70, 1, 2005, 3.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (7, "VERY GOOD", 0, NULL, 318.5, 455, "None", 455);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (70, 1, 2005, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (8, "NEAR MINT", 0, NULL, 125.3, 179, "None", 179);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (71, 1, 2002, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (9, "FAIR", 0, NULL, 589.4, 842, "None", 842);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (71, 1, 2002, 2.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (10, "GOOD", 0, NULL, 418.59999999999997, 598, "None", 598);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (71, 1, 2002, 3.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (11, "VERY GOOD", 0, NULL, 317.09999999999997, 453, "None", 453);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (71, 1, 2002, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (12, "NEAR MINT", 0, NULL, 120.39999999999999, 172, "None", 172);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (13, "FAIR", 0, NULL, 680.4, 972, "None", 972);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (14, "GOOD", 0, NULL, 380.09999999999997, 543, "None", 543);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 4.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (15, "VERY GOOD", 0, NULL, 333.2, 476, "None", 476);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (16, "NEAR MINT", 0, NULL, 206.5, 295, "None", 295);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (17, "FAIR", 0, NULL, 680.4, 972, "None", 972);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 2.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (18, "GOOD", 0, NULL, 380.09999999999997, 543, "None", 543);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 3.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (19, "VERY GOOD", 0, NULL, 333.2, 476, "None", 476);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (20, "NEAR MINT", 0, NULL, 206.5, 295, "None", 295);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (21, "FAIR", 0, NULL, 680.4, 972, "None", 972);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 1.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (22, "GOOD", 0, NULL, 380.09999999999997, 543, "None", 543);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 4.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (23, "VERY GOOD", 0, NULL, 333.2, 476, "None", 476);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (72, 1, 1999, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (24, "NEAR MINT", 0, NULL, 206.5, 295, "None", 295);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (73, 1, 1991, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (25, "FAIR", 0, NULL, 655.1999999999999, 936, "None", 936);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (73, 1, 1991, 2.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (26, "GOOD", 0, NULL, 367.5, 525, "None", 525);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (73, 1, 1991, 4.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (27, "VERY GOOD", 0, NULL, 323.4, 462, "None", 462);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (73, 1, 1991, 9.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (28, "NEAR MINT", 0, NULL, 172.89999999999998, 247, "None", 247);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (74, 1, 2006, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (29, "FAIR", 0, NULL, 669.9, 957, "None", 957);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (74, 1, 2006, 2.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (30, "GOOD", 0, NULL, 428.4, 612, "None", 612);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (74, 1, 2006, 3.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (31, "VERY GOOD", 0, NULL, 340.9, 487, "None", 487);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (74, 1, 2006, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (32, "NEAR MINT", 0, NULL, 143.5, 205, "None", 205);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (75, 1, 1987, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (33, "FAIR", 0, NULL, 555.0999999999999, 793, "None", 793);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (75, 1, 1987, 1.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (34, "GOOD", 0, NULL, 378.0, 540, "None", 540);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (75, 1, 1987, 3.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (35, "VERY GOOD", 0, NULL, 290.5, 415, "None", 415);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (75, 1, 1987, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (36, "NEAR MINT", 0, NULL, 91.69999999999999, 131, "None", 131);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (37, "FAIR", 0, NULL, 627.9, 897, "None", 897);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 1.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (38, "GOOD", 0, NULL, 387.79999999999995, 554, "None", 554);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 3.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (39, "VERY GOOD", 0, NULL, 306.59999999999997, 438, "None", 438);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (40, "NEAR MINT", 0, NULL, 177.1, 253, "None", 253);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (41, "FAIR", 0, NULL, 627.9, 897, "None", 897);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 2.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (42, "GOOD", 0, NULL, 387.79999999999995, 554, "None", 554);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 4.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (43, "VERY GOOD", 0, NULL, 306.59999999999997, 438, "None", 438);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (44, "NEAR MINT", 0, NULL, 177.1, 253, "None", 253);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (45, "FAIR", 0, NULL, 627.9, 897, "None", 897);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 1.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (46, "GOOD", 0, NULL, 387.79999999999995, 554, "None", 554);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 4.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (47, "VERY GOOD", 0, NULL, 306.59999999999997, 438, "None", 438);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (48, "NEAR MINT", 0, NULL, 177.1, 253, "None", 253);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (49, "FAIR", 0, NULL, 627.9, 897, "None", 897);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 1.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (50, "GOOD", 0, NULL, 387.79999999999995, 554, "None", 554);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 3.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (51, "VERY GOOD", 0, NULL, 306.59999999999997, 438, "None", 438);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (76, 1, 1979, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (52, "NEAR MINT", 0, NULL, 177.1, 253, "None", 253);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (77, 1, 1963, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (53, "FAIR", 0, NULL, 511.7, 731, "None", 731);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (77, 1, 1963, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (54, "GOOD", 0, NULL, 407.4, 582, "None", 582);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (77, 1, 1963, 3.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (55, "VERY GOOD", 0, NULL, 347.9, 497, "None", 497);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (77, 1, 1963, 9.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (56, "NEAR MINT", 0, NULL, 191.79999999999998, 274, "None", 274);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (78, 1, 1998, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (57, "FAIR", 0, NULL, 632.0999999999999, 903, "None", 903);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (78, 1, 1998, 2.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (58, "GOOD", 0, NULL, 479.49999999999994, 685, "None", 685);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (78, 1, 1998, 4.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (59, "VERY GOOD", 0, NULL, 290.5, 415, "None", 415);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (78, 1, 1998, 9.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (60, "NEAR MINT", 0, NULL, 81.19999999999999, 116, "None", 116);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (61, "FAIR", 0, NULL, 627.9, 897, "None", 897);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 2.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (62, "GOOD", 0, NULL, 366.09999999999997, 523, "None", 523);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 4.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (63, "VERY GOOD", 0, NULL, 340.2, 486, "None", 486);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (64, "NEAR MINT", 0, NULL, 138.6, 198, "None", 198);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (65, "FAIR", 0, NULL, 627.9, 897, "None", 897);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (66, "GOOD", 0, NULL, 366.09999999999997, 523, "None", 523);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 4.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (67, "VERY GOOD", 0, NULL, 340.2, 486, "None", 486);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (68, "NEAR MINT", 0, NULL, 138.6, 198, "None", 198);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (69, "FAIR", 0, NULL, 627.9, 897, "None", 897);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 2.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (70, "GOOD", 0, NULL, 366.09999999999997, 523, "None", 523);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 4.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (71, "VERY GOOD", 0, NULL, 340.2, 486, "None", 486);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (72, "NEAR MINT", 0, NULL, 138.6, 198, "None", 198);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (73, "FAIR", 0, NULL, 627.9, 897, "None", 897);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 1.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (74, "GOOD", 0, NULL, 366.09999999999997, 523, "None", 523);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 3.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (75, "VERY GOOD", 0, NULL, 340.2, 486, "None", 486);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (79, 1, 2005, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (76, "NEAR MINT", 0, NULL, 138.6, 198, "None", 198);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (80, 1, 2010, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (77, "FAIR", 0, NULL, 665.0, 950, "None", 950);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (80, 1, 2010, 2.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (78, "GOOD", 0, NULL, 476.7, 681, "None", 681);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (80, 1, 2010, 3.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (79, "VERY GOOD", 0, NULL, 304.5, 435, "None", 435);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (80, 1, 2010, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (80, "NEAR MINT", 0, NULL, 166.6, 238, "None", 238);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (81, "FAIR", 0, NULL, 504.7, 721, "None", 721);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 1.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (82, "GOOD", 0, NULL, 450.09999999999997, 643, "None", 643);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 4.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (83, "VERY GOOD", 0, NULL, 280.7, 401, "None", 401);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (84, "NEAR MINT", 0, NULL, 142.79999999999998, 204, "None", 204);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (85, "FAIR", 0, NULL, 504.7, 721, "None", 721);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 2.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (86, "GOOD", 0, NULL, 450.09999999999997, 643, "None", 643);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 3.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (87, "VERY GOOD", 0, NULL, 280.7, 401, "None", 401);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (88, "NEAR MINT", 0, NULL, 142.79999999999998, 204, "None", 204);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (89, "FAIR", 0, NULL, 504.7, 721, "None", 721);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 2.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (90, "GOOD", 0, NULL, 450.09999999999997, 643, "None", 643);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 4.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (91, "VERY GOOD", 0, NULL, 280.7, 401, "None", 401);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (92, "NEAR MINT", 0, NULL, 142.79999999999998, 204, "None", 204);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (93, "FAIR", 0, NULL, 504.7, 721, "None", 721);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 2.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (94, "GOOD", 0, NULL, 450.09999999999997, 643, "None", 643);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 4.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (95, "VERY GOOD", 0, NULL, 280.7, 401, "None", 401);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (81, 1, 2008, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (96, "NEAR MINT", 0, NULL, 142.79999999999998, 204, "None", 204);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (82, 1, 1985, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (97, "FAIR", 0, NULL, 654.5, 935, "None", 935);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (82, 1, 1985, 2.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (98, "GOOD", 0, NULL, 408.79999999999995, 584, "None", 584);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (82, 1, 1985, 3.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (99, "VERY GOOD", 0, NULL, 298.2, 426, "None", 426);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (82, 1, 1985, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (100, "NEAR MINT", 0, NULL, 195.29999999999998, 279, "None", 279);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (83, 1, 1990, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (101, "FAIR", 0, NULL, 558.5999999999999, 798, "None", 798);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (83, 1, 1990, 1.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (102, "GOOD", 0, NULL, 434.0, 620, "None", 620);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (83, 1, 1990, 3.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (103, "VERY GOOD", 0, NULL, 316.4, 452, "None", 452);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (83, 1, 1990, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (104, "NEAR MINT", 0, NULL, 109.19999999999999, 156, "None", 156);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (84, 1, 2006, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (105, "FAIR", 0, NULL, 529.1999999999999, 756, "None", 756);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (84, 1, 2006, 2.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (106, "GOOD", 0, NULL, 366.09999999999997, 523, "None", 523);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (84, 1, 2006, 3.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (107, "VERY GOOD", 0, NULL, 308.7, 441, "None", 441);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (84, 1, 2006, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (108, "NEAR MINT", 0, NULL, 101.5, 145, "None", 145);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (85, 1, 2002, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (109, "FAIR", 0, NULL, 663.5999999999999, 948, "None", 948);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (85, 1, 2002, 2.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (110, "GOOD", 0, NULL, 457.79999999999995, 654, "None", 654);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (85, 1, 2002, 3.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (111, "VERY GOOD", 0, NULL, 291.2, 416, "None", 416);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (85, 1, 2002, 9.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (112, "NEAR MINT", 0, NULL, 128.1, 183, "None", 183);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (86, 1, 2018, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (113, "FAIR", 0, NULL, 613.9, 877, "None", 877);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (86, 1, 2018, 2.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (114, "GOOD", 0, NULL, 480.2, 686, "None", 686);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (86, 1, 2018, 3.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (115, "VERY GOOD", 0, NULL, 296.09999999999997, 423, "None", 423);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (86, 1, 2018, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (116, "NEAR MINT", 0, NULL, 88.89999999999999, 127, "None", 127);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (87, 1, 2003, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (117, "FAIR", 0, NULL, 683.9, 977, "None", 977);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (87, 1, 2003, 1.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (118, "GOOD", 0, NULL, 414.4, 592, "None", 592);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (87, 1, 2003, 4.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (119, "VERY GOOD", 0, NULL, 326.9, 467, "None", 467);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (87, 1, 2003, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (120, "NEAR MINT", 0, NULL, 123.89999999999999, 177, "None", 177);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (88, 1, 1992, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (121, "FAIR", 0, NULL, 516.6, 738, "None", 738);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (88, 1, 1992, 2.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (122, "GOOD", 0, NULL, 408.79999999999995, 584, "None", 584);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (88, 1, 1992, 4.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (123, "VERY GOOD", 0, NULL, 302.4, 432, "None", 432);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (88, 1, 1992, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (124, "NEAR MINT", 0, NULL, 124.6, 178, "None", 178);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (89, 4, 2010, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (125, "FAIR", 0, NULL, 551.5999999999999, 788, "None", 788);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (89, 4, 2010, 2.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (126, "GOOD", 0, NULL, 396.9, 567, "None", 567);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (89, 4, 2010, 4.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (127, "VERY GOOD", 0, NULL, 308.7, 441, "None", 441);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (89, 4, 2010, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (128, "NEAR MINT", 0, NULL, 191.79999999999998, 274, "None", 274);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (90, 2, 2002, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (129, "FAIR", 0, NULL, 660.8, 944, "None", 944);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (90, 2, 2002, 1.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (130, "GOOD", 0, NULL, 440.29999999999995, 629, "None", 629);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (90, 2, 2002, 3.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (131, "VERY GOOD", 0, NULL, 285.59999999999997, 408, "None", 408);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (90, 2, 2002, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (132, "NEAR MINT", 0, NULL, 136.5, 195, "None", 195);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (91, 3, 2007, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (133, "FAIR", 0, NULL, 639.8, 914, "None", 914);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (91, 3, 2007, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (134, "GOOD", 0, NULL, 403.9, 577, "None", 577);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (91, 3, 2007, 4.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (135, "VERY GOOD", 0, NULL, 326.2, 466, "None", 466);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (91, 3, 2007, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (136, "NEAR MINT", 0, NULL, 109.89999999999999, 157, "None", 157);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (137, "FAIR", 0, NULL, 585.1999999999999, 836, "None", 836);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 2.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (138, "GOOD", 0, NULL, 367.5, 525, "None", 525);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 4.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (139, "VERY GOOD", 0, NULL, 312.9, 447, "None", 447);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (140, "NEAR MINT", 0, NULL, 134.39999999999998, 192, "None", 192);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (141, "FAIR", 0, NULL, 585.1999999999999, 836, "None", 836);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 2.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (142, "GOOD", 0, NULL, 367.5, 525, "None", 525);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 4.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (143, "VERY GOOD", 0, NULL, 312.9, 447, "None", 447);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (144, "NEAR MINT", 0, NULL, 134.39999999999998, 192, "None", 192);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (145, "FAIR", 0, NULL, 585.1999999999999, 836, "None", 836);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (146, "GOOD", 0, NULL, 367.5, 525, "None", 525);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 4.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (147, "VERY GOOD", 0, NULL, 312.9, 447, "None", 447);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (148, "NEAR MINT", 0, NULL, 134.39999999999998, 192, "None", 192);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (149, "FAIR", 0, NULL, 585.1999999999999, 836, "None", 836);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 2.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (150, "GOOD", 0, NULL, 367.5, 525, "None", 525);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 4.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (151, "VERY GOOD", 0, NULL, 312.9, 447, "None", 447);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (92, 1, 2019, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (152, "NEAR MINT", 0, NULL, 134.39999999999998, 192, "None", 192);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (93, 6, 1987, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (153, "FAIR", 0, NULL, 601.3, 859, "None", 859);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (93, 6, 1987, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (154, "GOOD", 0, NULL, 452.2, 646, "None", 646);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (93, 6, 1987, 4.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (155, "VERY GOOD", 0, NULL, 287.7, 411, "None", 411);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (93, 6, 1987, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (156, "NEAR MINT", 0, NULL, 156.79999999999998, 224, "None", 224);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (94, 2, 2013, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (157, "FAIR", 0, NULL, 496.29999999999995, 709, "None", 709);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (94, 2, 2013, 1.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (158, "GOOD", 0, NULL, 417.2, 596, "None", 596);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (94, 2, 2013, 4.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (159, "VERY GOOD", 0, NULL, 298.9, 427, "None", 427);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (94, 2, 2013, 9.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (160, "NEAR MINT", 0, NULL, 171.5, 245, "None", 245);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (95, 4, 2011, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (161, "FAIR", 0, NULL, 679.6999999999999, 971, "None", 971);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (95, 4, 2011, 2.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (162, "GOOD", 0, NULL, 463.4, 662, "None", 662);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (95, 4, 2011, 3.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (163, "VERY GOOD", 0, NULL, 312.9, 447, "None", 447);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (95, 4, 2011, 9.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (164, "NEAR MINT", 0, NULL, 137.2, 196, "None", 196);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (96, 1, 2008, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (165, "FAIR", 0, NULL, 510.29999999999995, 729, "None", 729);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (96, 1, 2008, 2.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (166, "GOOD", 0, NULL, 388.5, 555, "None", 555);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (96, 1, 2008, 3.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (167, "VERY GOOD", 0, NULL, 337.4, 482, "None", 482);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (96, 1, 2008, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (168, "NEAR MINT", 0, NULL, 153.29999999999998, 219, "None", 219);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (97, 2, 2013, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (169, "FAIR", 0, NULL, 632.0999999999999, 903, "None", 903);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (97, 2, 2013, 2.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (170, "GOOD", 0, NULL, 460.59999999999997, 658, "None", 658);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (97, 2, 2013, 4.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (171, "VERY GOOD", 0, NULL, 339.5, 485, "None", 485);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (97, 2, 2013, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (172, "NEAR MINT", 0, NULL, 147.0, 210, "None", 210);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (98, 1, 2016, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (173, "FAIR", 0, NULL, 543.9, 777, "None", 777);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (98, 1, 2016, 2.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (174, "GOOD", 0, NULL, 379.4, 542, "None", 542);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (98, 1, 2016, 4.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (175, "VERY GOOD", 0, NULL, 337.4, 482, "None", 482);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (98, 1, 2016, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (176, "NEAR MINT", 0, NULL, 151.89999999999998, 217, "None", 217);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (99, 1, 2017, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (177, "FAIR", 0, NULL, 541.8, 774, "None", 774);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (99, 1, 2017, 2.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (178, "GOOD", 0, NULL, 378.0, 540, "None", 540);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (99, 1, 2017, 4.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (179, "VERY GOOD", 0, NULL, 302.4, 432, "None", 432);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (99, 1, 2017, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (180, "NEAR MINT", 0, NULL, 91.69999999999999, 131, "None", 131);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (100, 3, 2012, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (181, "FAIR", 0, NULL, 595.6999999999999, 851, "None", 851);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (100, 3, 2012, 2.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (182, "GOOD", 0, NULL, 369.59999999999997, 528, "None", 528);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (100, 3, 2012, 4.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (183, "VERY GOOD", 0, NULL, 297.5, 425, "None", 425);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (100, 3, 2012, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (184, "NEAR MINT", 0, NULL, 121.8, 174, "None", 174);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (101, 5, 1975, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (185, "FAIR", 0, NULL, 611.0999999999999, 873, "None", 873);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (101, 5, 1975, 2.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (186, "GOOD", 0, NULL, 457.79999999999995, 654, "None", 654);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (101, 5, 1975, 3.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (187, "VERY GOOD", 0, NULL, 284.9, 407, "None", 407);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (101, 5, 1975, 9.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (188, "NEAR MINT", 0, NULL, 103.6, 148, "None", 148);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (189, "FAIR", 0, NULL, 494.9, 707, "None", 707);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 2.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (190, "GOOD", 0, NULL, 417.2, 596, "None", 596);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 4.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (191, "VERY GOOD", 0, NULL, 302.4, 432, "None", 432);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (192, "NEAR MINT", 0, NULL, 151.2, 216, "None", 216);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (193, "FAIR", 0, NULL, 494.9, 707, "None", 707);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (194, "GOOD", 0, NULL, 417.2, 596, "None", 596);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 3.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (195, "VERY GOOD", 0, NULL, 302.4, 432, "None", 432);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (196, "NEAR MINT", 0, NULL, 151.2, 216, "None", 216);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (197, "FAIR", 0, NULL, 494.9, 707, "None", 707);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (198, "GOOD", 0, NULL, 417.2, 596, "None", 596);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 3.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (199, "VERY GOOD", 0, NULL, 302.4, 432, "None", 432);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (200, "NEAR MINT", 0, NULL, 151.2, 216, "None", 216);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (201, "FAIR", 0, NULL, 494.9, 707, "None", 707);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 1.9);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (202, "GOOD", 0, NULL, 417.2, 596, "None", 596);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 3.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (203, "VERY GOOD", 0, NULL, 302.4, 432, "None", 432);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (102, 8, 1981, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (204, "NEAR MINT", 0, NULL, 151.2, 216, "None", 216);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (103, 3, 1982, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (205, "FAIR", 0, NULL, 550.1999999999999, 786, "None", 786);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (103, 3, 1982, 1.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (206, "GOOD", 0, NULL, 399.7, 571, "None", 571);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (103, 3, 1982, 4.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (207, "VERY GOOD", 0, NULL, 340.2, 486, "None", 486);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (103, 3, 1982, 9.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (208, "NEAR MINT", 0, NULL, 161.7, 231, "None", 231);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (104, 2, 2008, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (209, "FAIR", 0, NULL, 557.1999999999999, 796, "None", 796);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (104, 2, 2008, 2.1);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (210, "GOOD", 0, NULL, 357.7, 511, "None", 511);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (104, 2, 2008, 3.8);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (211, "VERY GOOD", 0, NULL, 306.59999999999997, 438, "None", 438);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (104, 2, 2008, 9.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (212, "NEAR MINT", 0, NULL, 96.6, 138, "None", 138);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (105, 1, 2018, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (213, "FAIR", 0, NULL, 584.5, 835, "None", 835);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (105, 1, 2018, 2.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (214, "GOOD", 0, NULL, 457.79999999999995, 654, "None", 654);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (105, 1, 2018, 3.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (215, "VERY GOOD", 0, NULL, 294.0, 420, "None", 420);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (105, 1, 2018, 9.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (216, "NEAR MINT", 0, NULL, 86.1, 123, "None", 123);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (106, 4, 2005, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (217, "FAIR", 0, NULL, 635.5999999999999, 908, "None", 908);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (106, 4, 2005, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (218, "GOOD", 0, NULL, 427.7, 611, "None", 611);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (106, 4, 2005, 3.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (219, "VERY GOOD", 0, NULL, 304.5, 435, "None", 435);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (106, 4, 2005, 9.7);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (220, "NEAR MINT", 0, NULL, 139.29999999999998, 199, "None", 199);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (107, 3, 2005, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (221, "FAIR", 0, NULL, 528.5, 755, "None", 755);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (107, 3, 2005, 2.3);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (222, "GOOD", 0, NULL, 405.29999999999995, 579, "None", 579);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (107, 3, 2005, 3.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (223, "VERY GOOD", 0, NULL, 319.9, 457, "None", 457);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (107, 3, 2005, 9.4);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (224, "NEAR MINT", 0, NULL, 198.1, 283, "None", 283);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (108, 6, 1994, 1.0);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (225, "FAIR", 0, NULL, 495.59999999999997, 708, "None", 708);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (108, 6, 1994, 2.5);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (226, "GOOD", 0, NULL, 378.0, 540, "None", 540);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (108, 6, 1994, 4.2);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (227, "VERY GOOD", 0, NULL, 347.9, 497, "None", 497);
INSERT INTO graphic_novel (title_id, edition, year, grade) VALUES (108, 6, 1994, 9.6);
INSERT INTO graphic_novel_price (graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price) VALUES (228, "NEAR MINT", 0, NULL, 154.0, 220, "None", 220);
# TABLE character_info
INSERT INTO character_info (character_name) VALUES ("Alfred Thaddeus Crane Pennyworth");
INSERT INTO character_info (character_name) VALUES ("Aquaman");
INSERT INTO character_info (character_name) VALUES ("Arno Stark");
INSERT INTO character_info (character_name) VALUES ("Avengers");
INSERT INTO character_info (character_name) VALUES ("Barry Allen");
INSERT INTO character_info (character_name) VALUES ("Bart Allen");
INSERT INTO character_info (character_name) VALUES ("Batman");
INSERT INTO character_info (character_name) VALUES ("Beast");
INSERT INTO character_info (character_name) VALUES ("Blade");
INSERT INTO character_info (character_name) VALUES ("Captain America");
INSERT INTO character_info (character_name) VALUES ("Captain Marvel");
INSERT INTO character_info (character_name) VALUES ("Catwoman");
INSERT INTO character_info (character_name) VALUES ("Cyclops");
INSERT INTO character_info (character_name) VALUES ("Defenders");
INSERT INTO character_info (character_name) VALUES ("Doctor Strange");
INSERT INTO character_info (character_name) VALUES ("Earth Goddess Gaea");
INSERT INTO character_info (character_name) VALUES ("Echo/Phoenix");
INSERT INTO character_info (character_name) VALUES ("Edwin Jarvis");
INSERT INTO character_info (character_name) VALUES ("Ghost Rider");
INSERT INTO character_info (character_name) VALUES ("Giant-Man");
INSERT INTO character_info (character_name) VALUES ("Green Arrow");
INSERT INTO character_info (character_name) VALUES ("Green Lantern");
INSERT INTO character_info (character_name) VALUES ("Green LanternAlan Scott");
INSERT INTO character_info (character_name) VALUES ("Guy Gardner");
INSERT INTO character_info (character_name) VALUES ("Hal Jordan");
INSERT INTO character_info (character_name) VALUES ("Harley Quinn");
INSERT INTO character_info (character_name) VALUES ("Hawkman");
INSERT INTO character_info (character_name) VALUES ("Howard Stark");
INSERT INTO character_info (character_name) VALUES ("Human Torch");
INSERT INTO character_info (character_name) VALUES ("Huntress");
INSERT INTO character_info (character_name) VALUES ("Iceman");
INSERT INTO character_info (character_name) VALUES ("Invisible Woman");
INSERT INTO character_info (character_name) VALUES ("Iron Man");
INSERT INTO character_info (character_name) VALUES ("Iron ManAmanda Armstrong");
INSERT INTO character_info (character_name) VALUES ("Jason Peter Todd");
INSERT INTO character_info (character_name) VALUES ("Jean-Paul Valley Jr.");
INSERT INTO character_info (character_name) VALUES ("Jessica Cruz");
INSERT INTO character_info (character_name) VALUES ("Jimmy Olsen");
INSERT INTO character_info (character_name) VALUES ("John Stewart");
INSERT INTO character_info (character_name) VALUES ("Julia Pennyworth");
INSERT INTO character_info (character_name) VALUES ("King Namor");
INSERT INTO character_info (character_name) VALUES ("King of the Asgardians");
INSERT INTO character_info (character_name) VALUES ("Kyle Rayner");
INSERT INTO character_info (character_name) VALUES ("Lex Luthor");
INSERT INTO character_info (character_name) VALUES ("Lois Lane");
INSERT INTO character_info (character_name) VALUES ("Maria Stark");
INSERT INTO character_info (character_name) VALUES ("Marvel Knights");
INSERT INTO character_info (character_name) VALUES ("Mephisto");
INSERT INTO character_info (character_name) VALUES ("Mister Fantastic");
INSERT INTO character_info (character_name) VALUES ("Morgan Stark");
INSERT INTO character_info (character_name) VALUES ("Nighthawk (Simulacrum)");
INSERT INTO character_info (character_name) VALUES ("Odin Borson");
INSERT INTO character_info (character_name) VALUES ("Quicksilver");
INSERT INTO character_info (character_name) VALUES ("Simon Baz");
INSERT INTO character_info (character_name) VALUES ("Sojourner Mullein");
INSERT INTO character_info (character_name) VALUES ("Starbrand (Selby)");
INSERT INTO character_info (character_name) VALUES ("Stephanie Brown ");
INSERT INTO character_info (character_name) VALUES ("Superman");
INSERT INTO character_info (character_name) VALUES ("The Chaste");
INSERT INTO character_info (character_name) VALUES ("The Flash");
INSERT INTO character_info (character_name) VALUES ("The FlashJay Garrick");
INSERT INTO character_info (character_name) VALUES ("The Hand");
INSERT INTO character_info (character_name) VALUES ("The Thing");
INSERT INTO character_info (character_name) VALUES ("Thor");
INSERT INTO character_info (character_name) VALUES ("Tigra");
INSERT INTO character_info (character_name) VALUES ("Valkyrie");
INSERT INTO character_info (character_name) VALUES ("Wally West");
INSERT INTO character_info (character_name) VALUES ("Wonder Woman");
INSERT INTO character_info (character_name) VALUES ("X-MenProfessor X");
# first_appearance
INSERT INTO first_appearance (character_id, title, issue) VALUES (4, "The Avengers", 1);
INSERT INTO first_appearance (character_id, title, issue) VALUES (10, "Captain America Comics", 1);
INSERT INTO first_appearance (character_id, title, issue) VALUES (33, "Tales of Suspense", 39);
INSERT INTO first_appearance (character_id, title, issue) VALUES (7, "Detective Comics", 27);
INSERT INTO first_appearance (character_id, title, issue) VALUES (60, "Flash Comics", 1);
INSERT INTO first_appearance (character_id, title, issue) VALUES (58, "Action Comics", 1);
INSERT INTO first_appearance (character_id, title, issue) VALUES (69, "X-Men", 1);
INSERT INTO first_appearance (character_id, title, issue) VALUES (26, "The Batman Adventures", 12);
INSERT INTO first_appearance (character_id, title, issue) VALUES (27, "Flash Comics", 1);
INSERT INTO first_appearance (character_id, title, issue) VALUES (15, "Strange Tales", 110);
# TABLE relation_comic_book_character
INSERT INTO relation_comic_character (title_id, character_id) VALUES (108, 23);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (108, 25);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (108, 24);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (108, 39);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (108, 43);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (108, 54);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (108, 37);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (108, 55);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (8, 49);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (8, 32);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (8, 29);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (8, 63);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (104, 23);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (104, 25);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (104, 24);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (104, 39);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (104, 43);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (104, 54);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (104, 37);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (104, 55);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (96, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (96, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (96, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (76, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (76, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (76, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (76, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (76, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (76, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (76, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (98, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (98, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (98, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (77, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (77, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (77, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (77, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (77, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (77, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (77, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (5, 4);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (5, 14);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (5, 47);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (5, 59);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (5, 62);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (79, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (82, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (97, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (97, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (97, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (6, 49);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (6, 32);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (6, 29);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (6, 63);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (13, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (13, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (13, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (13, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (13, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (13, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (13, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (78, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (78, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (78, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (78, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (78, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (78, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (78, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 33);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 64);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 11);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 41);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 17);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 9);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 66);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 19);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 56);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 51);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (70, 15);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (75, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (75, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (75, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (75, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (75, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (75, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (75, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (94, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (94, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (94, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (9, 49);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (9, 32);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (9, 29);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (9, 63);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (107, 23);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (107, 25);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (107, 24);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (107, 39);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (107, 43);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (107, 54);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (107, 37);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (107, 55);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (16, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (16, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (16, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (16, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (16, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (16, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (16, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (4, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (95, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (95, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (95, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 33);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 64);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 11);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 41);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 17);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 9);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 66);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 19);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 56);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 51);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (2, 15);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (41, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (41, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (41, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (40, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (40, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (40, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (39, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (39, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (39, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (105, 23);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (105, 25);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (105, 24);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (105, 39);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (105, 43);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (105, 54);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (105, 37);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (105, 55);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (74, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (74, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (74, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (74, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (74, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (74, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (74, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (106, 23);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (106, 25);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (106, 24);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (106, 39);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (106, 43);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (106, 54);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (106, 37);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (106, 55);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (7, 49);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (7, 32);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (7, 29);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (7, 63);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 33);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 64);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 11);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 41);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 17);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 9);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 66);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 19);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 56);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 51);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (69, 15);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (81, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (42, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (42, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (42, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 33);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 64);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 11);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 41);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 17);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 9);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 66);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 19);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 56);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 51);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 15);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 52);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 42);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (3, 16);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (11, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (11, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (11, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (11, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (11, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (11, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (11, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (64, 23);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (64, 25);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (64, 24);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (64, 39);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (64, 43);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (64, 54);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (64, 37);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (64, 55);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (80, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (12, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (12, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (12, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (12, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (12, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (12, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (12, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (18, 69);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (18, 13);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (18, 31);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (18, 8);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 33);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 64);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 11);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 41);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 17);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 9);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 66);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 19);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 56);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 51);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (1, 15);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (10, 49);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (10, 32);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (10, 29);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (10, 63);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 10);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 33);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 64);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 11);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 41);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 17);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 9);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 66);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 19);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 56);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 51);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (72, 15);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (15, 34);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (15, 3);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (15, 18);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (15, 28);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (15, 46);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (15, 50);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (15, 48);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (61, 7);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (61, 1);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (61, 35);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (61, 12);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (61, 40);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (61, 36);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (61, 30);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (61, 26);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (61, 57);
INSERT INTO relation_comic_character (title_id, character_id) VALUES (83, 10);
# TABLE author_info
INSERT INTO author_info (author_name, author_type) VALUES ("Bill Everett", "artist");
INSERT INTO author_info (author_name, author_type) VALUES ("Bill Finger", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Brian Michael Bendis", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Steve Ditko", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Tom King", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Martin Nodell", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("George Klein", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("John Broome", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Gil Kane", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Kenneth Rocafort", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("David Finch", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Ivan Reis", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Klaus Janson", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Jack Kirby", "artist");
INSERT INTO author_info (author_name, author_type) VALUES ("Don Heck", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Cary Bates", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Larry Mahlstedt", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Joe Shuster", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Francis Manapul", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("John Broome", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Joe Simon", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Peter J. Tomasi", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Keith Giffen", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Martin Nodell", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Mike Baron", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Jordie Bellaire", "colourist");
INSERT INTO author_info (author_name, author_type) VALUES ("Norm Rapmund", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Danny Miki", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Doug Mahnke", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Jonathan Glapion", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Larry Lieber", "scripter");
INSERT INTO author_info (author_name, author_type) VALUES ("Bob Oksner", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Jack Kirby", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Jackson Guice", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Bill Finger", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Francis Manapul", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Patrick Gleason", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Geoffrey Thorne", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Joe Giella", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Pat Broderick", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Larry Lieber", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Carmine Infantino", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Stan Lee", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Greg Capullo", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Adrienne Roy", "colourist");
INSERT INTO author_info (author_name, author_type) VALUES ("Joshua Williamson", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Romeo Tanghal", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Gerard Jones", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Stan Lee", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("Carlos Pacheco", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Jesus Merino", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Bob Kane", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Geoff Johns", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Jerry Robinson", "inker");
INSERT INTO author_info (author_name, author_type) VALUES ("Carmine Infantino", "penciller");
INSERT INTO author_info (author_name, author_type) VALUES ("Scott Snyder", "writer");
INSERT INTO author_info (author_name, author_type) VALUES ("Jerry Siegel", "creator");
INSERT INTO author_info (author_name, author_type) VALUES ("FCO Plascencia", "colourist");
INSERT INTO author_info (author_name, author_type) VALUES ("Joe Shuster", "penciller");
INSERT INTO relation_comic_author (title_id, author_id) VALUES (95, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (18, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (77, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 43);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 42);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (12, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 16);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 14);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (39, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (97, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (77, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 45);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (74, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 13);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 37);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 36);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (7, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (77, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 42);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (69, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 11);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 45);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (95, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (6, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 11);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 27);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (75, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 33);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (76, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 47);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 46);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (6, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (79, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 41);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 33);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 11);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (81, 3);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 46);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 27);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (78, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (13, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (74, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (83, 3);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (42, 10);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 38);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 36);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 46);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 37);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (15, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (3, 3);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 33);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 27);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (78, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (74, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (42, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (75, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 38);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 38);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 15);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 41);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (9, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (11, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 44);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (79, 3);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (12, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 40);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 39);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 25);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (82, 3);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 27);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (15, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (80, 3);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (3, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (16, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (98, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (16, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 40);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 44);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 33);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (39, 10);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 37);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 27);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 39);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (3, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 19);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (96, 10);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (41, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (77, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (11, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 40);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (13, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (83, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (81, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 38);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (69, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 39);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (40, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (8, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (1, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (15, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 12);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (98, 10);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (15, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 25);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (41, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (2, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 43);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (18, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 43);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (39, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 45);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (76, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 44);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 47);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 38);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (78, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (80, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 44);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (12, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (5, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 37);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 42);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (94, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (40, 10);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 40);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (1, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 21);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 11);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (13, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 43);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 45);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 43);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 25);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 45);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 47);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (76, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (11, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 36);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 43);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 25);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (40, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (72, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 37);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (78, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 40);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (16, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 41);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 39);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (74, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (74, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 46);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 18);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 20);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (16, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (10, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 41);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (94, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (70, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (96, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (13, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (75, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (2, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 36);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 25);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (70, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 41);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 22);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (13, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (75, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (95, 10);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (8, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (16, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 33);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (3, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 11);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (12, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (82, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (11, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 46);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (97, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 33);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 42);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (12, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (61, 17);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 40);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (5, 5);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 41);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (7, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (98, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (77, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 25);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 27);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 44);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 47);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (41, 10);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (76, 8);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 39);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (76, 9);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 38);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 47);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (72, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (42, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 36);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (94, 10);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (10, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (75, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 11);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (97, 10);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (4, 4);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (106, 47);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 42);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 11);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (104, 39);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (78, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (15, 6);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (105, 42);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (64, 37);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (11, 7);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (96, 2);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 36);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (107, 45);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (9, 1);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (4, 3);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 46);
INSERT INTO relation_comic_author (title_id, author_id) VALUES (108, 44);

-- Test function
DROP FUNCTION IF EXISTS convert_grade_to_symbol;
DELIMITER //
CREATE FUNCTION convert_grade_to_symbol(p_grade FLOAT(3, 1)) RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE res VARCHAR(20);
    
    SELECT symbol INTO res FROM comic_quality WHERE p_grade BETWEEN min_grade AND max_grade;
    
    RETURN res;
END//
DELIMITER ;
SELECT convert_grade_to_symbol(9.8);

-- Fuzzy query publisher by given publisher name
DROP PROCEDURE IF EXISTS search_publishers;
DELIMITER //
CREATE PROCEDURE search_publishers(IN p_publisher VARCHAR(20))
BEGIN
    SELECT * FROM publisher 
    WHERE 
        (p_publisher IS NULL OR publisher LIKE CONCAT('%', p_publisher, '%'));
END//
DELIMITER ;
CALL search_publishers(NULL);


-- Fuzzy query title by given title and publisher
DROP PROCEDURE IF EXISTS search_titles;
DELIMITER //
CREATE PROCEDURE search_titles(IN p_title VARCHAR(100), IN p_publisher VARCHAR(20))
BEGIN
    SELECT * FROM title 
    WHERE 
        (p_title IS NULL OR title LIKE CONCAT('%', p_title, '%'))
    AND
        (p_publisher IS NULL OR publisher LIKE CONCAT('%', p_publisher, '%'));
END//
DELIMITER ;
CALL search_titles(NULL, "Viz");

-- Search combic books' prices
DROP PROCEDURE IF EXISTS search_comic_books;
DELIMITER //
CREATE PROCEDURE search_comic_books (
    IN `p_title` VARCHAR(100),
    IN `p_issue` INT,
    IN `p_symbol` VARCHAR(20),
    IN `p_signed` TINYINT,
    IN `p_collected_by` VARCHAR(20),
    IN `p_min_price` FLOAT(10, 2),
    IN `p_max_price` FLOAT(10, 2)
)
BEGIN
    SELECT 
        t.title, 
        cb.issue, 
        GROUP_CONCAT(
            DISTINCT CONCAT(
                cbp.symbol, 
                CASE WHEN cbp.signed = 1 THEN ',signed' ELSE '' END,
                CASE WHEN cbp.collected_by is NULL THEN '' ELSE concat(',', "collect_by(", cbp.collected_by, ")") END,
                ': ', 
                cbp.offering_price
                ) ORDER BY cbp.symbol SEPARATOR '; '
            ) as `price`
    FROM comic_book AS cb
    JOIN title AS t 
    ON cb.title_id = t.id
    LEFT JOIN comic_book_price AS cbp
    ON cb.id = cbp.comic_book_id
    WHERE (p_title IS NULL OR t.title LIKE CONCAT('%', p_title, '%'))
    AND (p_issue IS NULL OR cb.issue = p_issue)
    AND (p_symbol IS NULL OR cbp.symbol = p_symbol)
    AND (p_signed IS NULL OR cbp.signed = p_signed)
    AND (p_collected_by IS NULL OR cbp.collected_by LIKE CONCAT('%', p_collected_by, '%'))
    AND (p_min_price IS NULL OR cbp.offering_price >= p_min_price)
    AND (p_max_price IS NULL OR cbp.offering_price <= p_max_price)
    GROUP BY t.title, cb.issue;
END//
DELIMITER ;
call search_comic_books("AVENGERS (1963) (#1-402) (MARVEL)", NULL, "GOOD", NULL, NULL, 10, 300);

-- Search graphic novels' prices
DROP PROCEDURE IF EXISTS search_graphic_novels;
DELIMITER //
CREATE PROCEDURE search_graphic_novels (
    IN `p_title` VARCHAR(100),
    IN `p_edition` INT,
    IN `p_symbol` VARCHAR(20),
    IN `p_signed` TINYINT,
    IN `p_collected_by` VARCHAR(20),
    IN `p_min_price` FLOAT(10, 2),
    IN `p_max_price` FLOAT(10, 2)
)
BEGIN
    SELECT 
        t.title, 
        gn.edition, 
        GROUP_CONCAT(
            DISTINCT CONCAT(
                gnp.symbol, 
                CASE WHEN gnp.signed = 1 THEN ',signed' ELSE '' END,
                CASE WHEN gnp.collected_by is NULL THEN '' ELSE concat(',', "collect_by(", gnp.collected_by, ")") END,
                ': ', 
                gnp.offering_price
                ) ORDER BY gnp.symbol SEPARATOR '; '
            ) as `price`
    FROM graphic_novel AS gn
    JOIN title AS t 
    ON gn.title_id = t.id
    LEFT JOIN graphic_novel_price AS gnp
    ON gn.id = gnp.graphic_novel_id
    WHERE (p_title IS NULL OR t.title LIKE CONCAT('%', p_title, '%'))
    AND (p_edition IS NULL OR gn.edition = p_edition)
    AND (p_symbol IS NULL OR gnp.symbol = p_symbol)
    AND (p_signed IS NULL OR gnp.signed = p_signed)
    AND (p_collected_by IS NULL OR gnp.collected_by LIKE CONCAT('%', p_collected_by, '%'))
    AND (p_min_price IS NULL OR gnp.offering_price >= p_min_price)
    AND (p_max_price IS NULL OR gnp.offering_price <= p_max_price)
    GROUP BY t.title, gn.edition;
END//
DELIMITER ;
call search_graphic_novels("Iron MAN", NULL, NULL, NULL, NULL, NULL, NULL);

-- Generate view for stock of comic_books
DROP PROCEDURE IF EXISTS generate_comic_book_stock;
DELIMITER //
CREATE PROCEDURE generate_comic_book_stock()
BEGIN
    SELECT t.title, cb.issue, cbp.symbol, cbp.signed, cbp.collected_by, cbp.special, COUNT(*) AS stock_count
    FROM  comic_book AS cb
    JOIN comic_book_price cbp 
    ON cb.id = cbp.comic_book_id
    JOIN title as t
    ON t.id = cb.title_id
    WHERE cbp.existed = 1
    GROUP BY cb.title_id, cb.issue, cbp.symbol, cbp.signed, cbp.collected_by, cbp.special;
END//
DELIMITER ;
CALL generate_comic_book_stock;

-- Generate view for stock of graphic_novels
DROP PROCEDURE IF EXISTS generate_graphic_novel_stock;
DELIMITER //
CREATE PROCEDURE generate_graphic_novel_stock()
BEGIN
    SELECT t.title, gn.edition, gnp.symbol, gnp.signed, gnp.collected_by, gnp.special, COUNT(*) AS stock_count
    FROM  graphic_novel AS gn
    JOIN graphic_novel_price AS gnp 
    ON gn.id = gnp.graphic_novel_id
    JOIN title as t
    ON t.id = gn.title_id
    WHERE gnp.existed = 1
    GROUP BY gn.title_id, gn.edition, gnp.symbol, gnp.signed, gnp.collected_by, gnp.special;
END//
DELIMITER ;
CALL generate_graphic_novel_stock;


-- Display all characters
DELIMITER //
CREATE PROCEDURE show_characters()
BEGIN
    SELECT DISTINCT character_name
    FROM character_info;
END //
DELIMITER ;
CALL show_characters;

-- Search title by character_name
DROP PROCEDURE IF EXISTS search_title_by_character;
DELIMITER //
CREATE PROCEDURE search_title_by_character (IN p_character_name VARCHAR(50))
BEGIN
    SELECT t.title, ci.character_name
    FROM relation_comic_character AS rcc
    JOIN title AS t ON rcc.title_id = t.id
    JOIN character_info AS ci ON rcc.character_id = ci.id
    WHERE (p_character_name IS NULL OR ci.character_name LIKE CONCAT('%', p_character_name, '%'));
END //
DELIMITER ;
CALL search_title_by_character("Iron Man");

-- Search first appearance
DROP PROCEDURE IF EXISTS search_first_appearance;
DELIMITER //
CREATE PROCEDURE search_first_appearance(IN p_character_name VARCHAR(50))
BEGIN
    SELECT ci.character_name, fa.title, fa.issue
    FROM character_info AS ci
    JOIN first_appearance AS fa ON ci.id = fa.character_id
    WHERE (p_character_name IS NULL OR ci.character_name LIKE CONCAT('%', p_character_name, '%'));
END//
DELIMITER ;
CALL search_first_appearance("Iron Man");

-- Display all editiors
DROP PROCEDURE IF EXISTS get_author_info;
DELIMITER //
CREATE PROCEDURE get_author_info(IN p_author_name VARCHAR(30), IN p_author_type VARCHAR(20))
BEGIN
    SELECT author_name, author_type
    FROM author_info
    WHERE
        ((p_author_name IS NULL OR author_name LIKE CONCAT('%', p_author_name, '%')))
    AND
        ((p_author_type IS NULL OR author_type LIKE CONCAT('%', p_author_type, '%')));
END//
DELIMITER ;
CALL get_author_info("Stan Lee", NULL);

-- Search title by author_name and author_type
DROP PROCEDURE IF EXISTS search_relation_comic_author;
DELIMITER //
CREATE PROCEDURE search_relation_comic_author(IN p_author_name VARCHAR(30), IN p_author_type VARCHAR(20))
BEGIN
    SELECT ai.author_name, ai.author_type, t.title
    FROM author_info AS ai
    JOIN relation_comic_author AS rca ON ai.id = rca.author_id
    JOIN title AS t ON rca.title_id = t.id
    WHERE 
        (p_author_name IS NULL OR ai.author_name LIKE CONCAT('%', p_author_name, '%'))
    AND 
        (p_author_type IS NULL OR ai.author_type LIKE CONCAT('%', p_author_type, '%'));
END //
DELIMITER ;
CALL search_relation_comic_author("Stan Lee", NULL);

-- Insert a new comic book
DROP PROCEDURE IF EXISTS insert_comic_book;
DELIMITER //
CREATE PROCEDURE insert_comic_book(
    IN p_title VARCHAR(100),
    IN p_publisher VARCHAR(20),
    IN p_issue INT,
    IN p_year INT,
    IN p_grade FLOAT(3,1),
    IN p_signed TINYINT,
    IN p_collected_by VARCHAR(20),
    In p_purchase_price FLOAT(10,2),
    IN p_original_price FLOAT(10,2),
    IN p_special VARCHAR(20),
    IN p_offering_price FLOAT(10,2),
    IN p_characters VARCHAR(200),
    IN p_authors VARCHAR(200)
)
BEGIN
    DECLARE title_id INT;
    DECLARE symbol VARCHAR(20);
    DECLARE character_name VARCHAR(30);
    DECLARE author_pair VARCHAR(50);
    DECLARE author_name VARCHAR(30);
    DECLARE author_type VARCHAR(20);
    DECLARE v_index INT DEFAULT 1;
    DECLARE v_count INT DEFAULT 0;
    DECLARE character_id INT;
    DECLARE author_id INT;
    
    INSERT IGNORE INTO publisher(publisher) VALUES(p_publisher);

    -- insert or retrieve title id
    INSERT IGNORE INTO title(title, publisher) VALUES (p_title, p_publisher) ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
    
    SELECT LAST_INSERT_ID() INTO title_id;
    
    -- insert comic book
    INSERT INTO comic_book(title_id, issue, year, grade)
    VALUES (title_id, p_issue, p_year, p_grade);
    
    -- retrieve symbol from fuccov function
    SET symbol = convert_grade_to_symbol(p_grade);
    
    -- insert comic book price
    INSERT INTO comic_book_price(comic_book_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price)
    VALUES (LAST_INSERT_ID(), symbol, p_signed, p_collected_by, p_purchase_price, p_original_price, p_special, p_offering_price);

    SET v_count = LENGTH(p_characters) - LENGTH(REPLACE(p_characters, ',', '')) + 1;
    WHILE v_index <= v_count DO
        SET character_name = SUBSTRING_INDEX(p_characters, ',', v_index);
        INSERT IGNORE INTO character_info(character_name) VALUES(character_name);
        SELECT LAST_INSERT_ID() INTO character_id;
        INSERT IGNORE INTO relation_comic_character(title_id, character_id) VALUES(title_id, character_id);
        SET v_index = v_index + 1;
    END WHILE;

    SET v_count = LENGTH(p_authors) - LENGTH(REPLACE(p_authors, ',', '')) + 1;
    WHILE v_index <= v_count DO
        SET author_pair = TRIM(SUBSTRING_INDEX(p_authors, ',', v_index));
        SET author_name = TRIM(SUBSTRING_INDEX(author_pair, ':', 1));
        SET author_type = TRIM(SUBSTRING_INDEX(author_pair, ':', -1));

        -- do something with v_name and v_role
        -- for example, insert into a table
        INSERT IGNORE INTO author_info (author_name, author_type) VALUES (author_name, author_type);
        SELECT LAST_INSERT_ID() INTO author_id;
        INSERT IGNORE INTO relation_comic_author(title_id, author_id) VALUES(author_id, title_id);
        SET v_index = v_index + 1;
    END WHILE;
END//
DELIMITER ;
CALL insert_comic_book("Steel Man - SQl King", "Yan Comics", 1, 2023, 9.8, 1, "yan huan", 200, 1000, "None", 200, "Steel Man,Y-MEN", "yanhuan:creator,yanhuan: colourist");


-- Insert a new graphic novel
DROP PROCEDURE IF EXISTS insert_graphic_novel;
DELIMITER //
CREATE PROCEDURE insert_graphic_novel(
    IN p_title VARCHAR(100),
    IN p_publisher VARCHAR(20),
    IN p_edition INT,
    IN p_year INT,
    IN p_grade FLOAT(3,1),
    IN p_signed TINYINT,
    IN p_collected_by VARCHAR(20),
    In p_purchase_price FLOAT(10,2),
    IN p_original_price FLOAT(10,2),
    IN p_special VARCHAR(20),
    IN p_offering_price FLOAT(10,2),
    IN p_characters VARCHAR(200),
    IN p_authors VARCHAR(200)
)
BEGIN
    DECLARE title_id INT;
    DECLARE symbol VARCHAR(20);
    DECLARE character_name VARCHAR(30);
    DECLARE author_pair VARCHAR(50);
    DECLARE author_name VARCHAR(30);
    DECLARE author_type VARCHAR(20);
    DECLARE v_index INT DEFAULT 1;
    DECLARE v_count INT DEFAULT 0;
    DECLARE character_id INT;
    DECLARE author_id INT;
    
    INSERT IGNORE INTO publisher(publisher) VALUES(p_publisher);

    -- insert or retrieve title id
    INSERT IGNORE INTO title(title, publisher) VALUES (p_title, p_publisher) ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);
    
    SELECT LAST_INSERT_ID() INTO title_id;
    
    -- insert comic book
    INSERT INTO graphic_novel(title_id, `edition`, year, grade) VALUES (title_id, p_edition, p_year, p_grade);
    
    -- retrieve symbol from fuccov function
    SET symbol = convert_grade_to_symbol(p_grade);
    
    -- insert comic book price
    INSERT INTO graphic_novel_price(graphic_novel_id, symbol, signed, collected_by, purchase_price, original_price, special, offering_price)
    VALUES (LAST_INSERT_ID(), symbol, p_signed, p_collected_by, p_purchase_price, p_original_price, p_special, p_offering_price);

    SET v_count = LENGTH(p_characters) - LENGTH(REPLACE(p_characters, ',', '')) + 1;
    WHILE v_index <= v_count DO
        SET character_name = SUBSTRING_INDEX(p_characters, ',', v_index);
        INSERT IGNORE INTO character_info(character_name) VALUES(character_name);
        SELECT LAST_INSERT_ID() INTO character_id;
        INSERT IGNORE INTO relation_comic_character(title_id, character_id) VALUES(title_id, character_id);
        SET v_index = v_index + 1;
    END WHILE;

    SET v_count = LENGTH(p_authors) - LENGTH(REPLACE(p_authors, ',', '')) + 1;
    WHILE v_index <= v_count DO
        SET author_pair = TRIM(SUBSTRING_INDEX(p_authors, ',', v_index));
        SET author_name = TRIM(SUBSTRING_INDEX(author_pair, ':', 1));
        SET author_type = TRIM(SUBSTRING_INDEX(author_pair, ':', -1));

        -- do something with v_name and v_role
        -- for example, insert into a table
        INSERT IGNORE INTO author_info (author_name, author_type) VALUES (author_name, author_type);
        SELECT LAST_INSERT_ID() INTO author_id;
        INSERT IGNORE INTO relation_comic_author(title_id, author_id) VALUES(author_id, title_id);
        SET v_index = v_index + 1;
    END WHILE;
    
END//
DELIMITER ;
CALL insert_graphic_novel("test", "Rabbit Comics", 1, 2023, 9.8, 1, "yan huan", 200, 1000, "None", 200, "Steel Man,Y-MEN", "yanhuan:creator,yanhuan: colourist");


-- View for the price of book
DROP VIEW IF EXISTS comic_books_price_view;
CREATE VIEW comic_books_price_view AS (
    SELECT 
        t.title, 
        cb.issue, 
        GROUP_CONCAT(
            DISTINCT CONCAT(
                cbp.symbol, 
                CASE WHEN cbp.signed = 1 THEN ',signed' ELSE '' END,
                CASE WHEN cbp.collected_by is NULL THEN '' ELSE concat(',', "collect_by(", cbp.collected_by, ")") END,
                ': ', 
                cbp.offering_price
                ) ORDER BY cbp.symbol SEPARATOR '; '
            ) as `price`
    FROM comic_book AS cb
    JOIN title AS t 
    ON cb.title_id = t.id
    LEFT JOIN comic_book_price AS cbp
    ON cb.id = cbp.comic_book_id
    GROUP BY t.title, cb.issue
);
SELECT * FROM comic_books_price_view;

DROP VIEW IF EXISTS graphic_books_price_view;
CREATE VIEW graphic_books_price_view AS (
    SELECT 
        t.title, 
        gn.edition, 
        GROUP_CONCAT(
            DISTINCT CONCAT(
                gnp.symbol, 
                CASE WHEN gnp.signed = 1 THEN ',signed' ELSE '' END,
                CASE WHEN gnp.collected_by is NULL THEN '' ELSE concat(',', "collect_by(", gnp.collected_by, ")") END,
                ': ', 
                gnp.offering_price
                ) ORDER BY gnp.symbol SEPARATOR '; '
            ) as `price`
    FROM graphic_novel AS gn
    JOIN title AS t 
    ON gn.title_id = t.id
    LEFT JOIN graphic_novel_price AS gnp
    ON gn.id = gnp.graphic_novel_id
    GROUP BY t.title, gn.edition
);
SELECT * FROM graphic_books_price_view;

-- View for sotck of books
DROP VIEW IF EXISTS comics_stock_view;
CREATE VIEW comics_stock_view AS (
    SELECT t.title, cb.issue AS number, cbp.symbol, cbp.signed, cbp.collected_by, cbp.special, COUNT(*) AS stock_count
    FROM  comic_book AS cb
    JOIN comic_book_price cbp 
    ON cb.id = cbp.comic_book_id
    JOIN title as t
    ON t.id = cb.title_id
    WHERE cbp.existed = 1
    GROUP BY cb.title_id, cb.issue, cbp.symbol, cbp.signed, cbp.collected_by, cbp.special
    UNION
    SELECT t.title, gn.edition AS number, gnp.symbol, gnp.signed, gnp.collected_by, gnp.special, COUNT(*) AS stock_count
    FROM  graphic_novel AS gn
    JOIN graphic_novel_price AS gnp 
    ON gn.id = gnp.graphic_novel_id
    JOIN title as t
    ON t.id = gn.title_id
    WHERE gnp.existed = 1
    GROUP BY gn.title_id, gn.edition, gnp.symbol, gnp.signed, gnp.collected_by, gnp.special
    ORDER BY stock_count DESC
);
SELECT * FROM comics_stock_view;

-- View for profit for each book
DROP VIEW IF EXISTS comics_profit_view;
CREATE VIEW comics_profit_view AS(
    SELECT title.title, comic_book.issue AS number, comic_book_price.symbol, comic_book_price.signed, comic_book_price.collected_by, comic_book_price.special, comic_book_price.offering_price - comic_book_price.purchase_price AS profit
    FROM comic_book_price
    INNER JOIN comic_book ON comic_book_price.comic_book_id = comic_book.id
    INNER JOIN title ON comic_book.title_id = title.id
    UNION
    SELECT title.title, graphic_novel.edition AS number, graphic_novel_price.symbol, graphic_novel_price.signed, graphic_novel_price.collected_by, graphic_novel_price.special, graphic_novel_price.offering_price - graphic_novel_price.purchase_price AS profit
    FROM graphic_novel_price
    INNER JOIN graphic_novel ON graphic_novel_price.graphic_novel_id = graphic_novel.id
    INNER JOIN title ON graphic_novel.title_id = title.id
    ORDER BY profit DESC
);
SELECT * FROM comics_profit_view;

-- History Sale Book
DROP VIEW IF EXISTS comics_sale_history_view;
CREATE VIEW comics_sale_history_view AS(
    SELECT title.title, comic_book.issue AS number, comic_book_price.symbol, comic_book_price.signed, comic_book_price.collected_by, comic_book_price.special, comic_book_price.purchase_price, comic_book_price.offering_price, comic_book_price.offering_price - comic_book_price.purchase_price AS profit
    FROM comic_book_price
    INNER JOIN comic_book ON comic_book_price.comic_book_id = comic_book.id
    INNER JOIN title ON comic_book.title_id = title.id
    WHERE comic_book_price.existed = 0
    UNION
    SELECT title.title, graphic_novel.edition AS number, graphic_novel_price.symbol, graphic_novel_price.signed, graphic_novel_price.collected_by, graphic_novel_price.special, graphic_novel_price.purchase_price, graphic_novel_price.offering_price, graphic_novel_price.offering_price - graphic_novel_price.purchase_price AS profit
    FROM graphic_novel_price
    INNER JOIN graphic_novel ON graphic_novel_price.graphic_novel_id = graphic_novel.id
    INNER JOIN title ON graphic_novel.title_id = title.id
    WHERE graphic_novel_price.existed = 0
    ORDER BY profit DESC
);
SELECT * FROM comics_sale_history_view;


-- Books with specials
DROP VIEW IF EXISTS comics_special_sale_view;
CREATE VIEW comics_special_sale_view AS(
    SELECT title.title, comic_book.issue AS number, comic_book_price.symbol, comic_book_price.signed, comic_book_price.collected_by, comic_book_price.special, comic_book_price.purchase_price, comic_book_price.offering_price, comic_book_price.offering_price - comic_book_price.purchase_price AS profit
    FROM comic_book_price
    INNER JOIN comic_book ON comic_book_price.comic_book_id = comic_book.id
    INNER JOIN title ON comic_book.title_id = title.id
    WHERE comic_book_price.existed = 1
    AND comic_book_price.special != "None"
    UNION
    SELECT title.title, graphic_novel.edition AS number, graphic_novel_price.symbol, graphic_novel_price.signed, graphic_novel_price.collected_by, graphic_novel_price.special, graphic_novel_price.purchase_price, graphic_novel_price.offering_price, graphic_novel_price.offering_price - graphic_novel_price.purchase_price AS profit
    FROM graphic_novel_price
    INNER JOIN graphic_novel ON graphic_novel_price.graphic_novel_id = graphic_novel.id
    INNER JOIN title ON graphic_novel.title_id = title.id
    WHERE graphic_novel_price.existed = 1
    AND graphic_novel_price.special != "None"
);
SELECT * FROM comics_special_sale_view;