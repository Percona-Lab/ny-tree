DELIMITER //

DROP FUNCTION IF EXISTS `ny_tree_spaces`; 
-- This function draws a space or any other symbol specified number of times
-- smb - the symbol to draw
-- cnt - number of times to repeat the symbol

CREATE FUNCTION `ny_tree_spaces`(smb varchar(1), cnt int) RETURNS varchar(16383) CHARSET utf8mb4
    DETERMINISTIC
BEGIN 
  DECLARE result_str VARCHAR(16383) DEFAULT '';
  DECLARE i int default 1;
label1: LOOP
    IF i <= cnt THEN
      SET result_str = CONCAT(result_str, smb);
      SET i = i + 1;
      ITERATE label1;
    END IF;
    LEAVE label1;
  END LOOP label1;
  RETURN result_str; 
END//

DROP FUNCTION IF EXISTS `ny_tree_lights`; 
-- This function draws a space or any other symbol specified number of times
-- and randomly injects "lights" symbol: star or anything else that looks fun
-- smb - the symbol to draw
-- cnt - number of times to repeat the symbol
-- light - extra symblo for "lights"

CREATE FUNCTION `ny_tree_lights`(smb varchar(1), cnt int, light varchar(1)) RETURNS varchar(16383) CHARSET utf8mb4
BEGIN   
  DECLARE result_str VARCHAR(16383) DEFAULT '';   
  DECLARE i int default 1; 
label1: LOOP
     IF i <= cnt THEN
       IF (FLOOR(RAND() * 10) % 2) = 1 THEN
         SET result_str = CONCAT(result_str, light);
       ELSE
         SET result_str = CONCAT(result_str, smb);
       END IF;
         SET i = i + 1;
       ITERATE label1;
     END IF;
     LEAVE label1;
   END LOOP label1;
   RETURN result_str;
END//

DROP FUNCTION IF EXISTS `ny_tree`; 
-- The main functions that draws the tree
-- lvl - the number of levels the tree has.
-- light - extra symblo for "lights"
CREATE FUNCTION `ny_tree`(lvl int, light varchar(1)) RETURNS varchar(16383) CHARSET utf8mb4
BEGIN
  DECLARE result_tree VARCHAR(16383) DEFAULT '\n';
  DECLARE i int default 1;
label1: LOOP
    IF i <= lvl THEN
     SET result_tree = CONCAT(result_tree, 
                              ny_tree_spaces(' ', lvl-i+1), 
                              '/', 
                              ny_tree_lights(' ', i*2-2, light),
                              '\\',
                              '\n');
     SET result_tree = CONCAT(result_tree, 
                              ny_tree_spaces(' ', lvl-i),
                              '/',
                              ny_tree_spaces('_', i*2),
                              '\\',
                              '\n');
      SET i = i + 1;
      ITERATE label1;
    END IF;
    LEAVE label1;
  END LOOP label1;
  SET result_tree = CONCAT(result_tree, ny_tree_spaces(' ', lvl), '||');
  RETURN result_tree; 
END//

DELIMITER ;
;
