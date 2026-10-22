CREATE DATABASE DBMS_PROJECT;
USE DBMS_PROJECT;

CREATE TABLE Member (
  member_id INTEGER PRIMARY KEY,
  name      VARCHAR(50) NOT NULL,
  email     VARCHAR(80) UNIQUE,
  phone     VARCHAR(15),
  join_date DATE
);

CREATE TABLE Book (
  book_id          INTEGER PRIMARY KEY,
  title            VARCHAR(100) NOT NULL,
  author           VARCHAR(50),
  category         VARCHAR(30),
  copies_available INTEGER DEFAULT 1 CHECK (copies_available >= 0)
);

CREATE TABLE Issue (
  issue_id    INTEGER PRIMARY KEY,
  member_id   INTEGER NOT NULL,
  book_id     INTEGER NOT NULL,
  issue_date  DATE NOT NULL,
  due_date    DATE NOT NULL,
  return_date DATE,
  FOREIGN KEY (member_id) REFERENCES Member(member_id),
  FOREIGN KEY (book_id)   REFERENCES Book(book_id)
);


INSERT INTO Member VALUES
(1,'Aarav Sharma','aarav@mail.com','9876543210','2026-01-10'),
(2,'Priya Nair','priya@mail.com','9123456780','2026-02-15'),
(3,'Rohan Mehta','rohan@mail.com','9988776655','2026-03-05'),
(4,'Sneha Iyer','sneha@mail.com','9090909090','2026-03-20'),
(5,'Karan Singh','karan@mail.com','9812345678','2026-04-02'),
(6,'Divya Patel','divya@mail.com','9701234567','2026-04-18'),
(7,'Arjun Reddy','arjun@mail.com','9600011122','2026-05-09'),
(8,'Meera Das','meera@mail.com','9555544433','2026-06-01'),
(9,'Vikram Joshi','vikram@mail.com','9444433322','2026-07-12'),
(10,'Ananya Rao','ananya@mail.com','9333322211','2026-08-25');


INSERT INTO Book VALUES
(101,'Database Systems','Korth','Computer Science',3),
(102,'Wings of Fire','A.P.J. Abdul Kalam','Biography',2),
(103,'Operating Systems','Galvin','Computer Science',4),
(104,'The Alchemist','Paulo Coelho','Fiction',2),
(105,'Discrete Mathematics','Rosen','Mathematics',3),
(106,'Computer Networks','Tanenbaum','Computer Science',1),
(107,'Gitanjali','Rabindranath Tagore','Poetry',2),
(108,'Data Structures','Lipschutz','Computer Science',5),
(109,'My Experiments with Truth','M.K. Gandhi','Biography',1),
(110,'Engineering Physics','Gaur and Gupta','Physics',0);


INSERT INTO Issue VALUES
(1,1,101,'2026-09-01','2026-09-15','2026-09-14'),
(2,2,102,'2026-09-03','2026-09-17','2026-09-20'),
(3,3,103,'2026-09-10','2026-09-24','2026-09-22'),
(4,1,108,'2026-09-12','2026-09-26',NULL),
(5,4,104,'2026-09-18','2026-10-02','2026-10-01'),
(6,5,106,'2026-09-25','2026-10-09',NULL),
(7,6,105,'2026-10-01','2026-10-15','2026-10-12'),
(8,2,101,'2026-10-05','2026-10-19',NULL),
(9,7,107,'2026-10-08','2026-10-22',NULL),
(10,3,109,'2026-10-10','2026-10-24',NULL),
(11,8,108,'2026-10-12','2026-10-26','2026-10-20'),
(12,1,102,'2026-10-15','2026-10-29',NULL);


SELECT * FROM Member;
SELECT * FROM Book;
SELECT * FROM Issue;

SELECT title, author FROM Book WHERE category = 'Computer Science';

SELECT name, join_date FROM Member
WHERE join_date > '2026-05-01' ORDER BY join_date DESC;

SELECT title FROM Book WHERE title LIKE 'D%';

SELECT issue_id, issue_date FROM Issue
WHERE issue_date BETWEEN '2026-10-01' AND '2026-10-10';

SELECT title, copies_available FROM Book
WHERE category IN ('Biography','Poetry');

SELECT DISTINCT category FROM Book; 

SELECT COUNT(*) AS total_titles, SUM(copies_available) AS total_copies,
       AVG(copies_available) AS avg_copies,
       MAX(copies_available) AS max_copies, MIN(copies_available) AS min_copies
FROM Book;

SELECT category, COUNT(*) AS books FROM Book GROUP BY category; 

SELECT member_id, COUNT(*) AS total_borrowed FROM Issue 
GROUP BY member_id HAVING COUNT(*) > 1; 

SELECT m.name, b.title, i.due_date 
FROM Issue i 
JOIN Member m ON i.member_id = m.member_id 
JOIN Book b ON i.book_id = b.book_id 
WHERE i.return_date IS NULL; 

SELECT m.name FROM Member m 
LEFT JOIN Issue i ON m.member_id = i.member_id 
WHERE i.issue_id IS NULL; 

SELECT title FROM Book 
WHERE book_id NOT IN (SELECT book_id FROM Issue); 

SELECT title, copies_available FROM Book 
WHERE copies_available > (SELECT AVG(copies_available) FROM Book); 

SELECT i.issue_id, m.name, b.title, i.due_date 
FROM Issue i 
JOIN Member m ON i.member_id = m.member_id 
JOIN Book b ON i.book_id = b.book_id 
WHERE i.return_date IS NULL AND i.due_date < '2026-10-22'; 

SELECT b.title, COUNT(*) AS times_issued 
FROM Issue i JOIN Book b ON i.book_id = b.book_id 
GROUP BY b.title 
ORDER BY times_issued DESC, b.title 
LIMIT 3; 

SELECT title FROM Book WHERE copies_available <= 1 
UNION 
SELECT title FROM Book WHERE book_id NOT IN (SELECT book_id FROM Issue); 

UPDATE Issue SET return_date = '2026-10-22' WHERE issue_id = 4; 
SELECT issue_id, return_date FROM Issue WHERE issue_id = 4; 
SELECT   * FROM Issue;

UPDATE Book SET copies_available = copies_available + 1 WHERE book_id = 108; 
SELECT title, copies_available FROM Book WHERE book_id = 108; 
SELECT * FROM Book;

ALTER TABLE Member ADD COLUMN city VARCHAR(30);
SELECT * FROM Member; 

CREATE VIEW Currently_Borrowed AS 
SELECT m.name, b.title, i.due_date 
FROM Issue i 
JOIN Member m ON i.member_id = m.member_id 
JOIN Book b ON i.book_id = b.book_id 
WHERE i.return_date IS NULL;  
SELECT * FROM Currently_Borrowed; 

DELETE FROM Member WHERE member_id = 10; 
			