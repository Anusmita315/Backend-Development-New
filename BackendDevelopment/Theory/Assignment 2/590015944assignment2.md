# Assignment 2 — PostgreSQL as SQL + NoSQL: Working with JSONB

## Learning Objective

Understand how PostgreSQL's `jsonb` type lets a single relational database act as both a SQL and a NoSQL (document-style) engine, and evaluate where it can substitute for MongoDB.

---

# Part A — Conceptual Questions

## 1. What is `jsonb` in PostgreSQL, and how does it differ from the plain `json` type?

PostgreSQL provides two JSON data types: `json` and `jsonb`. Both allow JSON data to be stored inside a PostgreSQL database, but they use different storage formats. The `json` type stores the original JSON text as it is received. This means the formatting and key order of the input JSON are preserved. However, PostgreSQL has to parse the JSON text whenever it needs to process the data.

The `jsonb` type stores JSON data in a decomposed binary format. Because PostgreSQL processes the JSON when it is inserted, writing `jsonb` data can involve slightly more processing than writing plain `json`. However, once stored, `jsonb` is generally much faster for searching and querying because PostgreSQL does not need to parse the original text every time.

Another important advantage of `jsonb` is indexing. PostgreSQL can create indexes such as GIN indexes on a `jsonb` column, which can significantly improve searches for keys and key-value combinations.

For example:

```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    attributes JSONB
);

INSERT INTO products (attributes)
VALUES ('{"color": "black", "wireless": true}');

```

---

## 2. How can PostgreSQL work as both a SQL and a NoSQL database in the same table?

PostgreSQL can combine traditional relational database features with document-style data by using a `jsonb` column alongside normal typed columns. The fixed columns can store important structured information such as an ID, product name, category, and price. These columns provide the benefits of SQL, including data types, constraints, primary keys, and relationships.

The `jsonb` column can store additional attributes that may differ between records. For example, a laptop may have RAM and CPU information, while a book may have an author and number of pages. This allows different types of products to be stored in the same table without creating a separate column for every possible attribute.

For example:

```sql
CREATE TABLE products (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    attributes JSONB
);
```

A laptop could store:

```sql
INSERT INTO products (name, category, price, attributes)
VALUES (
    'ThinkPad',
    'laptop',
    75000.00,
    '{"ram_gb": 16, "cpu": "Intel i7"}'
);
```

Another product in the same table could store different JSON attributes. Therefore, PostgreSQL can provide structured SQL data and flexible document-style data in one database and even in the same table.

## 3. Give an example of a `jsonb` query using each of these operators, with the value it returns

PostgreSQL provides several operators for working with `jsonb` values. The `->` operator extracts a JSON object or JSON value, while the `->>` operator extracts the value as text. The `@>` operator checks whether one JSON value contains another JSON value. The `?` operator checks whether a specified key exists in a JSON object.

For example, suppose the `products` table contains:

```sql
INSERT INTO products (name, category, price, attributes)
VALUES (
    'Wireless Mouse',
    'accessory',
    799.00,
    '{"color": "black", "wireless": true}'
);
```

### `->` operator

```sql
SELECT attributes -> 'color' FROM products
WHERE name = 'Wireless Mouse';
```

Returns:

```text
"black"
```

The result is a JSON value.

### `->>` operator

```sql
SELECT attributes ->> 'color' FROM products
WHERE name = 'Wireless Mouse';
```

Returns:

```text
black
```

The result is text. Therefore, `->` returns a JSON value, while `->>` returns the value as text.

### `@>` operator

```sql
SELECT name FROM products
WHERE attributes @> '{"wireless": true}';
```

Returns:

```text
Wireless Mouse
```

This checks whether the `attributes` JSON contains the specified key-value pair.

### `?` operator

```sql
SELECT name FROM products
WHERE attributes ? 'color';
```

Returns:

```text
Wireless Mouse
```

This checks whether the `color` key exists in the `attributes` JSON object.

## 4. How can a GIN index on a `jsonb` column change query performance?

A GIN (Generalized Inverted Index) index can improve the performance of queries that search inside `jsonb` data. Instead of examining every row and checking the JSON attributes one by one, PostgreSQL can use the index to locate rows containing particular JSON keys or key-value combinations more efficiently.

GIN indexes are especially useful for containment queries using the `@>` operator and for queries that check whether a key or element exists. This becomes more useful when a table contains a large number of rows and the application frequently searches inside the `jsonb` column.

For example:

```sql
CREATE INDEX idx_products_attributes
ON products USING GIN (attributes);
```

After creating the index, PostgreSQL can use it for a query such as:

```sql
SELECT name
FROM products
WHERE attributes @> '{"wireless": true}';
```

This type of containment query can benefit from the GIN index because PostgreSQL can search the indexed JSONB structure instead of scanning every row.

However, a GIN index does not help every possible query equally. For example, a query that performs a calculation after extracting a value, such as:

```sql
SELECT name
FROM products
WHERE (attributes ->> 'ram_gb')::int >= 16;
```

is not the type of query where this general GIN index provides the same benefit as a JSONB containment query. Therefore, GIN is particularly useful when frequently querying JSONB data using supported containment and key-existence operations.

## 5. Where could PostgreSQL + `jsonb` replace a MongoDB deployment, and where would MongoDB still be the better fit?

PostgreSQL with `jsonb` can replace MongoDB when an application needs both relational data and flexible document-style attributes in the same database. PostgreSQL provides strong transaction support, SQL queries, constraints, and joins, while `jsonb` allows less-structured data to be stored without creating many additional columns.

For example, an e-commerce application could keep product IDs, names, prices, and categories in normal PostgreSQL columns while storing variable product attributes such as RAM, color, size, or specifications in a `jsonb` column. This can be useful when the application needs relationships between products, customers, orders, and payments.

MongoDB may be a better fit when the application is primarily document-oriented and has rapidly changing or highly varied document structures. MongoDB is designed around documents and can be convenient when most application data naturally maps to independent documents. It can also be useful when an application needs to scale horizontally across multiple servers.

PostgreSQL is particularly useful when transactions, joins, and relational integrity are important. MongoDB can be attractive when flexible document structures and horizontal scaling are major requirements. Therefore, the choice depends on the application's data model, consistency requirements, query patterns, and scaling needs.

Example PostgreSQL query:

```sql
SELECT name, attributes
FROM products
WHERE attributes @> '{"wireless": true}';
```

This demonstrates how PostgreSQL can combine relational SQL features with document-style JSONB data.

---

# Part B — Hands-on Exercise: Product Catalog

## Task 1 — Schema

The product catalog uses fixed relational columns for `id`, `name`, `category`, and `price`, along with a `jsonb` column named `attributes` for flexible product-specific information.

```sql
CREATE TABLE products (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    attributes JSONB
);

## Task 2 — Insert Data

Five products were inserted across three categories: `book`, `laptop`, and `accessory`. Each category uses different attribute keys inside the `jsonb` column.

```sql
INSERT INTO products_jsonb (name, category, price, attributes) VALUES
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
```

The inserted data was verified successfully using:

```sql
SELECT id, name, category, price, attributes
FROM products_jsonb
ORDER BY id;
```

The table contained all five products successfully.

## Task 3 — Query by Category-Specific Attribute

Each category was queried using an attribute specific to that category.

### Books — More than 400 pages

```sql
SELECT name, attributes ->> 'author' AS author
FROM products_jsonb
WHERE category = 'book'
  AND (attributes ->> 'pages')::int > 400;
```

**Result:**

```text
Clean Code | Robert C. Martin
```

### Laptops — At least 16 GB RAM

```sql
SELECT name, attributes ->> 'cpu' AS cpu
FROM products_jsonb
WHERE category = 'laptop'
  AND (attributes ->> 'ram_gb')::int >= 16;
```

**Result:**

```text
ThinkPad E14 | Intel i7
```

### Accessories — Wireless products

```sql
SELECT name, attributes ->> 'color' AS color
FROM products_jsonb
WHERE category = 'accessory'
  AND (attributes ->> 'wireless')::boolean = true;
```

**Result:**

```text
Wireless Mouse | black
```

These queries demonstrate that the JSONB attributes can be different for different product categories while still being stored in the same table.

## Task 4 — Containment Query

The `@>` operator was used to check whether a JSONB object contains a specific key-value pair.

```sql
SELECT name
FROM products_jsonb
WHERE attributes @> '{"wireless": true}';
```

**Result:**

```text
Wireless Mouse
```

This query searches inside the `attributes` JSONB column without requiring a separate database column for the `wireless` attribute.

## Task 5 — Update JSONB Without Altering the Table

A new attribute was added to the existing `Wireless Mouse` record using the JSONB concatenation operator `||`. No `ALTER TABLE` command was required.

```sql
UPDATE products_jsonb
SET attributes = attributes || '{"discount_pct": 10}'
WHERE name = 'Wireless Mouse';
```

The update affected one row:

```text
UPDATE 1
```

The updated record was verified using:

```sql
SELECT name, attributes
FROM products_jsonb
WHERE name = 'Wireless Mouse';
```

**Result:**

```text
Wireless Mouse | {"color": "black", "wireless": true, "discount_pct": 10}
```

This demonstrates that new JSON attributes can be added to an existing record without changing the table structure.

## Task 6 — Index and Compare

A GIN (Generalized Inverted Index) was created on the JSONB column:

```sql
CREATE INDEX idx_products_jsonb_attributes
ON products_jsonb USING GIN (attributes);
```

The containment query was tested using `EXPLAIN ANALYZE`.

### Before creating the GIN index

```sql
EXPLAIN ANALYZE
SELECT name
FROM products_jsonb
WHERE attributes @> '{"wireless": true}';
```

**Execution Time:**

```text
0.053 ms
```

PostgreSQL used a sequential scan because the table contained only five rows.

### After creating the GIN index

The same query was executed after creating the GIN index.

**Execution Time:**

```text
0.056 ms
```

PostgreSQL still selected a sequential scan because the table was very small. Therefore, the index did not produce a measurable improvement for this five-row dataset.

The important point is that a GIN index can become useful for larger JSONB datasets and queries involving JSONB containment and key-existence operations.

## Task 7 — MongoDB Comparison

The same five products were recreated as documents in a MongoDB `products` collection.

### MongoDB Insert

```javascript
db.products.insertMany([
  {
    name: "Clean Code",
    category: "book",
    price: 499.00,
    attributes: {
      author: "Robert C. Martin",
      pages: 464
    }
  },
  {
    name: "The Pragmatic Programmer",
    category: "book",
    price: 599.00,
    attributes: {
      author: "Andrew Hunt",
      pages: 352
    }
  },
  {
    name: "ThinkPad E14",
    category: "laptop",
    price: 75000.00,
    attributes: {
      ram_gb: 16,
      cpu: "Intel i7"
    }
  },
  {
    name: "Dell Inspiron 15",
    category: "laptop",
    price: 65000.00,
    attributes: {
      ram_gb: 8,
      cpu: "Intel i5"
    }
  },
  {
    name: "Wireless Mouse",
    category: "accessory",
    price: 799.00,
    attributes: {
      color: "black",
      wireless: true
    }
  }
]);
```

### MongoDB Category Queries

**Books:**

```javascript
db.products.find(
  {
    category: "book",
    "attributes.pages": { $gt: 400 }
  },
  {
    _id: 0,
    name: 1,
    "attributes.author": 1
  }
);
```

Result:

```text
Clean Code | Robert C. Martin
```

**Laptops:**

```javascript
db.products.find(
  {
    category: "laptop",
    "attributes.ram_gb": { $gte: 16 }
  },
  {
    _id: 0,
    name: 1,
    "attributes.cpu": 1
  }
);
```

Result:

```text
ThinkPad E14 | Intel i7
```

**Accessories:**

```javascript
db.products.find(
  {
    category: "accessory",
    "attributes.wireless": true
  },
  {
    _id: 0,
    name: 1,
    "attributes.color": 1
  }
);
```

Result:

```text
Wireless Mouse | black
```

### MongoDB Key-Value Query

The equivalent of the PostgreSQL JSONB containment query was:

```javascript
db.products.find(
  {
    "attributes.wireless": true
  },
  {
    _id: 0,
    name: 1
  }
);
```

Result:

```text
Wireless Mouse
```

### Comparison

PostgreSQL stores the product's important information in typed relational columns while using `jsonb` for flexible attributes. MongoDB stores the product as a document, with the flexible attributes naturally represented as a nested object.

PostgreSQL uses operators such as `->>`, `@>`, and `?` to work with JSONB values. MongoDB commonly uses dot notation such as `"attributes.ram_gb"` to access nested fields.

PostgreSQL also supports GIN indexes for JSONB data and provides relational features such as joins, constraints, and transactions. MongoDB uses document-oriented storage and provides indexes for fields inside documents.

For this product catalog, both approaches can store and query the same flexible product attributes. PostgreSQL is useful when the application needs relational data together with flexible JSON attributes, while MongoDB provides a document-oriented model where nested data is central to the application design.

---

# Conclusion

PostgreSQL `jsonb` provides a flexible document-style data model while retaining the relational features of PostgreSQL. In this exercise, JSONB was used to store different attributes for books, laptops, and accessories in the same table.

The practical queries demonstrated JSONB extraction, containment, updates, and GIN indexing. The same product data was also recreated in MongoDB, showing that both PostgreSQL with JSONB and MongoDB can handle flexible document-style data, but their query syntax and database models are different.

The exercise demonstrates that PostgreSQL can combine structured SQL data with flexible JSONB data without requiring a separate NoSQL database for every use case.