-- public.categories definition
-- Drop table
-- DROP TABLE public.categories;
CREATE TABLE public.categories (
category_id serial4 NOT NULL,
category_name varchar(50) NOT NULL,
description text NULL,
CONSTRAINT categories_category_name_key UNIQUE (category_name),
CONSTRAINT categories_pkey PRIMARY KEY (category_id)
);
-- public.libraries definition
-- Drop table
-- DROP TABLE public.libraries;
CREATE TABLE public.libraries (
library_id serial4 NOT NULL,
library_name varchar(100) NOT NULL,
address text NOT NULL,
phone varchar(50) NULL,
email varchar(100) NULL,
);
CONSTRAINT libraries_pkey PRIMARY KEY (library_id)
-- public.users definition
-- Drop table
-- DROP TABLE public.users;
CREATE TABLE public.users (
user_id serial4 NOT NULL,
username varchar(50) NOT NULL,
email varchar(100) NOT NULL,
full_name varchar(100) NOT NULL,
registration_date timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
CONSTRAINT users_email_key UNIQUE (email),
CONSTRAINT users_pkey PRIMARY KEY (user_id),
CONSTRAINT users_username_key UNIQUE (username)
);
-- public.books definition
-- Drop table
-- DROP TABLE public.books;
CREATE TABLE public.books (
book_id serial4 NOT NULL,
title varchar(255) NOT NULL,
author varchar(100) NOT NULL,
isbn varchar(50) NULL,
publication_year int4 NULL,
category_id int4 NULL,
description text NULL,
CONSTRAINT books_isbn_key UNIQUE (isbn),
CONSTRAINT books_pkey PRIMARY KEY (book_id),
CONSTRAINT books_category_id_fkey FOREIGN KEY (category_id) REFERENCES
public.categories(category_id)
);
-- public.library_books definition
-- Drop table
-- DROP TABLE public.library_books;
CREATE TABLE public.library_books (
library_book_id serial4 NOT NULL,
library_id int4 NULL,
book_id int4 NULL,
quantity int4 NOT NULL,
available_quantity int4 NOT NULL,
CONSTRAINT library_books_available_quantity_check CHECK ((available_quantity
>= 0)),
CONSTRAINT library_books_library_id_book_id_key UNIQUE (library_id, book_id),
CONSTRAINT library_books_pkey PRIMARY KEY (library_book_id),
CONSTRAINT library_books_quantity_check CHECK ((quantity >= 0)),
CONSTRAINT library_books_book_id_fkey FOREIGN KEY (book_id) REFERENCES
public.books(book_id),
CONSTRAINT library_books_library_id_fkey FOREIGN KEY (library_id) REFERENCES
public.libraries(library_id)
);
-- public.loans definition
-- Drop table
-- DROP TABLE public.loans;
CREATE TABLE public.loans (
loan_id serial4 NOT NULL,
user_id int4 NULL,
library_book_id int4 NULL,
loan_date timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
due_date timestamp DEFAULT (CURRENT_TIMESTAMP + '14 days'::interval) NOT
NULL,
return_date timestamp NULL,
status varchar(20) NOT NULL,
CONSTRAINT check_return_date CHECK (((return_date IS NULL) OR (return_date >=
loan_date))),
CONSTRAINT loans_pkey PRIMARY KEY (loan_id),
CONSTRAINT loans_status_check CHECK (((status)::text = ANY
((ARRAY['ACTIVE'::character varying, 'RETURNED'::character varying,
'OVERDUE'::character varying])::text[]))),
CONSTRAINT loans_library_book_id_fkey FOREIGN KEY (library_book_id)
REFERENCES public.library_books(library_book_id),
CONSTRAINT loans_user_id_fkey FOREIGN KEY (user_id) REFERENCES
public.users(user_id)
);
-- public.holds definition
-- Drop table
-- DROP TABLE public.holds;
CREATE TABLE public.holds (
hold_id serial4 NOT NULL,
user_id int4 NULL,
library_book_id int4 NULL,
hold_date timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
expiry_date timestamp DEFAULT (CURRENT_TIMESTAMP + '7 days'::interval) NOT
NULL,
status varchar(20) NOT NULL,
queue_position int4 NOT NULL,
CONSTRAINT holds_pkey PRIMARY KEY (hold_id),
CONSTRAINT holds_queue_position_check CHECK ((queue_position > 0)),
CONSTRAINT holds_status_check CHECK (((status)::text = ANY
((ARRAY['PENDING'::character varying, 'FULFILLED'::character varying,
'EXPIRED'::character varying])::text[]))),
CONSTRAINT unique_user_book_hold UNIQUE (user_id, library_book_id),
CONSTRAINT holds_library_book_id_fkey FOREIGN KEY (library_book_id)
REFERENCES public.library_books(library_book_id),
CONSTRAINT holds_user_id_fkey FOREIGN KEY (user_id) REFERENCES
public.users(user_id)
);
