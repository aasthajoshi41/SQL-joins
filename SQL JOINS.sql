CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactEmail VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    SupplierID INT,
    Price DECIMAL(10, 2)
);
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactEmail VARCHAR(100)
);
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    ManagerID INT,
    DepartmentID INT,
    HireDate DATE,
    JobTitle VARCHAR(100),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    MentorID INT,
    FOREIGN KEY (MentorID) REFERENCES Students(StudentID)
);
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200),
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);
CREATE TABLE ProjectAssignments (
    AssignmentID INT PRIMARY KEY,
    ProjectID INT,
    EmployeeID INT,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Departments
INSERT INTO Departments VALUES (1, 'IT'), (2, 'HR');

-- Employees (with NULL for ManagerID initially to avoid circular FK)
INSERT INTO Employees VALUES 
(1, 'Alice Johnson', NULL, 1, '2015-03-15', 'CTO'),
(2, 'Bob Smith', 1, 1, '2017-06-22', 'Developer'),
(3, 'Carol White', 1, 2, '2018-08-10', 'HR Manager');

-- Students
INSERT INTO Students VALUES 
(1, 'John Doe', NULL), 
(2, 'Jane Smith', 1),
(3, 'Mike Brown', 1);

-- Courses
INSERT INTO Courses VALUES 
(1, 'Mathematics'),
(2, 'Physics');

-- Enrollments
INSERT INTO Enrollments VALUES 
(1, 2, 1, 'A'), 
(2, 3, 2, 'B');

-- Authors
INSERT INTO Authors VALUES 
(1, 'J.K. Rowling'), 
(2, 'George Orwell');

-- Books
INSERT INTO Books VALUES 
(1, 'Harry Potter', 1), 
(2, '1984', 2);

-- Categories
INSERT INTO Categories VALUES 
(1, 'Electronics'), 
(2, 'Books');

-- Suppliers
INSERT INTO Suppliers VALUES 
(1, 'Tech Supplies Co.', 'tech@supplies.com'),
(2, 'BookMart', 'books@mart.com');

-- Products
INSERT INTO Products VALUES 
(1, 'Laptop', 1, 1, 1200.00),
(2, 'Smartphone', 1, 1, 800.00),
(3, 'Book - 1984', 2, 2, 15.00);

-- Customers
INSERT INTO Customers VALUES 
(1, 'Alpha Corp', 'contact@alpha.com', 'New York', 'USA'),
(2, 'Beta LLC', 'info@beta.com', 'London', 'UK');

-- Orders
INSERT INTO Orders VALUES 
(1, '2024-12-01', 1, 1215.00),
(2, '2024-12-05', 2, 815.00);

-- OrderDetails
INSERT INTO OrderDetails VALUES 
(1, 1, 1, 1),   -- 1 Laptop
(2, 1, 3, 1),   -- 1 Book
(3, 2, 2, 1);   -- 1 Smartphone

-- Projects
INSERT INTO Projects VALUES 
(1, 'AI Development', 1),
(2, 'Website Redesign', 2);

-- ProjectAssignments
INSERT INTO ProjectAssignments VALUES 
(1, 1, 2),
(2, 2, 3);

SELECT * FROM Departments;
SELECT * FROM Employees;
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Categories;
SELECT * FROM Suppliers;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Projects;
SELECT * FROM ProjectAssignments;


--## 🔹 **Basic INNER JOIN (1–20)**

--1.Get the names of all employees and their department names.
SELECT * FROM Employees;
SELECT * FROM Departments;

SELECT E.EmployeeName, D.DepartmentName FROM Employees E
Join Departments D ON E.DepartmentID = D.DepartmentID;

--2. List all orders along with the names of the customers who placed them.

SELECT * FROM Orders;
SELECT * FROM Customers;

SELECT O.OrderID, C.CustomerName FROM Orders O
Join Customers C ON O.CustomerID = C.CustomerID;

--3. Show the product name and category name for all products.

SELECT * FROM Products;
SELECT * FROM Categories;

SELECT P.ProductName, C.CategoryName FROM Products P
Join Categories C ON P.CategoryID = C.CategoryID;

--4. List students and the courses they are enrolled in.

SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;

SELECT S.StudentName, C.CourseName FROM Enrollments E
JOIN Students S ON E.StudentID = S.StudentID
JOIN Courses C ON E.CourseID = C.CourseID;

--5. Retrieve book titles and author names.

SELECT * FROM Books;
SELECT * FROM Authors;

SELECT B.Title, A.AuthorName FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID;

--6. Show all invoices along with the customer’s name and country.

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE Invoice (
    invoice_id INT PRIMARY KEY,
    amount DECIMAL(10, 2),
    date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Customer VALUES 
(1, 'Alice Johnson', 'USA'),
(2, 'Raj Patel', 'India');

INSERT INTO Invoice VALUES 
(101, 299.99, '2025-03-01', 1),
(102, 150.00, '2025-03-05', 2);

SELECT * FROM Customer;
SELECT * FROM Invoice;

SELECT i.invoice_id, i.amount, i.date, c.name AS customer_name, c.country FROM Invoice i
JOIN Customer c ON i.customer_id = c.customer_id;

--7. Display all projects and their assigned manager names.

SELECT * FROM Projects;
SELECT * FROM ProjectAssignments;
SELECT * FROM Employees;

SELECT P.ProjectName, E.EmployeeName AS ManagerName FROM Projects P
JOIN Employees E ON P.ManagerID = E.EmployeeID;

--8. List all patients and their attending doctors.

CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialty VARCHAR(100)
);

CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    doctor_id INT,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

INSERT INTO Doctor VALUES 
(1, 'Dr. Smith', 'Cardiology'),
(2, 'Dr. Adams', 'Neurology');

INSERT INTO Patient VALUES 
(101, 'John Doe', 1),
(102, 'Jane Roe', 2);

SELECT * FROM Doctor;
SELECT * FROM Patient;

SELECT p.name AS patient_name, d.name AS doctor_name, d.specialty FROM Patient p
JOIN Doctor d ON p.doctor_id = d.doctor_id;


--9. Retrieve order details along with the corresponding product names.

SELECT * FROM OrderDetails;
SELECT * FROM Products;

SELECT OD.OrderDetailID, P.ProductName FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID;

--10. Get all employees with their job titles.

SELECT * FROM Employees;
SELECT EmployeeName, JobTitle FROM Employees;

--11. Show all sales along with salesperson names.

CREATE TABLE Salesperson (
    salesperson_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    amount DECIMAL(10, 2),
    date DATE,
    salesperson_id INT,
    FOREIGN KEY (salesperson_id) REFERENCES Salesperson(salesperson_id)
);

INSERT INTO Salesperson VALUES 
(1, 'Alice'),
(2, 'Bob');

INSERT INTO Sales VALUES 
(101, 500.00, '2025-01-01', 1),
(102, 700.00, '2025-01-02', 2);

SELECT * FROM Salesperson;
SELECT * FROM Sales;

SELECT s.sale_id, s.amount, sp.name FROM Sales s 
JOIN Salesperson sp ON s.salesperson_id = sp.salesperson_id;

--12. Get all transactions and the bank branch they occurred in.

CREATE TABLE Branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    amount DECIMAL(10, 2),
    branch_id INT,
    date DATE,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

INSERT INTO Branch VALUES 
(1, 'Downtown'),
(2, 'Uptown');

INSERT INTO Transactions VALUES 
(1001, 250.00, 1, '2025-04-01'),
(1002, 400.00, 2, '2025-04-02');

SELECT * FROM Branch;
SELECT * FROM Transactions;

SELECT t.transaction_id, t.amount, b.branch_name FROM Transactions t 
JOIN Branch b ON t.branch_id = b.branch_id;

--13. List all vehicles and their owners.

CREATE TABLE Owners (
    owners_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Vehicle (
    vehicle_id INT PRIMARY KEY,
    model VARCHAR(100),
    owners_id INT,
    FOREIGN KEY (owners_id) REFERENCES Owners(owners_id)
);

INSERT INTO Owners VALUES 
(1, 'David'),
(2, 'Emma');

INSERT INTO Vehicle VALUES 
(501, 'Toyota Camry', 1),
(502, 'Honda Civic', 2);

SELECT * FROM Owners;
SELECT * FROM Vehicle;

SELECT v.vehicle_id, v.model, o.name FROM Vehicle v 
JOIN Owners o ON v.owners_id = o.owners_id;

--14. Show all classes with their teachers.

CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Class (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

INSERT INTO Teacher VALUES 
(1, 'Mrs. Smith'),
(2, 'Mr. Johnson');

INSERT INTO Class VALUES 
(101, 'Math', 1),
(102, 'Science', 2);

SELECT * FROM Teacher;
SELECT * FROM Class;

SELECT c.class_name, t.name FROM Class c 
JOIN Teacher t ON c.teacher_id = t.teacher_id;

--15. Get all movie names and their directors.

CREATE TABLE Director (
    director_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Movie (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    director_id INT,
    FOREIGN KEY (director_id) REFERENCES Director(director_id)
);

INSERT INTO Director VALUES 
(1, 'Christopher Nolan'),
(2, 'Steven Spielberg');

INSERT INTO Movie VALUES 
(201, 'Inception', 1),
(202, 'Jurassic Park', 2);

SELECT * FROM Director;
SELECT * FROM Movie;

SELECT m.title, d.name FROM Movie m 
JOIN Director d ON m.director_id = d.director_id;

--16. List all athletes with their respective teams.

CREATE TABLE Team (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100)
);

CREATE TABLE Athlete (
    athlete_id INT PRIMARY KEY,
    name VARCHAR(100),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);

INSERT INTO Team VALUES 
(1, 'Team A'),
(2, 'Team B');

INSERT INTO Athlete VALUES 
(301, 'Usain Bolt', 1),
(302, 'Michael Phelps', 2);

SELECT * FROM Team;
SELECT * FROM Athlete;

SELECT a.name, t.team_name FROM Athlete a 
JOIN Team t ON a.team_id = t.team_id;

--17. Show products and their suppliers.

SELECT * FROM Products;
SELECT * FROM Suppliers;

SELECT P.ProductName, S.SupplierName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID;

--18. List blog posts with their respective authors.

CREATE TABLE Author (
    author_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE BlogPost (
    post_id INT PRIMARY KEY,
    title VARCHAR(100),
    content TEXT,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

INSERT INTO Author VALUES 
(1, 'John Doe'),
(2, 'Jane Smith');

INSERT INTO BlogPost VALUES 
(101, 'Intro to SQL', 'This is a SQL tutorial.', 1),
(102, 'Advanced Python', 'Decorators and generators explained.', 2)

SELECT * FROM BlogPost;
SELECT * FROM Author;

SELECT b.title, a.name FROM BlogPost b 
JOIN Author a ON b.author_id = a.author_id;

--19. Show employees and the location of their offices.

CREATE TABLE Office (
    office_id INT PRIMARY KEY,
    location VARCHAR(100)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    office_id INT,
    FOREIGN KEY (office_id) REFERENCES Office(office_id)
);

INSERT INTO Office VALUES 
(1, 'New York'),
(2, 'San Francisco');

INSERT INTO Employee VALUES 
(1, 'Alice', 1),
(2, 'Bob', 2);

SELECT * FROM Office;
SELECT * FROM Employee;

SELECT e.name, o.location FROM Employee e 
JOIN Office o ON e.office_id = o.office_id;

--20. Display all items in a shopping cart with product descriptions.

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

CREATE TABLE ShoppingCart (
    cart_item_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Product VALUES 
(1, 'Laptop', '14-inch screen, 8GB RAM'),
(2, 'Mouse', 'Wireless optical mouse');

INSERT INTO ShoppingCart VALUES 
(1, 1, 1),
(2, 2, 2);

SELECT * FROM ShoppingCart;
SELECT * FROM Product;

SELECT p.name, p.description, s.quantity FROM ShoppingCart s 
JOIN Product p ON s.product_id = p.product_id;





--## 🔹 **LEFT JOIN (21–40)**

--21. List all customers, even those who haven’t placed orders.

SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT c.CustomerName, o.OrderID, o.TotalAmount FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

--22. Get all products and their order quantities (even if never ordered).

SELECT * FROM Products;
SELECT * FROM OrderDetails;

SELECT p.ProductName, oi.Quantity FROM Products p
LEFT JOIN OrderDetails oi ON p.ProductID = oi.ProductID;

--23. Show all students and the grades they've received (if any).

SELECT * FROM students;
SELECT * FROM Student;

SELECT Name, Grade FROM Student;

--24. List all employees and their assigned projects (if any).

SELECT * FROM Employees;
--SELECT * FROM Employee;
SELECT * FROM Projects;
--SELECT * FROM ProjectAssignments;

SELECT e.EmployeeName, p.ProjectName FROM Employees e
LEFT JOIN Projects p ON e.ManagerID = p.ManagerID;

--25. Show all departments and their employees (if any).

SELECT * FROM Employees;
SELECT * FROM Departments;

SELECT D.DepartmentName, E.EmployeeName FROM Departments D
LEFT JOIN Employees E ON D.DepartmentID = E.DepartmentID;

--26. Display all articles and any comments (if any).





--27. List all books, even those without an author (null author\_id).

SELECT * FROM Authors;
SELECT * FROM Books;

SELECT b.BookID, b.Title, a.AuthorName FROM Books b
LEFT JOIN Authors a ON b.AuthorID = a.AuthorID;

--28. Show all courses, including those with no enrollments.

SELECT * FROM Courses;
SELECT * FROM Enrollments;

SELECT C.CourseName, E.EnrollmentID FROM Courses C
LEFT JOIN Enrollments E ON C.CourseID = E.CourseID;

--29. Get all users and their last login time (if logged in).





--30. List all patients, even if no appointment is scheduled.

CREATE TABLE appointments (
  id INT IDENTITY(1,1) PRIMARY KEY,
  patient_id INT,
  appointment_date DATE,
  doctor_name VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

INSERT INTO appointments VALUES 
(101, '2025-05-06', 'Dr. Smith'),
(102, '2025-05-07', 'Dr. Johnson');

SELECT * FROM Patient;
SELECT * FROM appointments;

SELECT p.name, a.appointment_date FROM Patient p
LEFT JOIN appointments a ON p.patient_id = a.patient_id; 

--31. Show all teachers, even if they are not teaching any class.

SELECT * FROM Teacher;
SELECT * FROM Class;

SELECT T.name, C.class_name FROM Teacher T
LEFT JOIN Class C ON T.teacher_id = C.teacher_id; 

--32. List all cars, even those not assigned to any customer.

CREATE TABLE cars (
  car_id INT IDENTITY(1,1) PRIMARY KEY, 
  car_name VARCHAR(255),                 
  customer_id INT,                     
  FOREIGN KEY (customer_id) REFERENCES customers(CustomerID) 
);

INSERT INTO cars VALUES 
('Toyota Corolla', 1),
('Honda Civic', 2),
('Ford Mustang', NULL);

SELECT * FROM Customers;
SELECT * FROM cars;

SELECT C.car_name, CU.CustomerName FROM cars C
LEFT JOIN Customers CU ON C.customer_id = CU.CustomerID; 

--33. Get all songs and their album names (even if not in any album).

CREATE TABLE albums (
  album_id INT IDENTITY(1,1) PRIMARY KEY,
  album_name VARCHAR(255)
);

CREATE TABLE songs (
  song_id INT IDENTITY(1,1) PRIMARY KEY,
  song_name VARCHAR(255),
  album_id INT NULL,
  FOREIGN KEY (album_id) REFERENCES albums(album_id)
);

INSERT INTO albums (album_name) VALUES
('Album A'),
('Album B');

INSERT INTO songs (song_name, album_id) VALUES
('Song 1', 1),
('Song 2', 1),
('Song 3', 2),
('Song 4', NULL);  

SELECT * FROM albums;
SELECT * FROM songs;

SELECT s.song_id, s.song_name, a.album_name FROM songs s
LEFT JOIN albums a ON s.album_id = a.album_id;

--34. Show all houses and the tenants living there (if any).

CREATE TABLE houses (
  house_id INT IDENTITY(1,1) PRIMARY KEY,
  address VARCHAR(255)
);

CREATE TABLE tenants (
  tenant_id INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255),
  house_id INT NULL,
  FOREIGN KEY (house_id) REFERENCES houses(house_id)
);

INSERT INTO houses (address) VALUES
('123 Maple St'),
('456 Oak Ave'),
('789 Pine Rd');

INSERT INTO tenants (name, house_id) VALUES
('Alice', 1),
('Bob', 1),
('Charlie', 2);

SELECT * FROM houses;
SELECT * FROM tenants;

SELECT h.house_id, h.address, t.tenant_id, t.name AS tenant_name FROM houses h
LEFT JOIN tenants t ON h.house_id = t.house_id;

--35. List all posts and the number of likes (even if zero).

CREATE TABLE posts (
  post_id INT IDENTITY(1,1) PRIMARY KEY,
  post_title VARCHAR(255)
);

CREATE TABLE likes (
  like_id INT IDENTITY(1,1) PRIMARY KEY,
  post_id INT NOT NULL,
  FOREIGN KEY (post_id) REFERENCES posts(post_id)
);

INSERT INTO posts (post_title) VALUES
('First Post'),
('Second Post'),
('Third Post');

INSERT INTO likes (post_id) VALUES
(1),
(1),
(2);

SELECT * FROM posts;
SELECT * FROM likes;

SELECT p.post_id, p.post_title, COUNT(l.like_id) AS like_count FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id, p.post_title;


--36. Get all employees and their emergency contact details (if any).

CREATE TABLE EmergencyContacts (
    ContactID INT PRIMARY KEY,
    EmployeeID INT,
    ContactName VARCHAR(100),
    Relationship VARCHAR(50),
    PhoneNumber VARCHAR(20),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO EmergencyContacts (ContactID, EmployeeID, ContactName, Relationship, PhoneNumber) VALUES
(1, 1, 'Eve', 'Spouse', '1234567890'),
(2, 2, 'Frank', 'Brother', '9876543210'),
(3, 3, 'Grace', 'Friend', '5551234567');

SELECT * FROM Employees;
SELECT * FROM EmergencyContacts;

SELECT e.EmployeeID,e.EmployeeName, ec.ContactName,ec.PhoneNumber FROM Employees e
LEFT JOIN EmergencyContacts ec ON e.EmployeeID = ec.EmployeeID;

--37. Display all branches and their ATM machines (if any).

CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    Location VARCHAR(100)
);

CREATE TABLE ATMs (
    ATMID INT PRIMARY KEY,
    BranchID INT,
    ATMType VARCHAR(50),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

INSERT INTO Branches VALUES
(1, 'Main Branch', 'Downtown'),
(2, 'West Branch', 'West City'),
(3, 'North Branch', 'North Avenue');

INSERT INTO ATMs VALUES
(101, 1, 'Cash Deposit'),
(102, 1, 'Cash Withdrawal'),
(103, 2, 'Multi-function');

SELECT * FROM Branches;
SELECT * FROM ATMs;

SELECT b.BranchID, b.BranchName, a.ATMID,a.ATMType FROM Branches b
LEFT JOIN ATMs a ON b.BranchID = a.BranchID;

--38. List all schools and their principals (even if no principal assigned).

CREATE TABLE Schools (
    SchoolID INT PRIMARY KEY,
    SchoolName VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Principals (
    PrincipalID INT PRIMARY KEY,
    SchoolID INT,
    PrincipalName VARCHAR(100),
    FOREIGN KEY (SchoolID) REFERENCES Schools(SchoolID)
);

INSERT INTO Schools VALUES
(1, 'Green Valley High', 'New York'),
(2, 'Sunrise Academy', 'Los Angeles'),
(3, 'Maple Leaf School', 'Chicago');

INSERT INTO Principals VALUES
(1, 1, 'Mr. John Smith'),
(2, 2, 'Mrs. Linda Green');

SELECT * FROM Schools;
SELECT * FROM Principals;

SELECT S.SchoolName, P.PrincipalName FROM Schools S
LEFT JOIN Principals P ON S.SchoolID = P.SchoolID;

--39. Get all flights and the corresponding pilots (if any).

CREATE TABLE Flights (
    FlightID INT PRIMARY KEY,
    FlightNumber VARCHAR(50),
    Destination VARCHAR(100)
);

CREATE TABLE Pilots (
    PilotID INT PRIMARY KEY,
    FlightID INT,
    PilotName VARCHAR(100),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

INSERT INTO Flights VALUES
(1, 'AI101', 'New Delhi'),
(2, 'BA202', 'London'),
(3, 'DL303', 'New York');

INSERT INTO Pilots VALUES
(1, 1, 'Captain Raj'),
(2, 2, 'Captain Smith');

SELECT * FROM Flights;
SELECT * FROM Pilots;

SELECT F.FlightNumber, P.PilotName FROM Flights F
LEFT JOIN Pilots P ON F.FlightID = P.FlightID;

--40. Show all resumes and job applications linked to them (if any).

CREATE TABLE Resumes (
    ResumeID INT PRIMARY KEY,
    CandidateName VARCHAR(100),
    Skills VARCHAR(255)
);

CREATE TABLE JobApplications (
    ApplicationID INT PRIMARY KEY,
    ResumeID INT,
    JobTitle VARCHAR(100),
    CompanyName VARCHAR(100),
    FOREIGN KEY (ResumeID) REFERENCES Resumes(ResumeID)
);

INSERT INTO Resumes VALUES
(1, 'Amit Sharma', 'Python, SQL, ML'),
(2, 'Neha Patel', 'Java, Spring'),
(3, 'John Doe', 'React, Node.js');

INSERT INTO JobApplications VALUES
(1, 1, 'Data Scientist', 'TechCorp'),
(2, 1, 'ML Engineer', 'InnoSoft'),
(3, 3, 'Frontend Dev', 'WebSolutions');

SELECT * FROM Resumes;
SELECT * FROM JobApplications;

SELECT R.ResumeID, R.CandidateName, J.JobTitle FROM Resumes R
LEFT JOIN JobApplications J ON R.ResumeID = J.ResumeID;






--## 🔹 **RIGHT JOIN (41–55)**

--41. Get all orders, including those without customer info.

SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT o.OrderID, o.OrderDate,c.CustomerName FROM  Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;


--42. Show all departments and employees assigned (even if none).

SELECT * FROM Departments;
SELECT * FROM Employees;

SELECT d.DepartmentID,d.DepartmentName,e.EmployeeName FROM Employees e
RIGHT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

--43. List all job postings and the applicants (even if no one applied).

CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    JobTitle VARCHAR(100)
);

CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    JobID INT,
    ApplicantName VARCHAR(100),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID)
);

INSERT INTO Jobs VALUES
(1, 'Software Engineer'), (2, 'Data Analyst'), (3, 'UI Designer');

INSERT INTO Applications VALUES
(201, 1, 'Anita'), (202, 2, 'Ravi');

SELECT * FROM Jobs;
SELECT * FROM Applications;

SELECT j.JobTitle, a.ApplicantName FROM  Applications a
RIGHT JOIN Jobs j ON a.JobID = j.JobID;

--44. Show all songs and artists (even if song is missing artist info).

CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    ArtistName VARCHAR(100)
);

CREATE TABLE music (
    SongID INT PRIMARY KEY,
    Title VARCHAR(100),
    ArtistID INT,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

INSERT INTO Artists VALUES
(1, 'Taylor Swift'), (2, 'Ed Sheeran');

INSERT INTO music VALUES
(301, 'Love Story', 1),
(302, 'Shape of You', 2),
(303, 'Unknown Song', NULL);  

SELECT * FROM Artists;
SELECT * FROM music;

SELECT m.Title,a.ArtistName FROM Artists a
RIGHT JOIN music m ON a.ArtistID = m.ArtistID;

--45. Display all bank branches and employees (even if branch has no staff).



--46. Get all flights and airports they depart from (even if flight data is missing).

CREATE TABLE Airports (
    AirportID INT PRIMARY KEY,
    AirportName VARCHAR(100)
);

INSERT INTO Airports VALUES
(1, 'Heathrow'), (2, 'JFK'), (3, 'Dubai Intl');

ALTER TABLE Flights
ADD AirportID INT;

UPDATE Flights
SET AirportID = 1
WHERE FlightID = 3;

UPDATE Flights
SET AirportID = 2
WHERE FlightID = 1;

UPDATE Flights
SET AirportID = 3
WHERE FlightID = 2;


SELECT * FROM Airports;
SELECT * FROM Flights;

SELECT f.FlightNumber,a.AirportName FROM Airports a
RIGHT JOIN Flights f ON a.AirportID = f.AirportID;

--47. List all stores and the inventory they hold (even if store is empty).

CREATE TABLE Stores (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100)
);

CREATE TABLE Inventory (
    ItemID INT PRIMARY KEY,
    StoreID INT,
    ItemName VARCHAR(100),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

INSERT INTO Stores VALUES
(1, 'ElectroMart'), (2, 'GroceryWorld');

INSERT INTO Inventory VALUES
(601, 1, 'Laptop'),
(602, 1, 'Smartphone');

SELECT * FROM Stores;
SELECT * FROM Inventory;

SELECT s.StoreName, i.ItemName FROM Inventory i
RIGHT JOIN Stores s ON i.StoreID = s.StoreID;

--48. Show all sports teams and their players (even if team has no players).

CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    PlayerName VARCHAR(100),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);

INSERT INTO Players VALUES
(701, 'Leo', 1),
(702, 'Max', 2);

SELECT * FROM Team;
SELECT * FROM Players;

SELECT t.team_name,p.PlayerName FROM Players p
RIGHT JOIN Team t ON p.team_id = t.team_id;

--49. List all invoices and the payments made (even if unpaid).

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    InvoiceID INT,
    PaymentAmount DECIMAL(10,2),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(invoice_id)
);

INSERT INTO Payments VALUES
(801, 101, 500.00),
(802, 102, 750.00),
(803, 103, 850.00);
;

INSERT INTO Invoice VALUES 
(103, 599.99, '2025-03-06', 2);

SELECT * FROM Invoice;
SELECT * FROM Payments;

SELECT i.invoice_id, p.PaymentAmount FROM Payments p
RIGHT JOIN Invoice i ON p.InvoiceID = i.invoice_id;

--50. Show all orders and shipping details (even if not shipped).

CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY,
    OrderID INT,
    ShippingDate DATE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Shipping VALUES
(901, 1, '2025-05-04'),
(902, 2, '2025-05-05');

SELECT * FROM Orders;
SELECT * FROM Shipping;

SELECT o.OrderID, o.OrderDate, s.ShippingDate FROM Shipping s
RIGHT JOIN Orders o ON s.OrderID = o.OrderID;

--51. Get all rental properties and tenants (even if vacant).

CREATE TABLE Properties (
  PropertyID INT PRIMARY KEY,
  Address VARCHAR(255),
  tenant_id INT,
  FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);

INSERT INTO Properties VALUES
(101, '12 Oak Street', 1),
(102, '45 Pine Avenue', NULL),
(103, '78 Maple Road', 2);

SELECT * FROM Tenants;
SELECT * FROM Properties;

SELECT p.PropertyID, p.Address, t.name
FROM Tenants t
RIGHT JOIN Properties p ON t.tenant_id = p.tenant_id;

--52. List all service centers and the vehicles serviced (even if none).

CREATE TABLE ServiceCenters (
  CenterID INT PRIMARY KEY,
  CenterName VARCHAR(100)
);

INSERT INTO ServiceCenters VALUES
(1, 'QuickFix'),
(2, 'AutoCare'),
(3, 'SpeedyServ');

ALTER TABLE Vehicle
ADD CenterID INT;

UPDATE Vehicle
SET CenterID = 1
WHERE vehicle_id = 501;

UPDATE Vehicle
SET CenterID = 2
WHERE vehicle_id = 502;

SELECT * FROM ServiceCenters;
SELECT * FROM Vehicle;

SELECT v.vehicle_id, v.model, s.CenterName
FROM Vehicle v
RIGHT JOIN ServiceCenters s ON v.CenterID = s.CenterID;

--53. Show all products and the vendors supplying them (even if unsupplied).

CREATE TABLE Vendors (
  VendorID INT PRIMARY KEY,
  VendorName VARCHAR(100)
);

INSERT INTO Vendors VALUES
(1, 'Global Supplies'),
(2, 'TechSource'),
(3, 'OfficeMart');

ALTER TABLE Products
ADD VendorID INT;

UPDATE Products
SET VendorID = 1
WHERE ProductID = 2;

UPDATE Products
SET VendorID = 2
WHERE ProductID = 3;

UPDATE Products
SET VendorID = 3
WHERE ProductID = 1;

SELECT * FROM Vendors;
SELECT * FROM Products;

SELECT v.VendorName, p.ProductName FROM Vendors v
RIGHT JOIN Products p ON v.VendorID = p.VendorID;

--54. Display all training sessions and attendees (even if session is empty).

CREATE TABLE Attendees (
  AttendeeID INT PRIMARY KEY,
  AttendeeName VARCHAR(100)
);

CREATE TABLE Sessions (
  SessionID INT PRIMARY KEY,
  Topic VARCHAR(100),
  AttendeeID INT,
  FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

INSERT INTO Attendees VALUES
(1, 'John'),
(2, 'Emma'),
(3, 'Liam');

INSERT INTO Sessions VALUES
(501, 'SQL Basics', 1),
(502, 'Advanced Python', NULL),
(503, 'Data Analysis', 2);

SELECT * FROM Attendees;
SELECT * FROM Sessions;

SELECT a.AttendeeName, s.Topic FROM Attendees a
RIGHT JOIN Sessions s ON a.AttendeeID = s.AttendeeID;

--55. Get all users and their transactions (even if they made none).

CREATE TABLE Users (
  UserID INT PRIMARY KEY,
  UserName VARCHAR(100)
);

INSERT INTO Users VALUES
(1, 'David'),
(2, 'Sophia'),
(3, 'Chris');

ALTER TABLE Transactions
ADD UserID INT;

UPDATE Transactions
SET UserID = 1
WHERE transaction_id = 1001;

UPDATE Transactions
SET UserID = 2
WHERE transaction_id = 1002;

SELECT * FROM Users;
SELECT * FROM Transactions;

SELECT t.transaction_id, t.Amount, u.UserName
FROM Transactions t
RIGHT JOIN Users u ON t.UserID = u.UserID;






--## 🔹 **FULL OUTER JOIN (56–70)**

--56. List all employees and their managers (even if no relation exists).

SELECT * FROM Employees;

SELECT e.EmployeeID AS EmployeeID,e.EmployeeName AS EmployeeName,m.EmployeeName AS ManagerName FROM Employees e
FULL OUTER JOIN Employees m ON e.ManagerID = m.EmployeeID;

--57. Get all books and authors (even if unmatched).

SELECT * FROM Authors;
SELECT * FROM Books;

SELECT b.Title, a.AuthorName FROM Books b
FULL OUTER JOIN Authors a ON b.AuthorID = a.AuthorID;

--58. Display all customers and orders (even if either is missing).

SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT c.CustomerName,o.OrderID,o.TotalAmount FROM Customers c
FULL OUTER JOIN Orders o ON c.CustomerID = o.CustomerID;

--59. Show all students and classes (even if not enrolled).

ALTER TABLE Class
ADD StudentID INT;

UPDATE Class
SET StudentID = 1
WHERE class_id = 101;

UPDATE Class
SET StudentID = 3
WHERE class_id = 102;

SELECT * FROM Students;
SELECT * FROM Class;

SELECT 
  s.StudentName,
  c.class_name
FROM Students s
FULL OUTER JOIN Class c ON s.StudentID = c.StudentID;

--60. Get all products and their reviews (even if not reviewed).

CREATE TABLE Reviews (
  ReviewID INT PRIMARY KEY,
  ProductID INT,
  Rating INT
);

INSERT INTO Reviews VALUES
(101, 1, 5),
(102, 1, 4),
(103, 4, 3); 

SELECT * FROM Products;
SELECT * FROM Reviews;

SELECT   p.ProductID, p.ProductName, r.Rating FROM Products p
FULL OUTER JOIN Reviews r ON p.ProductID = r.ProductID;

--61. List all applications and applicants (even if unlinked).

CREATE TABLE Applicants (
  applicant_id INT PRIMARY KEY,
  applicant_name VARCHAR(100)
);

INSERT INTO Applicants VALUES 
(1, 'Alice'), 
(2, 'Bob'), 
(3, 'Charlie');

ALTER TABLE Applications
ADD applicant_id INT;

UPDATE Applications
SET applicant_id = 1
WHERE ApplicationID = 201;

UPDATE Applications
SET applicant_id = 2
WHERE ApplicationID = 202;

SELECT * FROM Applications;
SELECT * FROM Applicants;

SELECT a.ApplicationID, ap.applicant_name
FROM Applications a
FULL OUTER JOIN Applicants ap
ON a.applicant_id = ap.applicant_id;


--62. Show all users and their profile pictures (even if missing).

CREATE TABLE ProfilePictures (
  picture_id INT PRIMARY KEY,
  user_id INT,
  picture_url VARCHAR(200),
  FOREIGN KEY (user_id) REFERENCES Users(UserID)
);

INSERT INTO ProfilePictures VALUES 
(201, 1, 'pic1.jpg'),
(202, 2, 'pic2.jpg');

SELECT * FROM Users;
SELECT * FROM ProfilePictures;

SELECT u.username, p.picture_url FROM Users u
FULL OUTER JOIN ProfilePictures p ON u.UserID = p.user_id;

--63. List all volunteers and events (even if not linked).

CREATE TABLE Volunteers (
  volunteer_id INT PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE Events (
  event_id INT PRIMARY KEY,
  volunteer_id INT,
  event_name VARCHAR(100),
  FOREIGN KEY (volunteer_id) REFERENCES Volunteers(volunteer_id)
);

INSERT INTO Volunteers VALUES 
(1, 'John'), 
(2, 'Sara');

INSERT INTO Events VALUES 
(301, 1, 'Charity Run'), 
(302, NULL, 'Beach Cleanup');

SELECT * FROM Events;
SELECT * FROM Volunteers;

SELECT v.name AS volunteer_name, e.event_name FROM Volunteers v
FULL OUTER JOIN Events e ON v.volunteer_id = e.volunteer_id;

--64. Display all assets and owners (even if unassigned).

CREATE TABLE Assets (
  asset_id INT PRIMARY KEY,
  asset_name VARCHAR(100),
  owners_id INT,
  FOREIGN KEY (owners_id) REFERENCES Owners(owners_id)
);

INSERT INTO Assets VALUES 
(401, 'Laptop', 1), 
(402, 'Printer', NULL);

SELECT * FROM Owners;
SELECT * FROM Assets;

SELECT a.asset_name, o.name FROM Assets a
FULL OUTER JOIN Owners o ON a.owners_id = o.owners_id;

--65. Show all job titles and employees (even if no one holds the title).

ALTER TABLE Employees
ADD JobID INT;

UPDATE Employees
SET JobID = 1
WHERE EmployeeID = 1;

UPDATE Employees
SET JobID = 2
WHERE EmployeeID = 2;

UPDATE Employees
SET JobID = 3
WHERE EmployeeID = 3;

SELECT * FROM Jobs;
SELECT * FROM Employees;

SELECT jt.JobTitle, e.EmployeeName FROM Jobs jt
FULL OUTER JOIN Employees e ON jt.JobID = e.JobID;

--66. Get all cities and their airports (even if no airport).

CREATE TABLE cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100)
);

INSERT INTO cities VALUES
(1, 'New York'),
(2, 'Los Angeles'),
(3, 'Chicago'),
(4, 'Houston');

ALTER TABLE Airports
ADD city_id INT;

UPDATE Airports
SET city_id = 2
WHERE AirportID = 1;

UPDATE Airports
SET city_id = 1
WHERE AirportID = 2;

UPDATE Airports
SET city_id = 3
WHERE AirportID = 3;

SELECT * FROM Airports;
SELECT * FROM cities;

SELECT c.city_name, a.AirportName FROM cities c
FULL OUTER JOIN airports a ON c.city_id = a.city_id;

--67. List all software and licenses (even if unused).

CREATE TABLE software (
    software_id INT PRIMARY KEY,
    software_name VARCHAR(100)
);

CREATE TABLE licenses (
    license_id INT PRIMARY KEY,
    license_key VARCHAR(100),
    software_id INT,
    FOREIGN KEY (software_id) REFERENCES software(software_id)
);

INSERT INTO software VALUES
(1, 'Microsoft Office'),
(2, 'Adobe Photoshop'),
(3, 'Visual Studio');

INSERT INTO licenses VALUES
(201, 'XYZ-123-AAA', 1),
(202, 'ABC-456-BBB', 1),
(203, 'DEF-789-CCC', 2);

SELECT * FROM software;
SELECT * FROM licenses;

SELECT s.software_name,l.license_key FROM software s
FULL OUTER JOIN licenses l ON s.software_id = l.software_id;

--68. Show all classes and schedules (even if one is missing).

CREATE TABLE schedules (
    schedule_id INT PRIMARY KEY,
    class_id INT,
    schedule_time TIME,
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
);

INSERT INTO schedules VALUES
(1, 101, '09:00:00'),
(2, 102, '11:00:00');

SELECT * FROM Class;
SELECT * FROM schedules;

SELECT c.class_name, s.schedule_time FROM class c
FULL OUTER JOIN schedules s ON c.class_id = s.class_id;

--69. List all banks and customers (even if no link).

CREATE TABLE banks (
    bank_id INT PRIMARY KEY,
    bank_name VARCHAR(100)
);

INSERT INTO banks VALUES
(1, 'Bank of America'),
(2, 'Chase'),
(3, 'Wells Fargo');

ALTER TABLE Customer
ADD bank_id INT;

UPDATE Customer
SET bank_id = 1
WHERE customer_id = 1;

UPDATE Customer
SET bank_id = 2
WHERE customer_id = 2;

SELECT * FROM Customer;
SELECT * FROM banks;

SELECT b.bank_name, c.name FROM banks b
FULL OUTER JOIN customer c ON b.bank_id = c.bank_id;

--70. Display all employees and badges (even if missing).

CREATE TABLE badges (
    badge_id INT PRIMARY KEY,
    badge_number VARCHAR(100),
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

INSERT INTO badges VALUES
(301, 'B123', 1),
(302, 'B456', 2);

SELECT * FROM Employee;
SELECT * FROM badges;

SELECT e.name, b.badge_number FROM employee e
FULL OUTER JOIN badges b ON e.emp_id = b.emp_id;






--## 🔹 **SELF JOIN (71–80)**

--71. Find all employees who report to someone (supervisor).

SELECT * FROM Employees;

SELECT 
    e.EmployeeName AS Employee,
    m.EmployeeName AS Manager
FROM 
    Employees e
JOIN 
    Employees m ON e.DepartmentID = m.EmployeeID;

--72. List employees and their managers' names.

SELECT * FROM Employees;

SELECT 
    e1.EmployeeName AS employee,
    e2.EmployeeName AS Manager
FROM 
    Employees e1
JOIN 
    Employees e2 
ON 
    e1.DepartmentID = e2.EmployeeID ;

--73. Find all products that are substitutes of other products.

SELECT * FROM Products;

SELECT 
    p.ProductName AS Product,
    s.ProductName AS Substitute
FROM 
    products p
JOIN 
    products s ON p.SupplierID = s.ProductID;


--74. List students and their mentors (who are also students).

SELECT * FROM Students;

SELECT 
    s1.StudentName AS student,
    s2.StudentName AS mentor
FROM 
    Students s1
JOIN 
    Students s2 
ON 
    s1.MentorID = s2.StudentID ;

--75. Find users who referred other users.

ALTER TABLE Users 
ADD referred_by INT;

UPDATE Users
SET referred_by = 1
WHERE USERID = 1;

UPDATE Users
SET referred_by = 3
WHERE USERID = 2;

UPDATE Users
SET referred_by = 2
WHERE USERID = 3;

SELECT * FROM Users;

SELECT 
    u1.UserName AS Referrer
FROM 
    users u1
JOIN 
    users u2 ON u1.UserID = u2.referred_by;

--76. Display a list of employees with the same job title.

SELECT * FROM Employees;

SELECT 
    e1.EmployeeName AS emp1,
    e2.EmployeeName AS emp2,
    e1.JobTitle
FROM 
    Employees e1
JOIN 
    Employees e2 
ON 
    e1.JobTitle = e2.JobTitle AND e1.EmployeeID < e2.EmployeeID;

--77. Find customers who live in the same city.

SELECT * FROM Customers;

SELECT 
    c1.CustomerName AS cus1,
    c2.CustomerName AS cus2,
    c1.City
FROM 
    Customers c1
JOIN 
    Customers c2 
ON 
    c1.City = c2.City AND c1.CustomerID < c2.CustomerID;

--78. List products with the same price.

SELECT * FROM Products;

SELECT 
    p1.ProductName AS product1,
    p2.ProductName AS product2,
    p1.price
FROM 
    Products p1
JOIN 
    Products p2 
ON 
    p1.price = p2.price AND p1.ProductID < p2.ProductID;

--79. Find employees working in the same department.

SELECT * FROM Employees;

SELECT 
    e1.EmployeeName AS Employee1,
    e2.EmployeeName AS Employee2,
    e1.DepartmentID
FROM 
    Employees e1
JOIN 
    Employees e2 
ON 
    e1.DepartmentID = e2.DepartmentID AND e1.EmployeeID < e2.EmployeeID;

--80. Display employees with the same hire date.

SELECT * FROM Employees;

SELECT 
    e1.EmployeeName AS Employee1,
    e2.EmployeeName AS Employee2,
    e1.HireDate
FROM 
    Employees e1
JOIN 
    Employees e2 
ON 
    e1.HireDate = e2.HireDate AND e1.EmployeeID < e2.EmployeeID;






--## 🔹 **Advanced Join Practice (81–100)**

--81. Get the top 3 customers with most orders using JOIN.

SELECT * FROM Orders;
SELECT * FROM Customer;

SELECT TOP 3
    c.customer_id,
    c.name,
    COUNT(o.OrderID) AS total_orders
FROM 
    Customer c
JOIN 
    Orders o ON c.customer_id = o.CustomerID
GROUP BY 
    c.customer_id, c.name;

--82. List each department with the number of employees.

SELECT * FROM Employees;

SELECT DepartmentID, COUNT(*) AS employee_count FROM Employees
GROUP BY DepartmentID;

--83. Show total sales by product category.

ALTER TABLE Sales 
ADD ProductID INT;

ALTER TABLE Sales 
ADD Quantity INT;

UPDATE Sales
SET ProductID = 1 , Quantity = 2
WHERE sale_id = 101;

UPDATE Sales
SET ProductID = 2, Quantity = 1
WHERE sale_id = 102;

SELECT * FROM Sales;
SELECT * FROM Products;
SELECT * FROM Categories;

SELECT
	C.CategoryName,
	 SUM (P.Price * S.Quantity) AS total_sales
FROM 
	Sales S
JOIN
	Products P ON S.ProductID = P.ProductID
JOIN
	Categories C ON P.CategoryID = C.CategoryID
GROUP BY 
    C.CategoryName;

--84. Find the most expensive product in each category.

SELECT * FROM Categories;
SELECT * FROM Products;

SELECT 
   C.CategoryName,C.CategoryID, P.Price,
   P.ProductName AS expensive_product
FROM 
    Products P
JOIN 
    Categories C ON P.CategoryID = C.CategoryID
WHERE 
   P.Price = (
       SELECT MAX(P2.Price)
       FROM Products P2
       WHERE P2.CategoryID = P.CategoryID );

--85. Get all orders with product names and total price.

SELECT * FROM OrderDetails;
SELECT * FROM Products;

SELECT 
	o.OrderID, P.ProductName, o.Quantity, 
	(o.Quantity * p.Price) AS TotalPrice
FROM
	OrderDetails o
JOIN 
    Products P ON o.ProductID = p.ProductID;

--86. Display each student’s average grade.

CREATE TABLE Grades (
    GradeID INT PRIMARY KEY,
    StudentID INT,
    Subject VARCHAR(50),
    Grade DECIMAL(5,2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

INSERT INTO Grades VALUES
(1, 1, 'Math', 85.5),
(2, 1, 'Science', 90.0),
(3, 2, 'Math', 70.0),
(4, 2, 'Science', 75.5),
(5, 3, 'Math', 92.0);

SELECT * FROM Students;
SELECT * FROM Grades;

SELECT 
	 s.StudentID,
	 s.StudentName,
	 AVG(g.Grade) AS AverageGrade
FROM  
	Students s
JOIN 
    Grades g  ON s.StudentID = g.StudentID
GROUP BY 
    s.StudentID, s.StudentName;

--87. List all authors and the number of books they've written.

SELECT * FROM Author;
SELECT * FROM Books;

SELECT 
    a.author_id,
    a.name,
    COUNT(b.BookID) AS BookCount
FROM 
    Author a
LEFT JOIN 
    Books b ON a.author_id = b.AuthorID
GROUP BY 
    a.author_id, a.name;

--88. Get customers who ordered more than 5 times.

SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS OrderCount
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CustomerName;

--89. List customers who never placed an order.

SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT 
    c.CustomerID,
    c.CustomerName
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderID IS NULL;

--90. Show products not ordered in the last 6 months.

SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

SELECT 
    p.ProductID,
    p.ProductName
FROM 
    Products p
JOIN (
    SELECT DISTINCT od.ProductID
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    WHERE o.OrderDate >= DATEADD(MONTH, -6, GETDATE())
) recent_orders
ON p.ProductID = recent_orders.ProductID
WHERE recent_orders.ProductID IS NULL;

--91. Find employees with the same manager.

SELECT * FROM Employees;

SELECT 
    e1.EmployeeName AS Employee1,
    e2.EmployeeName AS Employee2,
    e1.ManagerID
FROM 
    Employees e1
JOIN 
    Employees e2 ON e1.ManagerID = e2.ManagerID 
WHERE 
    e1.EmployeeID < e2.EmployeeID;

--92. List pairs of students enrolled in the same course.

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade)
VALUES 
(3, 1, 1, 'A'),  
(4, 2, 2, 'B'); 

SELECT * FROM Enrollments;

SELECT
e.StudentID AS student1,
e2.StudentID AS student2,
e.CourseID
FROM Enrollments e
join Enrollments e2 ON e.CourseID = e2.CourseID
WHERE 
    e.StudentID < e2.StudentID;

--93. Display products with no matching supplier or category.

SELECT * FROM Products;
SELECT * FROM Categories;

SELECT P.ProductName, C.CategoryName
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE 
   C.CategoryID IS NULL;

--94. Get the number of songs in each album.

SELECT * FROM songs;
SELECT * FROM albums;

SELECT 
	a.album_name,
	COUNT(s.song_id) AS song_count
FROM
	albums a
JOIN
	songs s ON a.album_id = s.album_id
GROUP BY
	a.album_name;

--95. Find stores with below-average number of products.

--ALTER TABLE Products
--ADD StoreID INT;

--UPDATE Products
--SET StoreID = 1
--WHERE ProductID = 1;

--UPDATE Products
--SET StoreID = 2
--WHERE ProductID = 2;

--UPDATE Products
--SET StoreID = 3
--WHERE ProductID = 3;

--SELECT * FROM Stores;
--SELECT * FROM Products;

--WITH product_count AS (
--    SELECT StoreID, COUNT(*) AS total_products
--    FROM products
--    GROUP BY StoreID
--),
--average_count AS (
--    SELECT AVG(total_products) AS avg_products
--    FROM product_count
--)
--SELECT s.StoreID, s.StoreName, pc.total_products
--FROM stores s
--JOIN product_count pc ON s.StoreID = pc.StoreID,
--     average_count ac
--WHERE pc.total_products < ac.avg_products;

--96. Show projects with no tasks assigned.

CREATE TABLE tasks (
    task_id INT PRIMARY KEY,
    task_name VARCHAR(100),
    ProjectID INT,
    FOREIGN KEY (ProjectID) REFERENCES projects(ProjectID)
);

INSERT INTO tasks (task_id, task_name, ProjectID) VALUES
(1, 'Design UI', 1),
(2, 'Backend API', 1),
(3, 'Create Database', 2),
(4, 'User Login', 2);

SELECT * FROM Projects;
SELECT * FROM tasks;

SELECT
	P.ProjectName, T.task_name
FROM Projects P
JOIN tasks T ON P.ProjectID = T.ProjectID
WHERE T.task_name IS NULL;

--97. Get number of reviews per product.

SELECT * FROM Reviews;
SELECT * FROM Products;

SELECT 
    p.ProductID,
    p.ProductName,   
	COUNT(r.ReviewID) AS review_count
FROM 
    products p
LEFT JOIN 
    reviews r ON p.ProductID = r.ProductID
GROUP BY 
    p.ProductID, p.ProductName;

--98. List teachers who teach in more than one department.

CREATE TABLE teaches (
    teacher_id INT,
    department_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id),
);

CREATE TABLE depts (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);

INSERT INTO teaches (teacher_id, department_id) VALUES
(1, 101),
(1, 102),
(2, 101),
(2, 103);

INSERT INTO depts (dept_id, dept_name) VALUES
(101, 'Computer Science'),
(102, 'Mathematics'),
(103, 'Physics');

SELECT * FROM depts;
SELECT * FROM Teacher;
SELECT * FROM teaches;

SELECT 
	T.name, count(DISTINCT te.department_id) AS NUM 
FROM Teacher T
JOIN teaches te ON T.teacher_id = te.teacher_id
JOIN depts D ON D.dept_id = te.department_id
GROUP BY 
T.name
HAVING count(te.department_id) > 1;

--99. Show the latest order for each customer.

SELECT * FROM Orders;
SELECT * FROM Customers;

SELECT 
    c.CustomerID, 
    c.CustomerName, 
    o.OrderID, 
    o.OrderDate
FROM 
    customers c
JOIN 
    orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderDate = (
        SELECT MAX(OrderDate)
        FROM orders
        WHERE CustomerID = c.CustomerID);

--100. Get all items with their category, vendor, and inventory status.

CREATE TABLE items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    category_id INT,
    vendor_id INT
);

INSERT INTO items (item_id, item_name, category_id, vendor_id) VALUES
(1, 'Laptop', 1, 1),
(2, 'Chair', 2, 2),
(3, 'T-Shirt', 3, 3);


ALTER TABLE inventory
ADD inventory_status VARCHAR(50);

UPDATE Inventory
SET inventory_status = 'In Stock'
WHERE ItemID = 601;


UPDATE Inventory
SET inventory_status = 'Out of Stock'
WHERE ItemID = 602;

UPDATE Inventory
SET ItemID = 1
WHERE ItemID = 601;
UPDATE Inventory
SET ItemID = 2
WHERE ItemID = 602;

SELECT * FROM items;
SELECT * FROM Categories;
SELECT * FROM Vendors;
SELECT * FROM Inventory;

SELECT
	i.item_id, i.item_name, C.CategoryName,V.VendorName, inv.inventory_status
FROM items i
FULL OUTER JOIN  Categories C ON i.category_id = C.CategoryID
FULL OUTER JOIN  Vendors V ON i.vendor_id = V.VendorID
FULL OUTER JOIN  Inventory inv ON i.item_id = inv.ItemID;