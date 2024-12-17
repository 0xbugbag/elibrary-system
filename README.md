# SQL Query
---

SQL and Relational Database - Job Preparation Program - Pacmann AI

## Task Description
---

**Part 1: Designing The Database**

1. Mission Statement
To design and implement a robust database system for a multi-library e-library platform
that efficiently manages book collections, user borrowing activities, and hold requests while
ensuring data integrity and supporting the enforcement of business rules.

2. Creating Table Structures

|Table|Description|Field|
|:--|:--|:--|
|`libraries`|Stores details about libraries|`library_id → PK`, `library_name`, `address`, `phone`, `email`|
|`categories`|Stores details about book categories|`category_id → PK`, `category_name`, `description`|
|`books`|Stores details about books|`book_id → PK`, `title`, `author`, `isbn`, `publication_year`, `category_id → FK`, `description`|
|`library_books`|Stores details about inventory of the books|`library_book_id → PK`, `library_id → FK`, `book_id → FK`, `quantity`, `available_quantity`|
|`users`|Stores details about user|`user_id → PK`, `username`, `email`, `full_name`, `registration_date`|
|`loans`|Stores details about loan the books|`loan_id → PK`, `user_id → FK`, `library_book_id → FK`, `loan_date`, `due_date`, `return_date, status`|
|`holds`|Stores details about hold the books|`hold_id → PK`, `user_id → FK`, `library_book_id → FK`, `hold_date`, `expiry_date`, `status`, `queue_position`|

3. Determine Table Relationships
    - Libraries and Library_Books (One-to-Many):
        - One library can have many books
        - Foreign key: library_id in library_books
    - Books and Library_Books (One-to-Many):
        - One book can be in many libraries
        - Foreign key: book_id in library_books
    - Categories and Books (One-to-Many):
        - One category can have many books
        - Foreign key: category_id in books
    - Users and Loans (One-to-Many):
        - One user can have multiple loans
        - Foreign key: user_id in loans
    - Users and Holds (One-to-Many):
        - One user can have multiple holds
        - Foreign key: user_id in holds
    - Library_Books and Loans (One-to-Many):
        - One library book can have multiple loans
        - Foreign key: library_book_id in loans
    - Library_Books and Holds (One-to-Many):
        - One library book can have multiple holds
        - Foreign key: library_book_id in holds
        
4. Determine Business Rules
    - Libraries table:
        - library_id SERIAL
        - library_name NOT NULL
        - address NOT NULL
        - phone VARCHAR(50)
        - email VARCHAR(100)
    - Categories table:
        - category_id SERIAL
        - category_name VARCHAR(50) NOT NULL UNIQUE
        - description TEXT
    - Books table:
        - book_id SERIAL
        - title VARCHAR(255) NOT NULL
        - author VARCHAR(100) NOT NULL
        - isbn VARCHAR(50) UNIQUE
        - publication_year INTEGER
        - category_id INTEGER
        - description TEXT
    - Library Books (Inventory) table:
        - library_book_id SERIAL
        - library_id INTEGER
        - book_id INTEGER
        - quantity INTEGER NOT NULL CHECK (quantity >= 0)
        - available_quantity INTEGER NOT NULL CHECK (available_quantity >= 0) UNIQUE (library_id, book_id)
    - Users table:
        - user_id SERIAL
        - username VARCHAR(50) NOT NULL UNIQUE
        - email VARCHAR(100) NOT NULL UNIQUE
        - full_name VARCHAR(100) NOT NULL
        - registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    - Loans table:
        - loan_id SERIAL
        - user_id INTEGER
        - library_book_id INTEGER
        - loan_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        - due_date TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP + INTERVAL '14 days')
        - return_date TIMESTAMP
        - status VARCHAR(20) NOT NULL CHECK (status IN ('ACTIVE', 'RETURNED', 'OVERDUE')) 
        - CONSTRAINT check_return_date CHECK (return_date IS NULL OR return_date >= loan_date)
    - Holds table:
        - hold_id SERIAL
        - user_id INTEGER
        - library_book_id INTEGER
        - hold_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        - expiry_date TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP + INTERVAL '7 days')
        - status VARCHAR(20) NOT NULL CHECK (status IN ('PENDING', 'FULFILLED', 'EXPIRED'))
        - queue_position INTEGER NOT NULL CHECK (queue_position > 0)
        - CONSTRAINT unique_user_book_hold UNIQUE (user_id, library_book_id)
5. Implementing The Design
    - The result of this Database Design is an Entity Relationship Diagram (ERD). After creating the ERD, implement the ERD results into the database using PostgreSQL and Data Definition Language (DDL) [here](img/elibrary-system_design.png)



**Part 2: Populating Dummy Dataset**

After implementing the database design, create a dummy dataset for each table. Ensure that this dummy data adheres to the rules and relational logic of the database that has been designed. Output: Dataset in csv format [here](data)



**Part 3: Write 5 objectives/questions**

- Write five questions
- Execute the queries to answer the questions
- Analyze the results, providing insights and recommendations based on the findings

## Acknowledgments
---
This project was developed during course with Pacmann and may include materials provided by Sekolah Data, Pacmann AI. 

## License
---
This project is licensed under the [MIT License](LICENSE).
