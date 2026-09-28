# Order Table Normalization

## Given Order Table

### Order 1

- `order_id`: 1
- `customer_name`: Aarav
- `customer_email`: aarav@email
- `product_name`: Laptop
- `product_price`: 65000
- `quantity`: 1

### Order 1

- `order_id`: 1
- `customer_name`: Aarav
- `customer_email`: aarav@email
- `product_name`: Mouse
- `product_price`: 500
- `quantity`: 2

### Order 2

- `order_id`: 2
- `customer_name`: Diya
- `customer_email`: diya@email
- `product_name`: Keyboard
- `product_price`: 1500
- `quantity`: 1

## First Normal Form (1NF)

The table is in 1NF because:

- Each column contains atomic values.
- There are no repeating groups.
- Each row represents a single order-product entry.

The table can therefore be represented as:

`Order(order_id, customer_name, customer_email, product_name, product_price, quantity)`

## Second Normal Form (2NF)

The original table has a composite key:

`(order_id, product_name)`

There are partial dependencies:

- `customer_name` and `customer_email` depend only on `order_id`.
- `product_price` depends only on `product_name`.
- `quantity` depends on the complete combination of `order_id` and `product_name`.

To remove these partial dependencies, the table is decomposed into three tables:

### Orders

- `order_id` — Primary Key
- `customer_name`
- `customer_email`

### Products

- `product_name` — Primary Key
- `product_price`

### Order_Details

- `order_id` — Foreign Key
- `product_name` — Foreign Key
- `quantity`
- Primary Key: `(order_id, product_name)`

## Third Normal Form (3NF)

In 2NF, the `Orders` table contains:

- `order_id`
- `customer_name`
- `customer_email`

The customer information should be separated so that non-key customer details are not stored repeatedly with every order.

The final 3NF design is:

### Customers

- `customer_email` — Primary Key
- `customer_name`

### Orders

- `order_id` — Primary Key
- `customer_email` — Foreign Key

### Products

- `product_name` — Primary Key
- `product_price`

### Order_Details

- `order_id` — Foreign Key
- `product_name` — Foreign Key
- `quantity`
- Primary Key: `(order_id, product_name)`

## Final 3NF Schema

`Customers(customer_email, customer_name)`

`Orders(order_id, customer_email)`

`Products(product_name, product_price)`

`Order_Details(order_id, product_name, quantity)`

The final design removes partial and transitive dependencies and stores each type of information in its appropriate table.