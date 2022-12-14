--Сформулируйте SQL запрос для создания таблицы book, занесите  его в окно кода (расположено ниже)  и отправьте на проверку (кнопка Отправить). Структура таблицы book:

CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author VARCHAR(30),
	price DECIMAL(8, 2),
	amount INT
);

--Занесите новую строку в таблицу book (текстовые значения (тип VARCHAR) заключать либо в двойные, либо в одинарные кавычки):

INSERT INTO book (title, author, price, amount) 
VALUES ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3);

--Занесите три последние записи в таблицуbook,  первая запись уже добавлена на предыдущем шаге:

INSERT INTO book (title, author, price, amount) 
VALUES ('Белая гвардия', 'Булгаков М.А.', 540.50, 5);
INSERT INTO book (title, author, price, amount) 
VALUES ('Идиот', 'Достоевский Ф.М.', 460.00, 10);
INSERT INTO book (title, author, price, amount) 
VALUES ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2);

--Вывести информацию о всех книгах, хранящихся на складе.

SELECT * FROM book;

--Выбрать авторов, название книг и их цену из таблицы book

SELECT author, title, price FROM book;

--Выбрать названия книг и авторов из таблицы book, для поля title задать имя(псевдоним) Название, для поля author –  Автор. 

SELECT title AS Название, author AS Автор
FROM book;

--Для упаковки каждой книги требуется один лист бумаги, цена которого 1 рубль 65 копеек. Посчитать стоимость упаковки для каждой книги (сколько денег потребуется, чтобы упаковать все экземпляры книги). В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack. 

SELECT title, amount, 
     amount * 1.65 AS pack
FROM book;

--В конце года цену всех книг на складе пересчитывают – снижают ее на 30%. Написать SQL запрос, который из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг. Столбец с новой ценой назвать new_price, цену округлить до 2-х знаков после запятой.

SELECT title, 
    author,
    amount, 
    ROUND((price*70/100),2) AS new_price
FROM book;

--При анализе продаж книг выяснилось, что наибольшей популярностью пользуются книги Михаила Булгакова, на втором месте книги Сергея Есенина. Исходя из этого решили поднять цену книг Булгакова на 10%, а цену книг Есенина - на 5%. Написать запрос, куда включить автора, название книги и новую цену, последний столбец назвать new_price. Значение округлить до двух знаков после запятой.

SELECT author, title,
    ROUND(
		IF(
			author='Булгаков М.А.', price*1.1, 
		   IF(
			   author='Есенин С.А.', price*1.05, price
		   )
		  ), 2
	) 
	AS new_price
FROM book;

--Вывести автора, название  и цены тех книг, количество которых меньше 10

SELECT author, title, price
FROM book
WHERE amount < 10;

--Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600, а стоимость всех экземпляров этих книг больше или равна 5000.

SELECT title, author, price, amount
FROM book
WHERE (price<500 OR price>600) AND price * amount >= 5000;

--Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),  а количество или 2, или 3, или 5, или 7 .

SELECT title, author
FROM book
WHERE price BETWEEN 540.50 AND 800 AND amount IN(2,3,5,7);

--Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 (включая границы). Информацию  отсортировать сначала по авторам (в обратном алфавитном порядке), а затем по названиям книг (по алфавиту).

SELECT author, title
FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY author DESC, title;

--Вывести название и автора тех книг, название которых состоит из двух и более слов, а инициалы автора содержат букву «С». Считать, что в названии слова отделяются друг от друга пробелами и не содержат знаков препинания, между фамилией автора и инициалами обязателен пробел, инициалы записываются без пробела в формате: буква, точка, буква, точка. Информацию отсортировать по названию книги в алфавитном порядке.

SELECT title, author
FROM book
WHERE title LIKE '_% _%' 
AND (author LIKE '%С._.' 
OR author LIKE '%_.С.')
ORDER BY title;

--Отобрать различные (уникальные) элементы столбца amount таблицы book.

SELECT amount
FROM book
GROUP BY amount;

--

--Посчитать, количество различных книг и количество экземпляров книг каждого автора , хранящихся на складе.  Столбцы назвать Автор, Различных_книг и Количество_экземпляров соответственно.

SELECT author AS Автор, 
COUNT(title) AS Различных_книг,
SUM(amount) AS Количество_экземпляров
FROM book
GROUP BY author;

--Вывести фамилию и инициалы автора, минимальную, максимальную и среднюю цену книг каждого автора . Вычисляемые столбцы назвать Минимальная_цена, Максимальная_цена и Средняя_цена соответственно.

SELECT author, 
MIN(price) AS Минимальная_цена,
MAX(price) AS Максимальная_цена,
AVG(price) AS Средняя_цена
FROM book
GROUP BY author;

--Для каждого автора вычислить суммарную стоимость книг S (имя столбца Стоимость), а также вычислить налог на добавленную стоимость  для полученных сумм (имя столбца НДС ) , который включен в стоимость и составляет k = 18%,  а также стоимость книг  (Стоимость_без_НДС) без него. Значения округлить до двух знаков после запятой. В запросе для расчета НДС(tax)  и Стоимости без НДС(S_without_tax) использовать следующие формулы:

--tax=(S∗k/100)/(1+k/100)
--S_without_tax=S/(1+k/100)

SELECT author, 
SUM(price*amount) AS Стоимость,
ROUND(
    SUM(price*amount)*18/100/(1+18/100), 
    2
) AS НДС,
ROUND(
    SUM(price*amount)/(1+18/100), 
    2
) AS Стоимость_без_НДС
FROM book
GROUP BY author;

--Вывести  цену самой дешевой книги, цену самой дорогой и среднюю цену уникальных книг на складе. Названия столбцов Минимальная_цена, Максимальная_цена, Средняя_цена соответственно. Среднюю цену округлить до двух знаков после запятой.

SELECT  
MIN(price) AS Минимальная_цена,
MAX(price) AS Максимальная_цена,
ROUND(AVG(price), 2) AS Средняя_цена
FROM book;

--Вычислить среднюю цену и суммарную стоимость тех книг, количество экземпляров которых принадлежит интервалу от 5 до 14, включительно. Столбцы назвать Средняя_цена и Стоимость, значения округлить до 2-х знаков после запятой.

SELECT 
    ROUND(AVG(price), 2) AS Средняя_цена, 
    ROUND(SUM(price*amount), 2) AS Стоимость
FROM book
WHERE amount >=5 AND amount <=14;

--Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия». В результат включить только тех авторов, у которых суммарная стоимость книг (без учета книг «Идиот» и «Белая гвардия») более 5000 руб. Вычисляемый столбец назвать Стоимость. Результат отсортировать по убыванию стоимости.

SELECT
    author,
    SUM(price*amount) AS Стоимость
FROM
    book
WHERE
    title NOT IN ('Белая гвардия', 'Идиот')
GROUP BY
    author 
HAVING
    SUM(price*amount) > 5000
ORDER BY
    SUM(price*amount) DESC
	
--Вывести информацию (автора, название и цену) о  книгах, цены которых меньше или равны средней цене книг на складе. Информацию вывести в отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги.

SELECT 
    author,
    title,
    price
FROM book
WHERE price <= (
         SELECT AVG(price) 
         FROM book
      )
ORDER BY price DESC;

--Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде.

SELECT 
    author,
    title,
    price
FROM book
WHERE price <= (
    ABS
    (
        (
            SELECT MIN(price) FROM book
        ) + 150)
    )
Order BY price
;

--Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется.

SELECT 
    author, 
    title,
    amount 
FROM book
WHERE amount IN (
    SELECT amount
    FROM book
    GROUP BY amount
    HAVING COUNT(amount) = 1
    );
	
--Вывести информацию о книгах(автор, название, цена), цена которых меньше самой большой из минимальных цен, вычисленных для каждого автора.

SELECT 
    author, 
    title, 
    price
FROM book
WHERE price < ANY (
        SELECT MIN(price) 
        FROM book 
        GROUP BY author 
      );

--Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало одинаковое количество экземпляров каждой книги, равное значению самого большего количества экземпляров одной книги на складе. Вывести название книги, ее автора, текущее количество экземпляров на складе и количество заказываемых экземпляров книг. Последнему столбцу присвоить имя Заказ. В результат не включать книги, которые заказывать не нужно.

SELECT 
    title, 
    author, 
    amount, 
    (
        (
            SELECT MAX(amount) 
            FROM book
        )
     - amount
    ) AS Заказ
FROM book
WHERE amount NOT IN 
    (
        SELECT MAX(amount)
        FROM book
     );
	 
--Создать таблицу поставка (supply), которая имеет ту же структуру, что и таблиц book

CREATE TABLE supply(
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
    );
	
--Занесите в таблицу supply четыре записи, чтобы получилась таблица

INSERT INTO supply (
    title,
    author,
    price,
    amount)
VALUES
    ('Лирика', 'Пастернак Б.Л.', 518.99, 2),
    ('Черный человек', 'Есенин С.А.', 570.20, 6),
    ('Белая гвардия', 'Булгаков М.А.', 540.50, 7),
    ('Идиот', 'Достоевский Ф.М.', 360.80, 3);
	
--Добавить из таблицы supply в таблицу book, все книги, кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.

INSERT INTO book (title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author NOT IN ('Булгаков М.А.', 'Достоевский Ф.М.');

--Занести из таблицы supply в таблицу book только те книги, авторов которых нет в  book.

INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount 
FROM supply
WHERE author NOT IN (
        SELECT author 
        FROM book
      );
	  
--Уменьшить на 10% цену тех книг в таблице book, количество которых принадлежит интервалу от 5 до 10, включая границы.

UPDATE book 
SET price = 0.9 * price 
WHERE amount >= 5 AND amount <= 10;

--В таблице book необходимо скорректировать значение для покупателя в столбце buy таким образом, чтобы оно не превышало количество экземпляров книг, указанных в столбце amount. А цену тех книг, которые покупатель не заказывал, снизить на 10%.

--Запрос на обновление количества книг должен корректировать значения в столбце buy  таблицы book следующим образом:

   -- если покупатель заказал количество книг больше, чем есть на складе, то заменить значение buy на имеющееся на складе количество amount;
   -- если покупатель хочет купить количество книг меньшее или равное количеству книг на складе, то значение buy изменять не надо.

UPDATE book
SET price = if(buy = 0, price*0.9, price),
buy = IF(buy > amount, amount, buy);

--Для тех книг в таблице book , которые есть в таблице supply, не только увеличить их количество в таблице book ( увеличить их количество на значение столбца amountтаблицы supply), но и пересчитать их цену (для каждой книги найти сумму цен из таблиц book и supply и разделить на 2).

UPDATE book, supply 
SET book.amount = book.amount + supply.amount,
    book.price = (book.price + supply.price)/2
WHERE book.title = supply.title AND book.author = supply.author;

--Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10.

DELETE FROM supply
WHERE author IN(SELECT author  
    FROM book
    GROUP BY author
    HAVING SUM(amount)>10);
	
--Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, количество экземпляров которых в таблице book меньше среднего количества экземпляров книг в таблице book. В таблицу включить столбец   amount, в котором для всех книг указать одинаковое значение - среднее количество экземпляров книг в таблице book.
	
CREATE TABLE ordering AS
SELECT author, title, 
   (
    SELECT ROUND(AVG(amount)) 
    FROM book
   ) AS amount
FROM book
WHERE amount < (
    SELECT ROUND(AVG(amount)) 
    FROM book
   );

SELECT * FROM ordering;
				 
--Вывести из таблицы trip информацию о командировках тех сотрудников, фамилия которых заканчивается на букву «а», в отсортированном по убыванию даты последнего дня командировки виде. В результат включить столбцы name, city, per_diem, date_first, date_last.
				 
SELECT name,
       city,
       per_diem,
       date_first,
       date_last
FROM trip
WHERE name LIKE '_%а _._.'
ORDER BY date_last DESC;
				 
--Вывести в алфавитном порядке фамилии и инициалы тех сотрудников, которые были в командировке в Москве.

SELECT DISTINCT name
FROM trip
WHERE city LIKE 'Москва'
ORDER BY name;
				 
--Для каждого города посчитать, сколько раз сотрудники в нем были.  Информацию вывести в отсортированном в алфавитном порядке по названию городов. Вычисляемый столбец назвать Количество. 
				 
SELECT city,
       COUNT(city) AS Количество
from trip
GROUP BY city
ORDER BY city;
				 
--Вывести два города, в которых чаще всего были в командировках сотрудники. Вычисляемый столбец назвать Количество

SELECT city,
       COUNT(city) AS Количество
from trip
GROUP BY city
ORDER BY Количество DESC
LIMIT 2;

--Вывести информацию о командировках во все города кроме Москвы и Санкт-Петербурга (фамилии и инициалы сотрудников, город ,  длительность командировки в днях, при этом первый и последний день относится к периоду командировки). Последний столбец назвать Длительность. Информацию вывести в упорядоченном по убыванию длительности поездки, а потом по убыванию названий городов (в обратном алфавитном порядке).
				 
SELECT name,
       city,
       DATEDIFF(date_last, date_first)+1 AS Длительность
FROM trip
WHERE city NOT IN ('Москва', 'Санкт-Петербург')
ORDER BY Длительность DESC, 
				 city DESC;
				 
--Вывести информацию о командировках сотрудника(ов), которые были самыми короткими по времени. В результат включить столбцы name, city, date_first, date_last.
				 
SELECT name,
       city,
       date_first,
       date_last
FROM trip
WHERE DATEDIFF(date_last, date_first) 
IN (
    SELECT(
        MIN(
            DATEDIFF(date_last, date_first)
            )
        )
    FROM trip
    );

--Вывести информацию о командировках, начало и конец которых относятся к одному месяцу (год может быть любой). В результат включить столбцы name, city, date_first, date_last. Строки отсортировать сначала  в алфавитном порядке по названию города, а затем по фамилии сотрудника .
				 	 
SELECT name,
       city,
       date_first,
       date_last
FROM trip
WHERE MONTH(date_first) LIKE MONTH(date_last)
ORDER BY city, name;
				 
--Вывести название месяца и количество командировок для каждого месяца. Считаем, что командировка относится к некоторому месяцу, если она началась в этом месяце. Информацию вывести сначала в отсортированном по убыванию количества, а потом в алфавитном порядке по названию месяца виде. Название столбцов – Месяц и Количество.
				 
SELECT MONTHNAME(date_first) AS Месяц,
       COUNT(MONTHNAME(date_first)) AS Количество
FROM trip
GROUP BY 1
ORDER BY 2 DESC, 1;
					   
--Вывести сумму суточных (произведение количества дней командировки и размера суточных) для командировок, первый день которых пришелся на февраль или март 2020 года. Значение суточных для каждой командировки занесено в столбец per_diem. Вывести фамилию и инициалы сотрудника, город, первый день командировки и сумму суточных. Последний столбец назвать Сумма. Информацию отсортировать сначала  в алфавитном порядке по фамилиям сотрудников, а затем по убыванию суммы суточных.
					   
SELECT name,
       city,
       date_first,
       per_diem*DATEDIFF(date_last+1, date_first) AS Сумма
FROM trip
WHERE YEAR(date_first)=2020 AND MONTH(date_first)=2 OR MONTH(date_first)=3
ORDER BY 1, 4 DESC;
					   
--Вывести фамилию с инициалами и общую сумму суточных, полученных за все командировки для тех сотрудников, которые были в командировках больше чем 3 раза, в отсортированном по убыванию сумм суточных виде. Последний столбец назвать Сумма.

SELECT name,
       SUM(per_diem*DATEDIFF(date_last+1, date_first)) AS Сумма
FROM trip
WHERE name IN (
    SELECT name
    FROM trip
    GROUP BY name
    HAVING COUNT(name)>3
    )
GROUP BY name
ORDER BY 2 DESC;
							 
--Создать таблицу fine

CREATE TABLE fine(
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine DECIMAL(8, 2),
    date_violation date,
    date_payment date
    );
	
--В таблицу fine первые 5 строк уже занесены. Добавить в таблицу записи с ключевыми значениями 6, 7, 8.
							 
INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', Null, '2020-02-14', Null),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', Null, '2020-02-23', Null),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', Null, '2020-03-03', Null);
							 
--Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, в соответствии с данными из таблицы traffic_violation. При этом суммы заносить только в пустые поля столбца  sum_fine.

UPDATE fine AS f, 
       traffic_violation AS tv
SET f.sum_fine = tv.sum_fine
WHERE f.violation = tv.violation AND f.sum_fine is NULL;
							 
--Вывести фамилию, номер машины и нарушение только для тех водителей, которые на одной машине нарушили одно и то же правило   два и более раз. При этом учитывать все нарушения, независимо от того оплачены они или нет. Информацию отсортировать в алфавитном порядке, сначала по фамилии водителя, потом по номеру машины и, наконец, по нарушению.
							 
SELECT name,
       number_plate,
       violation
FROM fine
GROUP BY name, 
		 number_plate, 
		 violation
HAVING count(violation)>=2
ORDER BY name, 
		 number_plate, 
		 violation;
							 
--В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных на предыдущем шаге записей. 
							 
UPDATE fine,
       (
            SELECT name,
                   number_plate,
                   violation
            FROM fine
            GROUP BY name, 
                     number_plate, 
                     violation
            HAVING count(violation)>=2
            ORDER BY name, 
                     number_plate, 
                     violation
         ) AS query_in
 SET fine.sum_fine= 2*fine.sum_fine
 WHERE fine.name=query_in.name 
		AND fine.number_plate=query_in.number_plate 
		AND fine.violation=query_in.violation 
		AND fine.date_payment is NULL;
							 
--Водители оплачивают свои штрафы. В таблице payment занесены даты их оплаты
--Необходимо:

    --в таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment; 
    --уменьшить начисленный штраф в таблице fine в два раза  (только для тех штрафов, информация о которых занесена в таблицу payment) , если оплата произведена не позднее 20 дней со дня нарушения.

UPDATE fine as f,
       payment as p
SET f.date_payment = p.date_payment,
    f.sum_fine = if(DATEDIFF(p.date_payment, p.date_violation)<=20, f.sum_fine/2, f.sum_fine)
WHERE (f.name, f.number_plate, f.violation) = (p.name, p.number_plate, p.violation) 
AND f.date_payment IS NULL;
SELECT * FROM fine;							 
							 
--Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах (Фамилию и инициалы водителя, номер машины, нарушение, сумму штрафа  и  дату нарушения) из таблицы fine							 
							 
CREATE TABLE back_payment
SELECT name,
       number_plate,
       violation,
       sum_fine,
       date_violation
FROM fine
WHERE date_payment IS NULL;
							 
--Удалить из таблицы fine информацию о нарушениях, совершенных раньше 1 февраля 2020 года. 
							 
DELETE FROM fine
WHERE date_violation<'2020-02-01';
							 
--Создать таблицу author 
				
CREATE TABLE author(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
    );
							 
--Заполнить таблицу author. В нее включить следующих авторов:

    --Булгаков М.А.
    --Достоевский Ф.М.
    --Есенин С.А.
    --Пастернак Б.Л.

INSERT INTO author (name_author)
VALUES ('Булгаков М.А.'),
        ('Достоевский Ф.М.'),
        ('Есенин С.А.'),
        ('Пастернак Б.Л.');
					 
--	Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, показанной на логической схеме (таблица genre уже создана, порядок следования столбцов - как на логической схеме в таблице book, genre_id  - внешний ключ) . Для genre_id ограничение о недопустимости пустых значений не задавать. В качестве главной таблицы для описания поля  genre_idиспользовать таблицу genre 
							 
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id),
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id)
);
							 
--Создать таблицу book той же структуры, что и на предыдущем шаге. Будем считать, что при удалении автора из таблицы author, должны удаляться все записи о книгах из таблицы book, написанные этим автором. А при удалении жанра из таблицы genre для соответствующей записи book установить значение Null в столбце genre_id. 
							 
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL);
							 
--Добавьте три последние записи (с ключевыми значениями 6, 7, 8) в таблицу book, первые 5 записей уже добавлены:

INSERT INTO book (title, author_id, genre_id, price, amount)
VALUES ('Стихотворения и поэмы', 3, 2, 650.00, 15),
        ('Черный человек', 3, 2, 570.20, 6),
        ('Лирика', 4, 2, 518.99, 2);
							 
--Вывести название, жанр и цену тех книг, количество которых больше 8, в отсортированном по убыванию цены виде.							 
							 
SELECT title, name_genre, price
FROM 
    genre INNER JOIN book
    ON genre.genre_id = book.genre_id
WHERE amount>8
ORDER BY price DESC;
							 
--Вывести все жанры, которые не представлены в книгах на складе.							 
							 
SELECT name_genre
FROM genre
LEFT JOIN book
ON genre.genre_id = book.genre_id
WHERE book.genre_id is null;
							 
--Есть список городов, хранящийся в таблице city
--Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. Дату проведения выставки выбрать случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки. Последний столбец назвать Дата. Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок.
							 
SELECT name_city, 
       name_author,
       (DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY)) as Дата
FROM city,
     author
ORDER BY name_city,
         Дата DESC;
				 
--Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.
				 
SELECT name_genre,
       title,
       name_author
FROM genre
INNER JOIN book
ON genre.genre_id=book.genre_id
INNER JOIN author
ON book.author_id=author.author_id
WHERE name_genre LIKE 'Роман'
ORDER BY title;
				 
--Посчитать количество экземпляров  книг каждого автора из таблицы author.  Вывести тех авторов,  количество книг которых меньше 10, в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.				 
				 
SELECT name_author,
       SUM(amount) AS Количество
FROM author
LEFT JOIN book
ON author.author_id=book.author_id 
GROUP BY name_author
HAVING Количество < 10 OR Количество is null
ORDER BY Количество;
				 
--Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре. Поскольку у нас в таблицах так занесены данные, что у каждого автора книги только в одном жанре,  для этого запроса внесем изменения в таблицу book. Пусть у нас  книга Есенина «Черный человек» относится к жанру «Роман», а книга Булгакова «Белая гвардия» к «Приключениям» (эти изменения в таблицы уже внесены).				 
				 
SELECT name_author
     FROM author INNER JOIN   
           (SELECT author_id, COUNT(genre_id) AS genre_count
              FROM (SELECT DISTINCT author_id, genre_id FROM book) q1
              GROUP BY author_id
              HAVING genre_count = 1) q2
        on author.author_id = q2.author_id;
				 
--Вывести информацию о книгах (название книги, фамилию и инициалы автора, название жанра, цену и количество экземпляров книги), написанных в самых популярных жанрах, в отсортированном в алфавитном порядке по названию книг виде. Самым популярным считать жанр, общее количество экземпляров книг которого на складе максимально.				 
							 
SELECT  title,
        name_author, 
        name_genre,
        price,
        amount
FROM 
    author 
    INNER JOIN book ON author.author_id = book.author_id
    INNER JOIN genre ON  book.genre_id = genre.genre_id
WHERE genre.genre_id IN
         (
          SELECT query_in_1.genre_id
          FROM 
              (
                SELECT genre_id, SUM(amount) AS sum_amount
                FROM book
                GROUP BY genre_id
               )query_in_1
          INNER JOIN 
              ( 
                SELECT genre_id, SUM(amount) AS sum_amount
                FROM book
                GROUP BY genre_id
                ORDER BY sum_amount DESC
                LIMIT 1
               ) query_in_2
          ON query_in_1.sum_amount= query_in_2.sum_amount
         )
ORDER BY title;
				 
--Если в таблицах supply  и book есть одинаковые книги, которые имеют равную цену,  вывести их название и автора, а также посчитать общее количество экземпляров книг в таблицах supply и book,  столбцы назвать Название, Автор  и Количество.
				 
SELECT title AS Название,
       name_author AS Автор,
       SUM(supply.amount + book.amount) AS Количество
FROM supply 
INNER JOIN book
USING (price, title)
INNER JOIN author
ON author.name_author = supply.author
GROUP BY author.name_author, book.title;
				 
--Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply),  необходимо в таблице book увеличить количество на значение, указанное в поставке,  и пересчитать цену. А в таблице  supply обнулить количество этих книг. 
				 
UPDATE book 
     INNER JOIN author ON author.author_id = book.author_id
     INNER JOIN supply ON book.title = supply.title 
                         and supply.author = author.name_author
SET book.price = (book.price*book.amount + supply.price*supply.amount)/(book.amount+supply.amount), 
    book.amount = book.amount + supply.amount,
    supply.amount = 0 
WHERE supply.price <> book.price;

SELECT * FROM book;
SELECT * FROM supply;				 
				 
--Включить новых авторов в таблицу author с помощью запроса на добавление, а затем вывести все данные из таблицы author.  Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author.				 
				 
INSERT INTO author (name_author)
SELECT supply.author
FROM author
RIGHT JOIN supply 
ON author.name_author = supply.author
WHERE name_author IS Null;
				 
--Добавить новые книги из таблицы supply в таблицу book на основе сформированного выше запроса. Затем вывести для просмотра таблицу book.
				 
INSERT INTO book (title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM 
    author 
    INNER JOIN supply ON author.name_author = supply.author
WHERE amount <> 0;
SELECT * FROM book;
				 
--Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия», а для книги «Остров сокровищ» Стивенсона - «Приключения». (Использовать два запроса).				 
				 
UPDATE book
SET genre_id = 
      (
       SELECT genre_id 
       FROM genre 
       WHERE name_genre = 'Поэзия'
      )
WHERE title LIKE 'Стихотворения и поэмы';

UPDATE book
SET genre_id = 
      (
       SELECT genre_id 
       FROM genre 
       WHERE name_genre = 'Приключения'
      )
WHERE title LIKE 'Остров сокровищ';

SELECT * FROM book;

--Удалить всех авторов и все их книги, общее количество книг которых меньше 20.				 
				 
DELETE FROM author
WHERE author_id IN(SELECT author_id  
    FROM book
    GROUP BY author_id
    HAVING SUM(amount)<20);
SELECT * FROM author;
SELECT * FROM book;				 
				 
--Удалить все жанры, к которым относится меньше 4-х книг. В таблице book для этих жанров установить значение Null.							 
							 
DELETE FROM genre
WHERE genre_id IN (
    SELECT genre_id
    FROM book
    GROUP BY genre_id
    HAVING count(book_id)<4);

SELECT * FROM genre;
SELECT * FROM book;				 
				 
--Удалить всех авторов, которые пишут в жанре "Поэзия". Из таблицы book удалить все книги этих авторов. В запросе для отбора авторов использовать полное название жанра, а не его id.				 
				 
DELETE FROM author
USING author
INNER JOIN book USING(author_id)
INNER JOIN genre USING (genre_id)
WHERE genre.name_genre LIKE 'Поэзия';

SELECT * FROM author;
SELECT * FROM book;
				 
--Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал) в отсортированном по номеру заказа и названиям книг виде.				 
				 
SELECT DISTINCT buy.buy_id,
                title,
                price,
                buy_book.amount
FROM 
    client 
    INNER JOIN buy ON client.client_id = buy.client_id
    INNER JOIN buy_book ON buy_book.buy_id = buy.buy_id
    INNER JOIN book ON buy_book.book_id=book.book_id
WHERE name_client LIKE 'Баранов Павел'
ORDER BY buy_id, title;				 
				 
--Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга).  Вывести фамилию и инициалы автора, название книги, последний столбец назвать Количество. Результат отсортировать сначала  по фамилиям авторов, а потом по названиям книг.
				 
SELECT name_author, 
       title, 
       count(buy_book.amount) AS Количество
FROM author
INNER JOIN book USING(author_id)
LEFT JOIN buy_book USING(book_id)
GROUP BY book.title, name_author
ORDER BY name_author, title;
				 
--Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город, этот столбец назвать Количество. Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов.
				 
SELECT name_city,
       count(buy.client_id) AS Количество
FROM buy
INNER JOIN client USING (client_id)
INNER JOIN city USING (city_id)
GROUP BY name_city
ORDER BY Количество DESC;
				 
--Вывести номера всех оплаченных заказов и даты, когда они были оплачены.				 
				 
SELECT buy_id,
       date_step_end
FROM step
INNER JOIN buy_step USING (step_id)
WHERE name_step LIKE 'Оплата' AND date_step_end IS NOT NULL;
				 
--Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) и его стоимость (сумма произведений количества заказанных книг и их цены), в отсортированном по номеру заказа виде. Последний столбец назвать Стоимость.				 
				 
SELECT s.buy_id, 
       name_client, 
       SUM(Стоимость) AS Стоимость
FROM (
            SELECT buy_book.buy_id, book.price * buy_book.amount AS Стоимость
            FROM buy_book
            INNER JOIN book ON buy_book.book_id = book.book_id
      ) AS s
            INNER JOIN buy ON s.buy_id = buy.buy_id
            INNER JOIN client ON buy.client_id = client.client_id
GROUP BY buy_id
ORDER BY s.buy_id;		
				 
--Вывести номера заказов (buy_id) и названия этапов,  на которых они в данный момент находятся. Если заказ доставлен –  информацию о нем не выводить. Информацию отсортировать по возрастанию buy_id.
				 
SELECT buy_id,
       name_step
FROM buy_step
INNER JOIN step USING (step_id)
WHERE date_step_beg IS NOT NULL AND date_step_end IS NULL
ORDER BY buy_id;
				 
--В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город (рассматривается только этап Транспортировка). Для тех заказов, которые прошли этап транспортировки, вывести количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, указать количество дней задержки, в противном случае вывести 0. В результат включить номер заказа (buy_id), а также вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде.
				 
SELECT buy_step.buy_id,
       datediff(date_step_end, date_step_beg) AS Количество_дней,
       IF(DATEDIFF(date_step_end, date_step_beg) > days_delivery, DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0) AS Опоздание
FROM buy_step
INNER JOIN step USING (step_id)
INNER JOIN buy USING (buy_id)
INNER JOIN client USING (client_id)
INNER JOIN city USING (city_id)
WHERE name_step LIKE 'Транспортировка' AND datediff(date_step_end, date_step_beg) IS NOT NULL
ORDER BY buy_id;
				 
--Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном по алфавиту виде. В решении используйте фамилию автора, а не его id.

SELECT DISTINCT name_client
FROM client
JOIN buy USING (client_id)
JOIN buy_book USING (buy_id)
JOIN book USING (book_id)
JOIN author USING (author_id)
WHERE author.name_author LIKE "Достоевский%" 
ORDER BY name_client;

--Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы. Для этого вывести год, месяц, сумму выручки в отсортированном сначала по возрастанию месяцев, затем по возрастанию лет виде. Название столбцов: Год, Месяц, Сумма.
				 
SELECT YEAR(date_step_end) AS Год,
       MONTHNAME(date_step_end) AS Месяц,
       SUM(price*buy_book.amount) AS Сумма
FROM buy_step
INNER JOIN buy USING (buy_id)
INNER JOIN buy_book USING (buy_id)
INNER JOIN book USING (book_id)
WHERE date_step_end IS NOT NULL AND step_id = 1
GROUP BY MONTHNAME(date_step_end), YEAR(date_step_end)

UNION

SELECT YEAR(date_payment) AS Год,
       MONTHNAME(date_payment) AS Месяц,
       SUM(price*amount) AS Сумма
FROM buy_archive
GROUP BY MONTHNAME(date_payment), YEAR(date_payment)
HAVING Год IS NOT NULL

ORDER BY Месяц, Год;
				 
--Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за 2020 и 2019 год . Вычисляемые столбцы назвать Количество и Сумма. Информацию отсортировать по убыванию стоимости.
				 
SELECT title,
       buy_book.amount,
       price
FROM book
INNER JOIN buy_book USING (book_id)
INNER JOIN buy USING (buy_id)
INNER JOIN buy_step USING (buy_id)
WHERE date_step_end IS NOT NULL;
				 
SELECT title,
       buy_archive.amount,
       buy_archive.price
FROM book
INNER JOIN buy_archive USING (book_id);
				 
SELECT title,
       SUM(amount) AS Количество,
       SUM(amount*price) AS Сумма
FROM(
    SELECT title,
       		buy_book.amount,
       		price
    FROM book
    INNER JOIN buy_book USING (book_id)
    INNER JOIN buy USING (buy_id)
    INNER JOIN buy_step USING (buy_id)
    WHERE date_step_end IS NOT NULL AND step_id=1
    UNION ALL				 
    SELECT title,
      		buy_archive.amount,
       		buy_archive.price
    FROM book
    INNER JOIN buy_archive USING (book_id)) AS a
GROUP BY title
ORDER BY Сумма DESC;
								  
-- Включить нового человека в таблицу с клиентами. Его имя Попов Илья, его email popov@test, проживает он в Москве.
								  
INSERT INTO client (name_client, city_id, email)
SELECT 'Попов Илья', city_id, 'popov@test'
FROM city
WHERE name_city LIKE 'Москва';

SELECT * FROM client;
								  
--Создать новый заказ для Попова Ильи. Его комментарий для заказа: «Связаться со мной по вопросу доставки».
								  
INSERT INTO buy (buy_description, client_id)
SELECT 'Связаться со мной по вопросу доставки', client_id
FROM client
WHERE name_client LIKE 'Попов Илья';

SELECT * FROM buy;
								  
--В таблицу buy_book добавить заказ с номером 5. Этот заказ должен содержать книгу Пастернака «Лирика» в количестве двух экземпляров и книгу Булгакова «Белая гвардия» в одном экземпляре.
								  
INSERT INTO buy_book (buy_id, book_id, amount)
SELECT 5, book_id, 2
FROM book
INNER JOIN author USING (author_id)
WHERE name_author LIKE 'Пастернак%' AND title LIKE 'Лирика';

INSERT INTO buy_book (buy_id, book_id, amount)
SELECT 5, book_id, 1
FROM book
INNER JOIN author USING (author_id)
WHERE name_author LIKE 'Булгаков%' AND title LIKE 'Белая гвардия';

SELECT * FROM buy_book;
								  
--Количество тех книг на складе, которые были включены в заказ с номером 5, уменьшить на то количество, которое в заказе с номером 5  указано.
								  
UPDATE book
JOIN buy_book USING (book_id)
SET book.amount = book.amount - buy_book.amount
WHERE buy_book.buy_id=5;

SELECT * FROM book;
								  
--Создать счет (таблицу buy_pay) на оплату заказа с номером 5, в который включить название книг, их автора, цену, количество заказанных книг и  стоимость. Последний столбец назвать Стоимость. Информацию в таблицу занести в отсортированном по названиям книг виде.
								  
CREATE TABLE buy_pay AS
SELECT title,
       name_author,
       price,
       buy_book.amount,
       price*buy_book.amount AS Стоимость
FROM author
JOIN book USING (author_id)
JOIN buy_book USING (book_id)
WHERE buy_id = 5
ORDER BY title;

SELECT * FROM buy_pay;								  
								  
--Создать общий счет (таблицу buy_pay) на оплату заказа с номером 5. Куда включить номер заказа, количество книг в заказе (название столбца Количество) и его общую стоимость (название столбца Итого). Для решения используйте ОДИН запрос.
								  
CREATE TABLE buy_pay AS
SELECT buy_id,
       SUM(buy_book.amount) AS Количество,
       SUM(price*buy_book.amount) AS Итого
FROM book
JOIN buy_book USING (book_id)
WHERE buy_id = 5;

SELECT * FROM buy_pay;
								  
--В таблицу buy_step для заказа с номером 5 включить все этапы из таблицы step, которые должен пройти этот заказ. В столбцы date_step_beg и date_step_end всех записей занести Null.
								  
INSERT INTO buy_step (buy_id, step_id, date_step_beg, date_step_end)
SELECT 5, step_id, NULL, NULl
FROM step;

SELECT * FROM buy_step;
								  
--В таблицу buy_step занести дату 12.04.2020 выставления счета на оплату заказа с номером 5.								  
								  
UPDATE buy_step
JOIN step USING (step_id)
SET date_step_beg = '2020-04-12' 
WHERE buy_id = 5 AND name_step = 'Оплата';

SELECT * FROM buy_step
WHERE buy_id = 5;
								  
--Завершить этап «Оплата» для заказа с номером 5, вставив в столбец date_step_end дату 13.04.2020, и начать следующий этап («Упаковка»), задав в столбце date_step_beg для этого этапа ту же дату.
								  
UPDATE buy_step
JOIN step USING (step_id)
SET date_step_end = IF(
    step_id = (SELECT step_id
               FROM step
               WHERE name_step = 'Оплата'), '2020-04-13', date_step_end),
    date_step_beg = IF(
    step_id = (SELECT step_id
               FROM step
               WHERE name_step = 'Упаковка'), '2020-04-13', date_step_beg)
WHERE buy_id = 5;

SELECT * FROM buy_step
WHERE buy_id = 5;
								  
--Вывести студентов, которые сдавали дисциплину «Основы баз данных», указать дату попытки и результат. Информацию вывести по убыванию результатов тестирования.
								  
SELECT name_student,
       date_attempt,
       result
FROM student
JOIN attempt USING (student_id)
JOIN subject USING (subject_id)
WHERE name_subject = 'Основы баз данных'
ORDER BY result DESC;
                                  
--Вывести, сколько попыток сделали студенты по каждой дисциплине, а также средний результат попыток, который округлить до 2 знаков после запятой. Под результатом попытки понимается процент правильных ответов на вопросы теста, который занесен в столбец result.  В результат включить название дисциплины, а также вычисляемые столбцы Количество и Среднее. Информацию вывести по убыванию средних результатов.
                                  
SELECT name_subject,
       COUNT(result) AS Количество,
       ROUND(AVG(result), 2) AS Среднее
FROM attempt
RIGHT JOIN subject USING (subject_id)
GROUP BY name_subject
ORDER BY Среднее DESC;

--Вывести студентов (различных студентов), имеющих максимальные результаты попыток. Информацию отсортировать в алфавитном порядке по фамилии студента.                                  
                                  
SELECT name_student,
       result
FROM student
JOIN attempt USING (student_id)
WHERE result = (
    SELECT MAX(result)
    FROM attempt)
ORDER BY name_student;
                                  
--Если студент совершал несколько попыток по одной и той же дисциплине, то вывести разницу в днях между первой и последней попыткой. В результат включить фамилию и имя студента, название дисциплины и вычисляемый столбец Интервал. Информацию вывести по возрастанию разницы. Студентов, сделавших одну попытку по дисциплине, не учитывать. 
                                  
SELECT name_student,
       name_subject,
       DATEDIFF(MAX(date_attempt), MIN(date_attempt)) AS Интервал
FROM student
JOIN attempt USING (student_id)
JOIN subject USING (subject_id)
GROUP BY name_student, name_subject
HAVING Интервал <> 0
ORDER BY Интервал;
                                       
--Студенты могут тестироваться по одной или нескольким дисциплинам (не обязательно по всем). Вывести дисциплину и количество уникальных студентов (столбец назвать Количество), которые по ней проходили тестирование . Информацию отсортировать сначала по убыванию количества, а потом по названию дисциплины. В результат включить и дисциплины, тестирование по которым студенты не проходили, в этом случае указать количество студентов 0.
									   
SELECT name_subject,
       COUNT(DISTINCT(st_id.student_id)) AS Количество
FROM (
    SELECT name_subject,
           student_id
    FROM subject
    LEFT JOIN attempt USING (subject_id)) AS st_id
GROUP BY name_subject
ORDER BY Количество DESC, name_subject;                                       
                                  
--Случайным образом отберите 3 вопроса по дисциплине «Основы баз данных». В результат включите столбцы question_id и name_question.
							 
SELECT question_id,
       name_question
FROM question
JOIN subject USING (subject_id)
WHERE name_subject LIKE 'Основы баз данных'
ORDER BY RAND()
LIMIT 3;
							 
--Вывести вопросы, которые были включены в тест для Семенова Ивана по дисциплине «Основы SQL» 2020-05-17  (значение attempt_id для этой попытки равно 7). Указать, какой ответ дал студент и правильный он или нет (вывести Верно или Неверно). В результат включить вопрос, ответ и вычисляемый столбец  Результат.							 

SELECT name_question,
       name_answer,
       IF(is_correct, 'Верно', 'Неверно') AS Результат
FROM question 
JOIN testing
ON question.question_id = testing.question_id
JOIN answer USING (answer_id)
WHERE attempt_id = 7;							 
							 
--Посчитать результаты тестирования. Результат попытки вычислить как количество правильных ответов, деленное на 3 (количество вопросов в каждой попытке) и умноженное на 100. Результат округлить до двух знаков после запятой. Вывести фамилию студента, название предмета, дату и результат. Последний столбец назвать Результат. Информацию отсортировать сначала по фамилии студента, потом по убыванию даты попытки.
							 
SELECT name_student,
       name_subject,
       date_attempt,
       ROUND((SUM(is_correct)/3*100),2) AS Результат
FROM student
JOIN attempt USING (student_id)
JOIN testing USING (attempt_id)
JOIN subject USING (subject_id)
JOIN answer USING (answer_id)
GROUP BY name_student,
         name_subject,
         date_attempt
ORDER BY name_student,
         date_attempt DESC;							 
					  
--Для каждого вопроса вывести процент успешных решений, то есть отношение количества верных ответов к общему количеству ответов, значение округлить до 2-х знаков после запятой. Также вывести название предмета, к которому относится вопрос, и общее количество ответов на этот вопрос. В результат включить название дисциплины, вопросы по ней (столбец назвать Вопрос), а также два вычисляемых столбца Всего_ответов и Успешность. Информацию отсортировать сначала по названию дисциплины, потом по убыванию успешности, а потом по тексту вопроса в алфавитном порядке.
--Поскольку тексты вопросов могут быть длинными, обрезать их 30 символов и добавить многоточие "...".
					  
SELECT name_subject, 
       CONCAT(LEFT(name_question, 30), '...') AS Вопрос, 
       COUNT(t.answer_id) AS Всего_ответов, 
       ROUND(SUM(is_correct) / COUNT(t.answer_id) * 100, 2) AS Успешность
FROM subject
JOIN question USING(subject_id)
JOIN testing t USING(question_id)
LEFT JOIN answer a USING(answer_id)
GROUP BY name_subject, 
         Вопрос
ORDER BY name_subject, 
         Успешность DESC, 
         Вопрос;					  
					  
--	В таблицу attempt включить новую попытку для студента Баранова Павла по дисциплине «Основы баз данных». Установить текущую дату в качестве даты выполнения попытки.				  
				
INSERT INTO attempt (student_id, subject_id, date_attempt)
SELECT student_id, subject_id, NOW()
FROM student
JOIN attempt USING(student_id)
JOIN subject USING(subject_id)
WHERE name_student LIKE 'Баранов Павел'
      AND name_subject LIKE 'Основы баз данных';					  
					  
-- Случайным образом выбрать три вопроса (запрос) по дисциплине, тестирование по которой собирается проходить студент, занесенный в таблицу attempt последним, и добавить их в таблицу testing.id последней попытки получить как максимальное значение id из таблицы attempt.
					  
INSERT INTO testing (attempt_id, question_id)
SELECT attempt_id, question_id
FROM attempt 
JOIN question USING (subject_id)
WHERE attempt_id =  (
                     SELECT MAX(attempt_id)                            
                     FROM attempt
                     )
ORDER BY RAND()
LIMIT 3;
					  
--Студент прошел тестирование (то есть все его ответы занесены в таблицу testing), далее необходимо вычислить результат(запрос) и занести его в таблицу attempt для соответствующей попытки.  Результат попытки вычислить как количество правильных ответов, деленное на 3 (количество вопросов в каждой попытке) и умноженное на 100. Результат округлить до целого.
--Будем считать, что мы знаем id попытки,  для которой вычисляется результат, в нашем случае это 8.					  
	
UPDATE attempt
SET result = (
    SELECT ROUND(SUM(is_correct)/3*100, 0)
    FROM answer 
    INNER JOIN testing 
    ON answer.answer_id = testing.answer_id
    WHERE attempt_id = 8
    )
WHERE attempt_id = 8;
					  
--Удалить из таблицы attempt все попытки, выполненные раньше 1 мая 2020 года. Также удалить и все соответствующие этим попыткам вопросы из таблицы testing.
					  
DELETE FROM attempt
WHERE date_attempt < "2020-05-01";

SELECT * FROM attempt;
					  
--Вывести абитуриентов, которые хотят поступать на образовательную программу «Мехатроника и робототехника» в отсортированном по фамилиям виде.
					  
SELECT name_enrollee
FROM enrollee 
JOIN program_enrollee USING(enrollee_id)
JOIN program USING(program_id)
WHERE name_program = 'Мехатроника и робототехника'
ORDER BY name_enrollee;


SELECT name_enrollee 
FROM enrollee 
WHERE enrollee_id in 
        (SELECT enrollee_id 
         FROM program_enrollee 
         WHERE program_id in
                 (SELECT program_id 
                  FROM program 
                  WHERE name_program = 'Мехатроника и робототехника'
                 )
        )
ORDER BY name_enrollee;
					  
--Вывести образовательные программы, на которые для поступления необходим предмет «Информатика». Программы отсортировать в обратном алфавитном порядке.
					  
SELECT name_program 
FROM program
JOIN program_subject USING(program_id)
JOIN subject USING(subject_id)
WHERE name_subject = 'Информатика'
ORDER BY name_program DESC;
					  
--Выведите количество абитуриентов, сдавших ЕГЭ по каждому предмету, максимальное, минимальное и среднее значение баллов по предмету ЕГЭ. Вычисляемые столбцы назвать Количество, Максимум, Минимум, Среднее. Информацию отсортировать по названию предмета в алфавитном порядке, среднее значение округлить до одного знака после запятой.
					  
SELECT name_subject,
       COUNT(enrollee_id) AS Количество,
       MAX(result) AS Максимум,
       MIN(result) AS Минимум,
       ROUND(AVG(result),1) AS Среднее
FROM subject
JOIN enrollee_subject USING (subject_id)
GROUP BY name_subject
ORDER BY name_subject;
					  
--Вывести образовательные программы, для которых минимальный балл ЕГЭ по каждому предмету больше или равен 40 баллам. Программы вывести в отсортированном по алфавиту виде.
					  
SELECT name_program
FROM program
JOIN program_subject USING(program_id)
GROUP BY name_program
HAVING MIN(min_result) >= 40
ORDER BY name_program;
					  
--Вывести образовательные программы, которые имеют самый большой план набора,  вместе с этой величиной.
					  
SELECT name_program, plan
FROM program
WHERE plan = (
        SELECT MAX(plan) 
        FROM program);

--Посчитать, сколько дополнительных баллов получит каждый абитуриент. Столбец с дополнительными баллами назвать Бонус. Информацию вывести в отсортированном по фамилиям виде.
					  
SELECT name_enrollee, 
       IFNULL(SUM(bonus), 0) AS Бонус
FROM enrollee
LEFT JOIN enrollee_achievement USING(enrollee_id)
LEFT JOIN achievement USING(achievement_id)
GROUP BY name_enrollee    
ORDER BY name_enrollee;
					  
--Выведите сколько человек подало заявление на каждую образовательную программу и конкурс на нее (число поданных заявлений деленное на количество мест по плану), округленный до 2-х знаков после запятой. В запросе вывести название факультета, к которому относится образовательная программа, название образовательной программы, план набора абитуриентов на образовательную программу (plan), количество поданных заявлений (Количество) и Конкурс. Информацию отсортировать в порядке убывания конкурса.
					  
SELECT name_department, name_program, plan, Количество, ROUND(Количество/plan, 2) AS Конкурс
FROM department
JOIN program USING(department_id)
JOIN (
       SELECT program_id, 
              COUNT(enrollee_id) AS Количество
       FROM  program_enrollee
       GROUP BY program_id
     ) AS temp USING(program_id)
ORDER BY Конкурс DESC;

--Вывести образовательные программы, на которые для поступления необходимы предмет «Информатика» и «Математика» в отсортированном по названию программ виде.					  
		
SELECT name_program
FROM program
JOIN program_subject USING(program_id)
JOIN subject USING(subject_id)
WHERE name_subject IN ("Информатика", "Математика")
GROUP BY name_program
HAVING COUNT(name_program) = 2
ORDER BY name_program;					  

--Вывести название образовательной программы и фамилию тех абитуриентов, которые подавали документы на эту образовательную программу, но не могут быть зачислены на нее. Эти абитуриенты имеют результат по одному или нескольким предметам ЕГЭ, необходимым для поступления на эту образовательную программу, меньше минимального балла. Информацию вывести в отсортированном сначала по программам, а потом по фамилиям абитуриентов виде.				  
					  
SELECT name_program,
       name_enrollee
FROM enrollee
JOIN program_enrollee USING (enrollee_id)
JOIN program USING (program_id)
JOIN program_subject USING (program_id)
JOIN enrollee_subject USING (subject_id, enrollee_id)
WHERE result < min_result
GROUP BY name_program, name_enrollee
ORDER BY name_program, name_enrollee;