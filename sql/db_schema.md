# Database DDL and DML


## DDL (Data Definition Language)

- Create Database mentalhealth
- Create Table user
- Drop Table user

### Create USER, ROLE, PRODUCT, CUTOMER tables with relation

```
-- Table: user
CREATE TABLE user (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: role
CREATE TABLE role (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- Table: user_role
CREATE TABLE user_role (
    user_id INT,
    role_id INT,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (role_id) REFERENCES role(role_id),
    PRIMARY KEY (user_id, role_id)
);

-- Table: product
CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL
);

-- Table: customer_product_relation
CREATE TABLE customer_product_relation (
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES user(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    PRIMARY KEY (customer_id, product_id)
);
```

## DML (Data Manipulation Language)

### Select, Insert, delete, update

- Insert sample data

```
-- Sample data for user table
INSERT INTO user (user_id, username, password, email) VALUES
(1, 'user1', 'password1', 'user1@example.com'),
(2, 'user2', 'password2', 'user2@example.com');

-- Sample data for role table
INSERT INTO role (role_id, role_name) VALUES
(1, 'Admin'),
(2, 'Customer');

-- Sample data for user_role table
INSERT INTO user_role (user_id, role_id) VALUES
(1, 1), -- user1 is an Admin
(2, 2); -- user2 is a Customer

-- Sample data for product table
INSERT INTO product (product_id, product_name, description, price) VALUES
(1, 'Product 1', 'Description for Product 1', 10.50),
(2, 'Product 2', 'Description for Product 2', 20.25);

-- Sample data for customer_product_relation table
INSERT INTO customer_product_relation (customer_id, product_id, quantity) VALUES
(2, 1, 2), -- user2 bought 2 units of Product 1
(2, 2, 1); -- user2 bought 1 unit of Product 2


```


## Sample queries


Here are some example queries based on the schema that you can practice:

1. Retrieve all users and their associated roles:

```sql
SELECT u.username, r.role_name
FROM user u
JOIN user_role ur ON u.user_id = ur.user_id
JOIN role r ON ur.role_id = r.role_id;
```

2. Retrieve all products purchased by a specific customer (e.g., user with user_id = 2):

```sql
SELECT p.product_name, cpr.quantity
FROM customer_product_relation cpr
JOIN product p ON cpr.product_id = p.product_id
WHERE cpr.customer_id = 2;
```

3. Calculate the total amount spent by a specific customer (e.g., user with user_id = 2):

```sql
SELECT SUM(p.price * cpr.quantity) AS total_amount_spent
FROM customer_product_relation cpr
JOIN product p ON cpr.product_id = p.product_id
WHERE cpr.customer_id = 2;
```

4. Retrieve the username of users who have the role 'Admin':

```sql
SELECT u.username
FROM user u
JOIN user_role ur ON u.user_id = ur.user_id
JOIN role r ON ur.role_id = r.role_id
WHERE r.role_name = 'Admin';
```

5. Retrieve the total number of products purchased:

```sql
SELECT SUM(quantity) AS total_products_purchased
FROM customer_product_relation;
```
