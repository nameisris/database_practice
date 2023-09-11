CREATE TABLE team(
	num INT AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
	LOCAL VARCHAR(100)
);

DROP TABLE player;

CREATE TABLE player(
	num INT AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
	backnum INT,
	teamnum INT REFERENCES team(num)player
);

select p.num, p.name, p.backnum, p.teamnum, t.name from player p join team on p.teamnum = t.num where backnum = 1;