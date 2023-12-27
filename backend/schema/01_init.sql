\c os_db;

CREATE TABLE client (
    client_id SERIAL PRIMARY KEY,
    client_name VARCHAR(255),
    created_at TIMESTAMP,
    email VARCHAR(255),
    recency TIMESTAMP,
    clv float8,
    avg_monthly_spend float8,
    avg_lifespan INTEGER
);

CREATE TABLE client_order (
    order_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES client(client_id),
    price INTEGER,
    created_at TIMESTAMP,
    delivered_at TIMESTAMP,
    progress JSON
);

CREATE TABLE machine (
    machine_id SERIAL PRIMARY KEY,
    machine_name VARCHAR(255),
    status VARCHAR(255),
    created_at TIMESTAMP
);

CREATE TABLE model (
    model_id SERIAL PRIMARY KEY,
    machine_id INTEGER REFERENCES machine(machine_id),
    quantity INTEGER,
    used INTEGER,
    created_at TIMESTAMP
);

CREATE TABLE supplier (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255)
);

CREATE TABLE material (
    material_id SERIAL PRIMARY KEY,
    supplier_id INTEGER REFERENCES supplier(supplier_id),
    material_name VARCHAR(255),
    quantity INTEGER
);

CREATE TABLE material_order (
    material_order_id SERIAL PRIMARY KEY,
    supplier_id INTEGER REFERENCES supplier(supplier_id),
    price INTEGER,
    created_at TIMESTAMP,
    delivered_at TIMESTAMP,
    progress JSON
);

CREATE TABLE order_contain_material (
    material_contain_id SERIAL PRIMARY KEY,
    material_order_id INTEGER REFERENCES material_order(material_order_id),
    material_id INTEGER REFERENCES material(material_id),
    quantity INTEGER
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255),
    model_id INTEGER REFERENCES model(model_id),
    created_at TIMESTAMP,
    product_type VARCHAR(255),
    price INTEGER,
    quantity INTEGER
);

CREATE TABLE order_contain_product (
    contain_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES client_order(order_id),
    product_id INTEGER REFERENCES product(product_id),
    quantity INTEGER
);

CREATE TABLE required_material (
    required_material_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES product(product_id),
	material_id INTEGER REFERENCES material(material_id),
	quantity INTEGER
);

CREATE TABLE required_product (
    required_product_id SERIAL PRIMARY KEY,
    produced_pid INTEGER REFERENCES product(product_id),
	required_pid INTEGER REFERENCES product(product_id),
	quantity INTEGER
);

CREATE TABLE product_inventory_consumption (
    consumption_id SERIAL PRIMARY KEY,
	product_id INTEGER REFERENCES product(product_id),
	consumed_date DATE,
	consumed_quantity INTEGER,
    is_forcast BOOLEAN
);

CREATE TABLE material_inventory_consumption (
    consumption_id SERIAL PRIMARY KEY,
	material_id INTEGER REFERENCES material(material_id),
	consumed_date DATE,
	consumed_quantity INTEGER,
    is_forcast BOOLEAN
);

CREATE TABLE client_revenue (
    revenue_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES client(client_id),
	revenue JSON
);

CREATE TABLE average_purchase_interval (
    avg_purchase_interval_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES client(client_id),
	avg_purchase_interval JSON
);