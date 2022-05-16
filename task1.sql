DROP TABLE IF EXISTS discount_cards CASCADE;
DROP TABLE IF EXISTS addresses CASCADE;
DROP TABLE IF EXISTS waiters CASCADE;
DROP TABLE IF EXISTS visiters CASCADE;
DROP TABLE IF EXISTS halls CASCADE;
DROP TABLE IF EXISTS events CASCADE;
DROP TABLE IF EXISTS menu CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS billing CASCADE;
DROP TABLE IF EXISTS menu_orders CASCADE;
DROP TABLE IF EXISTS event_orders CASCADE;

CREATE TABLE discount_cards(
	name VARCHAR(10) PRIMARY KEY,
	discount_proc DECIMAL (2,0)
);

CREATE TABLE addresses(
    id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    address_name VARCHAR(50)
);

CREATE TABLE waiters(
    id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(50),
	address_id INT NOT NULL,
	FOREIGN KEY (address_id) REFERENCES addresses (id)
);

CREATE TABLE visiters(
    id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(50),
	visites_count INT,
	card_name VARCHAR(10),
	FOREIGN KEY (card_name) REFERENCES discount_cards (name)
);

CREATE TABLE halls(
    id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    hall_num INT,
	address_id INT NOT NULL,
	FOREIGN KEY (address_id) REFERENCES addresses (id),
	tables_count INT
);

CREATE TABLE events(
    id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(50),
	price INT,
    show_time TIME
);

CREATE TABLE menu(
    id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(50),
	type VARCHAR(10),
	price INT
);

CREATE TABLE bookings(
	id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	booking_date DATE,
    time_start TIME,
	time_end TIME,
	visiter_id INT NOT NULL,
	FOREIGN KEY (visiter_id) REFERENCES visiters (id),
	hall_id INT NOT NULL,
	FOREIGN KEY (hall_id) REFERENCES halls (id),
	full_hall BOOL,
	table_num INT
);

CREATE TABLE billing(
	id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	visiter_id INT NOT NULL,
	FOREIGN KEY (visiter_id) REFERENCES visiters (id),
	waiter_id INT NOT NULL,
	FOREIGN KEY (waiter_id) REFERENCES waiters (id),
	booking_id INT NOT NULL,
	FOREIGN KEY (booking_id) REFERENCES bookings (id),
	billing_date DATE,
	billing_time TIME
);

CREATE TABLE menu_orders(
	id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	food_id INT NOT NULL,
	FOREIGN KEY (food_id) REFERENCES menu (id),
	amount INT,
	bill_id INT NOT NULL,
	FOREIGN KEY (bill_id) REFERENCES billing (id)
);

CREATE TABLE event_orders(
	id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	event_id INT NOT NULL,
	FOREIGN KEY (event_id) REFERENCES events (id),
	start_time TIME,
	bill_id INT NOT NULL,
	FOREIGN KEY (bill_id) REFERENCES billing (id)
);

--Заполнение таблиц
INSERT INTO discount_cards (name, discount_proc) VALUES
('none', 0), ('SILVER', 5), ('GOLD', 10), ('PREMIER', 15);

INSERT INTO addresses (address_name) VALUES ('Ул. Аббата, 24'), ('Пр. Просвещения, 14'), ('Ул. Марата, 8');

INSERT INTO waiters (name, address_id) VALUES
('Иванов Дмитрий Маркович', 1),
('Комаров Лев Александрович', 1),
('Яковлева Виктория Никитична', 1),
('Барсукова Анастасия Данииловна', 1),
('Соловьев Артём Дмитриевич', 1),
('Бобров Михаил Михайлович', 1),
('Петровский Макар Александрович', 1),
('Ковалев Виктор Алексеевич', 1),
('Морозова Полина Мартиновна', 1),
('Голубева Мадина Никитична', 2),
('Панфилов Константин Георгиевич', 2),
('Ермолова София Михайловна', 2),
('Журавлев Максим Давидович', 2),
('Козлов Михаил Александрович', 2),
('Симонов Иван Кириллович', 2),
('Владимиров Михаил Артёмович', 2),
('Иванов Платон Фёдорович', 2),
('Быков Максим Тимофеевич', 2),
('Афанасьева Валерия Артуровна', 2),
('Морозова Софья Семёновна', 3),
('Голубев Арсений Алиевич', 3),
('Иванова Медина Максимовна', 3),
('Кравцова София Михайловна', 3),
('Титова София Ильинична', 3),
('Маркин Александр Мирославович', 3),
('Орлова Мария Евгеньевна', 3),
('Грачев Игорь Михайлович', 3),
('Литвинов Иван Львович', 3);

INSERT INTO visiters (name, visites_count, card_name) VALUES
('Юдин Артём Александрович', 0, 'none'),
('Еремин Максим Ярославович', 0, 'none'),
('Павлов Роман Петрович', 0, 'none'),
('Коровин Владимир Матвеевич', 1, 'GOLD'),
('Лавров Тимур Даниилович', 1, 'none'),
('Коновалова София Павловна', 2, 'none'),
('Новикова Александра Александровна', 2, 'SILVER'),
('Абрамова Алиса Александровна', 2, 'SILVER'),
('Зиновьева Василиса Никитична', 2, 'GOLD'),
('Овсянников Михаил Кириллович', 2, 'none'),
('Безрукова Анастасия Романовна', 3, 'PREMIER'),
('Соболева Анна Артуровна', 3, 'none'),
('Белоусова Сафия Давидовна', 3, 'none'),
('Ушаков Максим Артемьевич', 3, 'none')/*,
('Лукьянова Алиса Дмитриевна', 4),
('Лебедев Арсений Михайлович', 4),
('Никитин Макар Матвеевич', 5),
('Алешин Артём Никитич', 5),
('Морозова София Лукинична', 5, 'none'),
('Воронцова Ариана Арсентьевна', 5),
('Павлов Мирослав Артёмович', 5),
('Иванова Полина Павловна', 6),
('Харитонов Артём Кириллович', 6),
('Давыдова Василиса Максимовна', 7),
('Иванов Михаил Степанович', 9),
('Широкова Варвара Артёмовна', 9),
('Абрамов Константин Романович', 10),
('Рыбаков Семён Русланович', 10),
('Воронина Юлия Андреевна', 10),
('Леонтьев Мирон Львович', 12),
('Бондарев Марк Маркович', 14),
('Фадеева София Фёдоровна', 20),
('Григорьев Алексей Алексеевич', 21),
('Овчинникова Александра Григорьевна', 25),
('Фадеева Анна Сергеевна', 31),
('Фомина Марта Ивановна', 39),
('Семенов Кирилл Максимович', 41),
('Скворцова Ксения Дмитриевна', 52)*/;

INSERT INTO halls (hall_num, address_id, tables_count) VALUES
(1, 1, 6), (2, 1, 6), (3, 1, 7),
(1, 2, 9), (2, 2, 8), (3, 2, 9), (4, 2, 11),
(1, 3, 7), (2, 3, 7);

INSERT INTO events (name, price, show_time) VALUES
('Fireshow', 1800, '0:30:00'),
('Живая музыка, 1 ч', 1000, '1:00:00'),
('Живая музыка, 2 ч', 2000, '2:00:00');

INSERT INTO menu (name, type, price) VALUES
('Cappuccino', 'COFFEE', 200),
('Espresso', 'COFFEE', 180),
('Americano', 'COFFEE', 200),
('Latte', 'COFFEE', 180),
('Turkish Coffee', 'COFFEE', 210),
('Hot chocolate', 'COFFEE', 200),
('Earl Grey', 'TEA', 150),
('Green Tea', 'TEA', 150),
('Fruit Tea', 'TEA', 150),
('Chai Tea', 'TEA', 210),
('Ice cream', 'DESSERT', 240),
('Chocolate maffin', 'DESSERT', 250),
('Cheese cake', 'DESSERT', 230);

INSERT INTO bookings (booking_date, time_start, time_end, visiter_id, hall_id, full_hall, table_num) VALUES
('2022-05-16', '9:00:00', '12:00:00', 8, 7, TRUE, 0),
('2022-05-16', '11:00:00', '13:00:00', 11, 5, FALSE, 3);

INSERT INTO billing (visiter_id, waiter_id, booking_id, billing_date, billing_time) VALUES
(6, 16, 1, '2022-05-16', '12:07:00');

INSERT INTO menu_orders (food_id, amount, bill_id) VALUES
(5, 4, 1),
(11, 2, 1),
(12, 1, 1);

INSERT INTO event_orders (event_id, start_time, bill_id) VALUES
(1, '9:30:00', 1);

--SELECT * FROM addresses;
--SELECT * FROM waiters;
--SELECT * FROM visiters;
--SELECT * FROM discount_cards;
--SELECT * FROM halls;
--SELECT * FROM events;
--SELECT * FROM menu;
--SELECT * FROM bookings;
--SELECT * FROM billing;
--SELECT * FROM menu_orders;
--SELECT * FROM event_orders;