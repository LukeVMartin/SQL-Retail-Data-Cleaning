#Delete Duplicates (done)
#Standardize Data (done)
#Null/Blank Values (done)
#Delete "Useless" Rows if necessary (not needed)

CREATE TABLE retail_store_clean
LIKE retail_store_sales;

INSERT retail_store_clean
SELECT *
FROM retail_store_sales;


WITH duplicate_retail AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY `retail_store_clean`.`Transaction ID`,
    `retail_store_clean`.`Customer ID`,
    `retail_store_clean`.`Category`,
    `retail_store_clean`.`Item`,
    `retail_store_clean`.`Price Per Unit`,
    `retail_store_clean`.`Quantity`,
    `retail_store_clean`.`Total Spent`,
    `retail_store_clean`.`Payment Method`,
    `retail_store_clean`.`Location`,
    `retail_store_clean`.`Transaction Date`,
    `retail_store_clean`.`Discount Applied`) AS Row_NUM
FROM retail_store_clean)
SELECT *
FROM duplicate_retail
WHERE Row_NUM >= 2;

SELECT * 
FROM retail_store_clean
WHERE `Customer ID` = 'CUST_01' AND Category = 'Food' AND Item = 'Item_5_FOOD' AND Quantity = 5;

CREATE TABLE `retail_store_cleaned` (
  `Transaction ID` text,
  `Customer ID` text,
  `Category` text,
  `Item` text,
  `Price Per Unit` double DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Total Spent` double DEFAULT NULL,
  `Payment Method` text,
  `Location` text,
  `Transaction Date` text,
  `Discount Applied` text,
  `Row_Num` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO retail_store_cleaned
SELECT *, ROW_NUMBER() OVER(PARTITION BY `retail_store_clean`.`Transaction ID`,
    `retail_store_clean`.`Customer ID`,
    `retail_store_clean`.`Category`,
    `retail_store_clean`.`Item`,
    `retail_store_clean`.`Price Per Unit`,
    `retail_store_clean`.`Quantity`,
    `retail_store_clean`.`Total Spent`,
    `retail_store_clean`.`Payment Method`,
    `retail_store_clean`.`Location`,
    `retail_store_clean`.`Transaction Date`,
    `retail_store_clean`.`Discount Applied`)
FROM retail_store_clean;

SELECT *
FROM retail_store_cleaned;

DELETE 
FROM retail_store_cleaned
WHERE Row_Num > 1;

SELECT cleana.Item, cleana.Category, cleanb.Category
FROM retail_store_cleaned AS cleana
JOIN retail_store_cleaned AS cleanb
	ON cleana.item = cleanb.item
WHERE cleana.Category = 'Computer and electric accessories'
AND cleanb.Category = 'Electric household essentials';

#Did these on every column but did not want to clutter the code
SELECT DISTINCT(Category)
FROM retail_store_cleaned;

SELECT DISTINCT(`Payment Method`)
FROM retail_store_cleaned;

SELECT *
FROM retail_store_cleaned
ORDER BY `Item`;

SELECT `Transaction Date`
FROM retail_store_cleaned;

ALTER TABLE retail_store_cleaned
MODIFY COLUMN `Transaction Date` DATE;

#I could see only Discount Applied had problems with its Null/Blank Values.
SELECT *
FROM retail_store_cleaned
WHERE `Discount Applied` LIKE '' OR `Discount Applied` IS NULL;


UPDATE retail_store_cleaned
SET `Discount Applied` = 'False'
WHERE `Discount Applied` LIKE '';

#Decided to make it a Boolean this way it will be easier in the future to 
UPDATE retail_store_cleaned
SET `Discount Applied` = 0
WHERE `Discount Applied` LIKE 'False';

UPDATE retail_store_cleaned
SET `Discount Applied` = 1
WHERE `Discount Applied` LIKE 'True';

ALTER TABLE retail_store_cleaned
MODIFY COLUMN `Discount Applied` BOOLEAN;

#Double checking to see it worked.
SELECT DISTINCT(`Discount Applied`)
FROM retail_store_cleaned;

ALTER TABLE retail_store_cleaned
Drop Column `Row_NUM`;

SELECT *
FROM retail_store_cleaned;
