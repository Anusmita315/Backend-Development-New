# Library Management System - ER Diagram

## Entities

### Author
- author_id (Primary Key)
- author_name

### Book
- book_id (Primary Key)
- title
- isbn

### Member
- member_id (Primary Key)
- member_name
- email

### Loan
- loan_id (Primary Key)
- loan_date
- return_date
- book_id (Foreign Key)
- member_id (Foreign Key)

## Relationships

- An Author can write multiple Books.
- A Book can have multiple Authors.
- A Member can borrow multiple Books.
- A Book can be borrowed through multiple Loans over time.

## Relationship Types

- Author — Book: Many-to-Many (M:N)
- Member — Loan: One-to-Many (1:M)
- Book — Loan: One-to-Many (1:M)

## Junction Table

For the many-to-many relationship between Book and Author:

**Book_Author**
- book_id (Foreign Key)
- author_id (Foreign Key)
- Primary Key: (book_id, author_id)