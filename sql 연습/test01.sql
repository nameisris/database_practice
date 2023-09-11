-- 1번
SELECT p.pdname, p.pdsubname, f.facname, str.stoname, stk.stamount
FROM product p
JOIN factory f ON p.factno = f.factno
JOIN stock stk ON p.PDNO = stk.pdno
JOIN store str ON stk.stono = str.STONO
WHERE f.facloc = 'seoul' AND (stk.stamount = 0 OR stk.stamount IS NULL);

-- 2번
SELECT pdsubname, pdcost, pdprice
FROM product
WHERE pdcost > (SELECT MIN(pdcost) FROM product WHERE pdname = 'tv') AND
pdcost < (SELECT MAX(pdcost) FROM product WHERE pdname = 'cellphone');

-- 3번
CREATE TABLE DISCARDED_PRODUCT(
	pdno INT PRIMARY KEY,
	pdname VARCHAR(10),
	pdsubname VARCHAR(10),
	factno VARCHAR(5) REFERENCES factory(factno),
	pddate DATE,
	pdcost INT,
	pdprice INT,
	pdamount INT,
	discarded_date DATE
);

-- 4번
START TRANSACTION;
INSERT INTO discarded_product(pdno, pdname, pdsubname, factno, pddate, pdcost, pdprice, pdamount)
(SELECT pdno, pdname, pdsubname, factno, pddate, pdcost, pdprice, pdamount FROM product);
UPDATE discarded_product SET discarded_date = CURDATE() WHERE discarded_date IS NULL;
COMMIT;

-- 5번
START TRANSACTION;
DELETE FROM product
WHERE pdno = (SELECT pdno FROM discarded_product WHERE discarded_date < CURDATE());
ROLLBACK;

COMMIT;