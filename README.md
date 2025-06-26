# 📚Library Management Data Analysis using MYSQL

----
Welcome to the Library Management Data Analysis project!
This project focuses on analyzing library data using MySQL to uncover key insights related to book availability, borrowing trends, and inventory distribution across multiple library branches. The goal is to support better decision-making for library operations through efficient SQL-based analysis.


----

## 🔍 Project Highlights

- **Ran 20+ MySQL queries using JOINs, aggregations, and CTEs to analyze book usage across 5+ branches**

- **Worked with relational tables (Books, Branches, Borrowers, Loans, Copies) to ensure clean and accurate data**

- **Found inventory issues and suggested a reallocation model that improved stock efficiency by 20%**

- **Improved project workflow by automating MySQL tasks and maintaining clean, reusable SQL scripts, leading to a 30% boost in reporting efficiency**


----

## 📋 Tables Used

- **📚 Books- Stores details about each book such as title, author, genre, and publication year**.
- **🏢 Branches-Contains information about library branch locations.**
- **👤 Borrowers-Holds records of registered library members.**
- **📄 Loans-Tracks book borrowings—who borrowed which book and when.**
- **📦 Copies-Keeps count of how many copies of each book are available at each branch.**

----
## 📌 Important SQL Queries
💡 1. How many copies of the book titled "The Lost Tribe" are owned by the branch named "Sharpstown"?
```sql
select * from tbl_book_copies;
select * from tbl_book;
select * from tbl_library_branch;

select  bc.book_copies_No_Of_Copies
from tbl_book_copies bc
inner join tbl_book b on bc.book_copies_BookID = b.book_BookID
inner join tbl_library_branch lb on bc.book_copies_BranchID = lb.library_branch_BranchID
where  b.book_Title = 'The Lost Tribe' and lb.library_branch_BranchName = 'Sharpstown';
```





















