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