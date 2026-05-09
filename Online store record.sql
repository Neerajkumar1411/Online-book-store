CREATE TABLE BOOKS(
			Book_ID INT,
			Title VARCHAR(100),
			Author VARCHAR(100),
			Genre VARCHAR (100),
			Published_Year INT,
			Price NUMERIC (10,2),
			Stock INT

);

SELECT * FROM BOOKS ;

			-- PRACTICE--

--1  1. Retrieve all books wrtten by Mario Moore. 


SELECT TITLE  FROM BOOKS
WHERE AUTHOR = 'Mario Moore'


--Show the titles and prices of books published after 2000.

select title from books
where published_year = 2000;

-- List all books in the Fantasy genre with stock greater than 50.

SELECT title,GENRE,STOCK  from books 
WHERE genre = 'Fantasy' AND stock > 50
ORDER BY STOCK DESC;

-- 4. Find the average price of books in each genre.

SELECT distinct genre ,avg( PRICE ) AS AVG_price  from books
group by genre 
order by AVG_PRICE desc; 

-- Count how many books were published in each decade.

SELECT 
    (Published_Year / 10) * 10  AS Decade, Genre,
    COUNT(*) AS Books_Published
FROM Books
GROUP BY (Published_Year / 10) * 10, Genre
ORDER BY Decade, Genre desc;

--Identify the author who has the highest number of books in stock.

SELECT Author, SUM(Stock) AS Total_Stock
FROM Books
GROUP BY Author
ORDER BY Total_Stock DESC
LIMIT 1;

--Find the most expensive book in the Science Fiction genre.

select title , max(price) AS highest_price
from books group by title
order by highest_price desc
limit 1;

--List all books whose price is above the average price of all books.


SELECT TITLE, PRICE
FROM BOOKS
WHERE PRICE > (select avg(price) from books) ;

--Show the titles of books that have less than 5 stock but cost more than 40.

SELECT title,price,stock from books
where price>40 and stock <5;


--Rank books within each genre by price (highest to lowest).

select genre ,price,
rank () over (partition by genre order by price desc) 
 from books
 order by genre,price desc;

 --Find the top 3 most expensive books overall.

select title ,price from books
order by price desc limit 3;

--Show all books where the title contain: the word "Adaptive".

SELECT title 
from Books 
WHERE TITLE LIKE '%Adaptive%' ;

--Calculate the total stock value (Price x Stock) for each genre.

SELECT genre ,
sum (stock*price) AS total_stock_value
from books
GROUP BY genre 
ORDER BY total_stock_value;

-- Find books published in the same year as "Customizable 24hour product".


SELECT TITLE, PUBLISHED_YEAR FROM BOOKS
where PUBLISHED_YEAR =2020;

--15. Identify the cheapset book in each genre.

select genre ,
min(price) as cheapest 
from books
group by genre 
order by cheapest;


--16. Find the genre with the highest overall stock.

SELECT genre ,
max(stock) as MAX_STOCK
FROM BOOKS
GROUP BY GENRE
ORDER BY MAX_STOCK DESC;

--17. Show all authors who have written books in multiple genres.

SELECT author
FROM books
GROUP BY author
HAVING COUNT(DISTINCT genre) > 1;

SELECT AUTHOR 
FROM BOOKS 
GROUP BY AUTHOR 
HAVING COUNT ( DISTINCT GENRE )> 1;

--18. List books published before 1950 that are still in stock above 50.

SELECT published_year,title ,stock,genre,price 
from books
WHERE PUBLISHED_YEAR < 1950 AND stock>50;


SELECT title, author, genre, published_year, stock
FROM books
WHERE published_year < 1950
  AND stock > 50;

  --19. Find the median price of all books.

SELECT AVG(price) AS median_price
FROM (
    SELECT price
    FROM books
    ORDER BY price
    LIMIT 2 - (SELECT COUNT(*) FROM books) % 2
    OFFSET (SELECT (COUNT(*) - 1) / 2 FROM books)
) sub;

--20. Create a query that returns the 5 oldest books in the dataset.

SELECT book_id,title,author, published_year,genre,price,stock
from books
order by published_year limit 5;


SELECT 
    Book_ID,
    Title,
    Author,
    Genre,
    Published_Year,
    Price,
    Stock
FROM books
ORDER BY Published_Year ASC
LIMIT 5;
										--completed