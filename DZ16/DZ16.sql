-- drop table users;
CREATE TABLE users (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	username TEXT,
	email TEXT NOT NULL,
	age INTEGER check(age >= 0),
	created_at TEXT DEFAULT CURRENT_TIMESTAMP,
	
	UNIQUE (username, email)
);

select * from users;


INSERT INTO users (username, email, age)
VALUES 
    ('david', 'david@example.com', 22),
    ('emma', 'emma@example.com', 31),
    ('frank', 'frank@example.com', 19),
    ('grace', 'grace@example.com', 27),
    ('henry', 'henry@example.com', 42),
    ('isabella', 'isabella@example.com', 23),
    ('jack', 'jack@example.com', 36),
    ('kate', 'kate@example.com', 29),
    ('liam', 'liam@example.com', 33),
    ('mia', 'mia@example.com', 26),
    ('noah', 'noah@example.com', 24),
    ('olivia', 'olivia@example.com', 37),
    ('peter', 'peter@example.com', 45),
    ('quinn', 'quinn@example.com', 21),
    ('ryan', 'ryan@example.com', 30),
    ('sophia', 'sophia@example.com', 28),
    ('thomas', 'thomas@example.com', 39),
    ('una', 'una@example.com', 32),
    ('victor', 'victor@example.com', 41),
    ('zoe', 'zoe@example.com', 27);


create table promocodes (
	promo_id INTEGER PRIMARY KEY AUTOINCREMENT,
	code TEXT UNIQUE,
	discount_percent INTEGER CHECK(discount_percent >0 AND discount_percent < 100),
	valid_from TEXT,
	valid_to TEXT,
	max_uses INTEGER,
	used_count INTEGER default 0,
	is_active INTEGER default 1,
	created_by INTEGER,
	
	FOREIGN KEY (created_by) REFERENCES users(id)
	
);

drop table promocodes;
select * from promocodes;

insert into promocodes (code, discount_percent, valid_from, valid_to, max_uses, used_count, is_active, created_by) 
VALUES 
	('flower', 10, '2026-01-05', '2027-01-05', 5, 1, 1, 5),
	('CDEK', 25, '2026-01-05', '2026-01-19', 1, 1, 0, 1),
	('maxout', 5, '2024-10-20', '2029-10-20', NULL, 6, 1, 15),
	('xfit', 50, '2023-11-05', '2025-11-05', 3, 3, 0, 4),
	('boombar', 20, '2025-09-12', '2026-03-12', 10, 2, 1, 3),
	('FROZEN', 10, '2025-12-29', '2026-01-29', 8, 1, 1, 2),
	('karitop', 15, '2026-01-01', '2026-01-30', 1, 0, 1, 11),
	('ozonby', 1, '2025-01-10', '2025-06-10', 5, 4, 0, 8),
	('davici', 30, '2024-01-05', '2026-01-05', NULL, 9, 0, 12),
	('cleverok', 50, '2026-03-25', '2026-04-25', 3, 0, 0, 2);
	
	
select COUNT (*) from promocodes;
	
select AVG(discount_percent) from promocodes;	
	
select count(*) from promocodes
where is_active == 1;


select 
	case
		when discount_percent < 10 then 'Under 10%'
		when discount_percent between 10 and 29 then '10-29%'
		when discount_percent between 30 and 49 then '30-49%'
		when discount_percent >= 50 then '50%+'
	end as discount_group,
	count(*) as 'count',
	MAX(discount_percent) as 'max',
	MIN(discount_percent) as 'min',
	count(max_uses >= 1) as 'limited'
from promocodes
group by discount_group;

select 
	case 
		when valid_to < CURRENT_DATE then 'Истекший'
		when valid_from > CURRENT_DATE then 'Не начавшийся'
		else 'Активный'
	end as data_group,
	count(*) as 'count',
	AVG(discount_percent) as 'average percent',
	count(max_uses >= 1) as 'limited'
from promocodes
group by data_group;