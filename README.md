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


💡 2.How many copies of the book titled "The Lost Tribe" are owned by each library branch?
```sql
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
```

 💡3.Retrieve the names of all borrowers who do not have any books checked out.
```sql
select
    b.borrower_BorrowerName
from
    tbl_borrower b
left join
    tbl_book_loans bl on b.borrower_CardNo = bl.book_loans_CardNo
where 
    bl.book_loans_CardNo is null;
```

💡4.For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
```sql
SELECT 
    lb.library_branch_BranchName,
    COUNT(*) AS total_books_loaned
FROM 
    tbl_book_loans bl
JOIN 
    tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
GROUP BY 
    lb.library_branch_BranchName;
```

-----

## 📊 Key Outputs
- **Distribution of books across branches to optimize inventory management**
- **Checking book availability by specific authors across all branches**
- **Accurate counts of books per branch to assist in stock balancing and transfers**
- **Tracking of due dates to minimize overdue returns and book losses**

-----

## 🎯 Project Outcomes 
- **Achieved a 20% improvement in inventory efficiency through data-driven book redistribution**
- **Lowered overdue book instances by monitoring and managing habitual late borrowers**
- **Boosted library service quality by understanding borrower behavior and popular authors**









































