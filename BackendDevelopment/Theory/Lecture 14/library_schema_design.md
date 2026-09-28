# Library Management System - Schema Design

## 1. Author

- `author_id` — INT — Primary Key
- `author_name` — VARCHAR(100) — NOT NULL

## 2. Book

- `book_id` — INT — Primary Key
- `title` — VARCHAR(200) — NOT NULL
- `isbn` — VARCHAR(20) — UNIQUE, NOT NULL

## 3. Member

- `member_id` — INT — Primary Key
- `member_name` — VARCHAR(100) — NOT NULL
- `email` — VARCHAR(100) — UNIQUE, NOT NULL

## 4. Loan

- `loan_id` — INT — Primary Key
- `book_id` — INT — Foreign Key → Book(book_id)
- `member_id` — INT — Foreign Key → Member(member_id)
- `loan_date` — DATE — NOT NULL
- `return_date` — DATE

## 5. Book_Author

- `book_id` — INT — Foreign Key → Book(book_id)
- `author_id` — INT — Foreign Key → Author(author_id)
- Primary Key — `(book_id, author_id)`

## Relationships

**Author ↔ Book**
- Relationship: Many-to-Many (M:N)
- Implemented using `Book_Author`

**Member → Loan**
- Relationship: One-to-Many (1:M)

**Book → Loan**
- Relationship: One-to-Many (1:M)