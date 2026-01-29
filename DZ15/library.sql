create table books (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	title TEXT not null, --Название книги
	year TEXT,
	author_id int references authors(author_id), 
	genre TEXT,
	quantity int,
	status TEXT default 'Доступна'
);


create table authors (
	author_id INTEGER PRIMARY KEY AUTOINCREMENT,
	full_name TEXT not null, -- ФИО автора
	birth_year TEXT,
	country TEXT,
	bio TEXT
);

create table readers (
	reader_id INTEGER PRIMARY KEY AUTOINCREMENT,
	full_name TEXT not null, -- ФИО автора
	ticket_number int UNIQUE,
	reg_date TEXT default CURRENT_DATE,
	phone TEXT,
	email TEXT
);


select * from authors;

INSERT INTO authors (full_name, birth_year, country, bio) VALUES 
('Блейк Пирс', '1993', 'США', 'Американский писатель, автор романов в жанре мистического детектива и триллера'),
('Донато Карризи', '1973', 'Италия', 'Итальянский писатель, режиссёр и сценарист'),
('Шейла Робертс', '1951', 'США', 'Американская писательница, автор женских и любовных романов'),
('Анджей Сапковский', '1948', 'Польша', 'Польский писатель-фантаст и публицист, автор популярной фэнтези-саги «Ведьмак»')

select * from books;

INSERT INTO books (title, year, author_id, genre, quantity, status) VALUES 
('След смерти', '2017', 1, 'Детектив', '3','Доступна'),
('Воспитание бабочек', '2025', 2, 'Детектив, триллер', '1','На руках'),
('Любовь приходит в рождество', '2025', 3, 'Роман', '5','Доступна'),
('Меч предназначения', '2021', 4, 'Фэнтэзи', '2','Доступна'),
('Ведьмак', '2014', 4, 'Фэнтэзи', '5','Доступна'),
('Потерянные девушки Рима', '2017', 2, 'Детектив', '2','На руках')

select * from readers;

INSERT INTO readers (full_name, ticket_number, reg_date, phone, email) VALUES 
('Иванов Иван Иванович', '546895', '2025-12-05', '+375896212454','varitupes@koletter.com'),
('Петров Петр Петрович', '896541', '2025-11-05', '+375691230657','qunotate@mailfrs.com'),
('Романова Инна Сергеевна', '654285', '2025-02-03', '+375896268741','vexuy@opemails.com'),
('Сильнов Добрыня Никитич', '256398', '2024-08-25', '+375569842156','sihutawaz@koletter.com'),
('Ромашко Анастасия Николаевна', '146258', '2025-06-03', '+375654789321','migera@uiemail.com'),
('Сокольников Дмитрий Валерьевич', '321654', '2026-01-05', '+375369258147','rasukis@koletter.com');

create table book_distribution (
	book_id int references books(id),
	title TEXT,
	reader_id int references readers(reader_id),
	full_name TEXT not null,
	ticket_number int not null 	
);

select * from book_distribution;

INSERT INTO book_distribution (book_id, title, reader_id, full_name, ticket_number) VALUES 
(1, 'След смерти', 1, 'Иванов Иван Иванович','546895'),
(2, 'Воспитание бабочек', 4, 'Сильнов Добрыня Никитич','256398'),
(3, 'Любовь приходит в рождество', 1, 'Иванов Иван Иванович','546895'),
(3, 'Любовь приходит в рождество', 3, 'Романова Инна Сергеевна','654285'),
(5, 'Ведьмак', 6, 'Сокольников Дмитрий Валерьевич','321654'),
(6, 'Потерянные девушки Рима', 1, 'Иванов Иван Иванович','546895');

select title from books  
where title like 'В%';

SELECT authors.full_name, authors.author_id, 
(SELECT SUM(quantity) FROM books WHERE authors.author_id = books.author_id ) AS Total 
FROM authors 

