create database library_management;

use library_management;

-- Table: tbl_publisher
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress TEXT,
    publisher_PublisherPhone VARCHAR(15)
);
select * from tbl_publisher;

-- Table: tbl_book
CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName)
);

select * from tbl_book;

-- Table: tbl_book_authors
CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID)
);

select * from tbl_book_authors;

-- Table: tbl_library_branch
CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress TEXT
);

select * from tbl_library_branch;
DESCRIBE tbl_library_branch;

-- Table: tbl_book_copies
CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID)
);

select * from tbl_book_copies;

-- Table: tbl_borrower
CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress TEXT,
    borrower_BorrowerPhone VARCHAR(15)
);
describe tbl_borrower;
select * from tbl_borrower;

-- Table: tbl_book_loans
CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut varchar(255),
    book_loans_DueDate varchar(255),
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo)
);
drop table tbl_book_loans;

select * from tbl_book_loans;

select str_to_date(book_loans_DateOut,"%d/%c/%Y")as date_out from tbl_book_loans;

set sql_safe_updates = 0;
UPDATE tbl_book_loans SET book_loans_DateOut = STR_TO_DATE(book_loans_DateOut, "%m/%d/%y");

select * from tbl_book_loans;
select str_to_date(book_loans_DueDate,"%d/%c/%Y")as due_date from tbl_book_loans;
UPDATE tbl_book_loans SET book_loans_DueDate = STR_TO_DATE(book_loans_DueDate, "%m/%d/%y");

select * from tbl_book_loans;


-- Analysis questions
-- 1.How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

select * from tbl_book_copies;
select * from tbl_book;
select * from tbl_library_branch;

select  bc.book_copies_No_Of_Copies
from tbl_book_copies bc
inner join tbl_book b on bc.book_copies_BookID = b.book_BookID
inner join tbl_library_branch lb on bc.book_copies_BranchID = lb.library_branch_BranchID
where  b.book_Title = 'The Lost Tribe' and lb.library_branch_BranchName = 'Sharpstown';

-- 2.How many copies of the book titled "The Lost Tribe" are owned by each library branch?

select 
    lb.library_branch_BranchName as Branch_Name,
    SUM(bc.book_copies_No_Of_Copies) as Total_Copies
from
    tbl_book b
inner join
    tbl_book_copies bc on b.book_BookID = bc.book_copies_BookID
inner join 
    tbl_library_branch lb on bc.book_copies_BranchID = lb.library_branch_BranchID
where
    b.book_Title = 'The Lost Tribe'
group by 
    lb.library_branch_BranchName;

-- 3.Retrieve the names of all borrowers who do not have any books checked out.

select
    b.borrower_BorrowerName
from
    tbl_borrower b
left join
    tbl_book_loans bl on b.borrower_CardNo = bl.book_loans_CardNo
where 
    bl.book_loans_CardNo is null;
    
    
-- 4.For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address
SELECT 
    b.book_Title,
    br.borrower_BorrowerName,
    br.borrower_BorrowerAddress
FROM 
    tbl_book_loans bl
JOIN 
    tbl_book b ON bl.book_loans_BookID = b.book_BookID
JOIN 
    tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
JOIN 
    tbl_borrower br ON bl.book_loans_CardNo = br.borrower_CardNo
WHERE 
    lb.library_branch_BranchName = 'Sharpstown'
    AND bl.book_loans_DueDate = '2018-02-03';

-- 5.For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
SELECT 
    lb.library_branch_BranchName,
    COUNT(*) AS total_books_loaned
FROM 
    tbl_book_loans bl
JOIN 
    tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
GROUP BY 
    lb.library_branch_BranchName;

-- 6.Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

select 
    br.borrower_BorrowerName as Borrower_Name,
    br.borrower_BorrowerAddress as Borrower_Address,
    COUNT(bl.book_loans_LoansID) as Books_Checked_Out
from 
    tbl_borrower br
inner join
    tbl_book_loans bl on br.borrower_CardNo = bl.book_loans_CardNo
group by 
    br.borrower_CardNo, br.borrower_BorrowerName, br.borrower_BorrowerAddress
having
    COUNT(bl.book_loans_LoansID) > 5;
    
-- 7.For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

SELECT 
    b.book_Title,
    bc.book_copies_No_Of_Copies
FROM 
    tbl_book_authors ba
JOIN 
    tbl_book b ON ba.book_authors_BookID = b.book_BookID
JOIN 
    tbl_book_copies bc ON b.book_BookID = bc.book_copies_BookID
JOIN 
    tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE 
    ba.book_authors_AuthorName = 'Stephen King'
    AND lb.library_branch_BranchName = 'Central';
    

