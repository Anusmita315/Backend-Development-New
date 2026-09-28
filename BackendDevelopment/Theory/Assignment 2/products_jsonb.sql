-- Assignment 2: PostgreSQL JSONB Product Catalog

CREATE TABLE products (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    attributes JSONB
);
-- Insert 5 products across 3 categories

INSERT INTO products (name, category, price, attributes) VALUES
(
    'Clean Code',
    'book',
    499.00,
    '{"author": "Robert C. Martin", "pages": 464}'
),
(
    'The Pragmatic Programmer',
    'book',
    599.00,
    '{"author": "Andrew Hunt", "pages": 352}'
),
(
    'ThinkPad E14',
    'laptop',
    75000.00,
    '{"ram_gb": 16, "cpu": "Intel i7"}'
),
(
    'Dell Inspiron 15',
    'laptop',
    65000.00,
    '{"ram_gb": 8, "cpu": "Intel i5"}'
),
(
    'Wireless Mouse',
    'accessory',
    799.00,
    '{"color": "black", "wireless": true}'
);

-- Task 3: Query by category-specific attribute

-- Books: find books with more than 400 pages
SELECT name, attributes ->> 'author' AS author
FROM products
WHERE category = 'book'
  AND (attributes ->> 'pages')::int > 400;

-- Laptops: find laptops with at least 16 GB RAM
SELECT name, attributes ->> 'cpu' AS cpu
FROM products
WHERE category = 'laptop'
  AND (attributes ->> 'ram_gb')::int >= 16;

-- Accessories: find wireless accessories
SELECT name, attributes ->> 'color' AS color
FROM products
WHERE category = 'accessory'
  AND (attributes ->> 'wireless')::boolean = true;

  -- Task 4: Containment query

SELECT name
FROM products
WHERE attributes @> '{"wireless": true}';

-- Task 5: Update JSONB without altering the table

UPDATE products
SET attributes = attributes || '{"discount_pct": 10}'
WHERE name = 'Wireless Mouse';

-- Verify the updated JSONB value
SELECT name, attributes
FROM products
WHERE name = 'Wireless Mouse';

-- Task 6: Create a GIN index on the JSONB column

CREATE INDEX idx_products_attributes
ON products USING GIN (attributes);

-- Task 6: Compare query performance using EXPLAIN ANALYZE

EXPLAIN ANALYZE
SELECT name
FROM products
WHERE attributes @> '{"wireless": true}';

EXPLAIN ANALYZE
SELECT name, attributes ->> 'author' AS author
FROM products
WHERE category = 'book'
  AND (attributes ->> 'pages')::int > 400;

EXPLAIN ANALYZE
SELECT name, attributes ->> 'cpu' AS cpu
FROM products
WHERE category = 'laptop'
  AND (attributes ->> 'ram_gb')::int >= 16;

EXPLAIN ANALYZE
SELECT name, attributes ->> 'color' AS color
FROM products
WHERE category = 'accessory'
  AND (attributes ->> 'wireless')::boolean = true;