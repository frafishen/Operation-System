\c os_db;

-- 10 clients
INSERT INTO client (client_name, created_at, email, recency, clv, avg_monthly_spend, avg_lifespan) VALUES
('Arthur Chien', CURRENT_TIMESTAMP, 'a@b.com', CURRENT_TIMESTAMP, 10000.1, 1000.1, 10),
('Peter Chen', CURRENT_TIMESTAMP, 'e@f.com', CURRENT_TIMESTAMP, 10000.3, 1000.1, 10),
('Gary Hsu', CURRENT_TIMESTAMP, 'g@h.com', CURRENT_TIMESTAMP, 10000.1, 1000.1, 10),
('Bill Lin', CURRENT_TIMESTAMP, 'i@j.com', CURRENT_TIMESTAMP, 10000.1, 1000.1, 10),
('Jerome Chiang', CURRENT_TIMESTAMP, 'c@d.com', CURRENT_TIMESTAMP, 10000.2, 1000.1, 10),
('Emily Wang', CURRENT_TIMESTAMP, 'emily@domain.com', CURRENT_TIMESTAMP, 10000.4, 1000.1, 10),
('John Doe', CURRENT_TIMESTAMP, 'john@domain.com', CURRENT_TIMESTAMP, 10000.5, 1000.1, 10),
('Sarah Lee', CURRENT_TIMESTAMP, 'sarah@domain.com', CURRENT_TIMESTAMP, 10000.3, 1000.1, 10),
('Michael Brown', CURRENT_TIMESTAMP, 'michael@domain.com', CURRENT_TIMESTAMP, 10000.2, 1000.1, 10),
('Jessica Davis', CURRENT_TIMESTAMP, 'jessica@domain.com', CURRENT_TIMESTAMP, 10000.6, 1000.1, 10);

INSERT INTO client_order (client_id, price, created_at, progress) VALUES
(1, 100, CURRENT_TIMESTAMP, '{"stage": 0, "completeness": 70}'),
(2, 100, CURRENT_TIMESTAMP, '{"stage": 1, "completeness": 50}'),
(1, 200, CURRENT_TIMESTAMP, '{"stage": 2, "completeness": 40}');

-- 10 machines
INSERT INTO machine (status, created_at) VALUES
('idle', CURRENT_TIMESTAMP),
('idle', CURRENT_TIMESTAMP),
('idle', CURRENT_TIMESTAMP),
('idle', CURRENT_TIMESTAMP),
('idle', CURRENT_TIMESTAMP),
('idle', CURRENT_TIMESTAMP),
('idle', CURRENT_TIMESTAMP),
('idle', CURRENT_TIMESTAMP),
('idle', CURRENT_TIMESTAMP),
('idle', CURRENT_TIMESTAMP);

-- 10 suppliers
INSERT INTO supplier (supplier_id) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

-- 10 materials
INSERT INTO material (supplier_id, material_name, quantity) VALUES
(1, 'material_1', 19000),
(2, 'material_2', 10000),
(3, 'material_3', 12000),
(4, 'material_4', 10000),
(5, 'material_5', 12000),
(6, 'material_6', 16000),
(7, 'material_7', 14000),
(8, 'material_8', 13000),
(9, 'material_9', 12000),
(10, 'material_10', 10000);

-- 10 models
INSERT INTO model (machine_id, quantity, used, created_at) VALUES
(1, 1, 0, CURRENT_TIMESTAMP),
(2, 2, 0, CURRENT_TIMESTAMP),
(3, 3, 0, CURRENT_TIMESTAMP),
(4, 2, 1, CURRENT_TIMESTAMP),
(5, 1, 0, CURRENT_TIMESTAMP),
(6, 2, 0, CURRENT_TIMESTAMP),
(7, 3, 0, CURRENT_TIMESTAMP),
(8, 2, 1, CURRENT_TIMESTAMP),
(9, 1, 0, CURRENT_TIMESTAMP),
(10, 2, 0, CURRENT_TIMESTAMP);

-- 10 products
INSERT INTO product (product_name, model_id, created_at, product_type, price, quantity) VALUES
('product_1', 1, CURRENT_TIMESTAMP, 'pcb', 100, 10000),
('product_2', 2, CURRENT_TIMESTAMP, 'customized', 110, 10000),
('product_3', 3, CURRENT_TIMESTAMP, 'grid', 120, 12000),
('product_4', 4, CURRENT_TIMESTAMP, 'pcb', 150, 8000),
('product_5', 5, CURRENT_TIMESTAMP, 'rail', 120, 11000),
('product_6', 6, CURRENT_TIMESTAMP, 'pcb', 100, 10000),
('product_7', 7, CURRENT_TIMESTAMP, 'customized', 110, 10000),
('product_8', 8, CURRENT_TIMESTAMP, 'grid', 120, 12000),
('product_9', 9, CURRENT_TIMESTAMP, 'pcb', 150, 8000),
('product_10', 10, CURRENT_TIMESTAMP, 'rail', 120, 11000);

-- -- 16 sales
-- INSERT INTO sales (product_id, sales_date, saled_quantity) VALUES
-- (1, '2023/01/01', 700),
-- (1, '2023/02/01', 900),
-- (1, '2023/03/01', 1000),
-- (1, '2023/04/01', 900),
-- (1, '2023/05/01', 700),
-- (1, '2023/06/01', 950),
-- (1, '2023/07/01', 1000),
-- (1, '2023/08/01', 900),
-- (1, '2023/09/01', 700),
-- (1, '2023/10/01', 900),
-- (1, '2023/11/01', 1075),
-- (1, '2023/12/01', 800),
-- (2, '2023/02/01', 1200),
-- (3, '2023/03/01', 1300),
-- (4, '2023/04/01', 1200),
-- (5, '2023/05/01', 1100);

-- 9
INSERT INTO required_product (produced_pid, required_pid, quantity) VALUES
(1, 2, 100),
(1, 5, 100),
(4, 3, 100),
(2, 3, 100),
(6, 2, 100),
(7, 5, 100),
(8, 3, 100),
(9, 2, 100),
(10, 5, 100);

INSERT INTO required_material (product_id, material_id, quantity) VALUES
(1, 1, 100),
(1, 2, 100),
(4, 3, 100),
(2, 4, 100),
(5, 5, 10),
(6, 6, 100),
(7, 7, 100),
(8, 8, 100),
(9, 9, 100),
(10, 10, 100);

INSERT INTO order_contain_product (order_id, product_id, quantity) VALUES
(1, 1, 100),
(1, 2, 100),
(2, 4, 100),
(3, 5, 100);

-- 3 material orders
INSERT INTO material_order (supplier_id, price, created_at, progress) VALUES
(1, 100, CURRENT_TIMESTAMP, '{"stage 1": "recieved 0 kg", "stage 2": "recieved 10 kg", "stage 3": "recieved 5 kg, order completed"}'),
(2, 100, CURRENT_TIMESTAMP, '{"stage 1": "recieved 0 kg", "stage 2": "recieved 12 kg", "stage 3": "recieved 3 kg", "stage 4": "recieved 5 kg, order completed"}'),
(1, 200, CURRENT_TIMESTAMP, '{"stage 1": "recieved 0 kg", "stage 2": "recieved 5 kg", "stage 3": "recieved 5 kg", "stage 4": "recieved 5 kg", "stage 5": "recieved 5 kg, order completed"}');

INSERT INTO order_contain_material (material_order_id, material_id, quantity) VALUES
(1, 1, 100),
(1, 2, 100),
(2, 4, 100),
(3, 5, 100);


INSERT INTO client_revenue (client_id, revenue) VALUES
(1, '{  
        "Jan-2023": 87.01,
        "Feb-2023": 91.60,
        "Mar-2023": 99.23,
        "Apr-2023": 102.27,
        "May-2023": 104.73,
        "Jun-2023": 107.09,
        "Jul-2023": 110.46,
        "Aug-2023": 117.63,
        "Sep-2023": 117.52,
        "Oct-2023": 115.18,
        "Nov-2023": 100.39,
        "Dec-2023": 94.56
    }');

INSERT INTO average_purchase_interval (client_id, avg_purchase_interval) VALUES
(1, '{
        "Jan-2023": 10,
        "Feb-2023": 12,
        "Mar-2023": 13,
        "Apr-2023": 12,
        "May-2023": 11,
        "Jun-2023": 11,
        "Jul-2023": 9,
        "Aug-2023": 8,
        "Sep-2023": 8,
        "Oct-2023": 7,
        "Nov-2023": 9,
        "Dec-2023": 10
    }');


INSERT INTO product_inventory_consumption (product_id, consumed_date, consumed_quantity, is_forcast) VALUES
(1, '2021-01-01', 70.16, false),
(1, '2021-02-01', 73.32, false),
(1, '2021-03-01', 80.91, false),
(1, '2021-04-01', 86.04, false),
(1, '2021-05-01', 87.93, false),
(1, '2021-06-01', 90.24, false),
(1, '2021-07-01', 95.16, false),
(1, '2021-08-01', 101.10, false),
(1, '2021-09-01', 99.57, false),
(1, '2021-10-01', 97.81, false),
(1, '2021-11-01', 83.84, false),
(1, '2021-12-01', 77.96, false),
(1, '2022-01-01', 78.63, false),
(1, '2022-02-01', 83.40, false),
(1, '2022-03-01', 91.04, false),
(1, '2022-04-01', 93.83, false),
(1, '2022-05-01', 96.37, false),
(1, '2022-06-01', 98.75, false),
(1, '2022-07-01', 100.63, false),
(1, '2022-08-01', 108.96, false),
(1, '2022-09-01', 110.18, false),
(1, '2022-10-01', 107.31, false),
(1, '2022-11-01', 91.73, false),
(1, '2022-12-01', 84.85, false),
(1, '2023-01-01', 87.01, true),
(1, '2023-02-01', 91.60, true),
(1, '2023-03-01', 99.23, true),
(1, '2023-04-01', 102.27, true),
(1, '2023-05-01', 104.73, true),
(1, '2023-06-01', 107.09, true),
(1, '2023-07-01', 110.46, true),
(1, '2023-08-01', 117.63, true),
(1, '2023-09-01', 117.52, true),
(1, '2023-10-01', 115.18, true),
(1, '2023-11-01', 100.39, true),
(1, '2023-12-01', 94.56, true);



INSERT INTO material_inventory_consumption (material_id, consumed_date, consumed_quantity, is_forcast) VALUES
(1, '2021-01-01', 70.16, false),
(1, '2021-02-01', 73.32, false),
(1, '2021-03-01', 80.91, false),
(1, '2021-04-01', 86.04, false),
(1, '2021-05-01', 87.93, false),
(1, '2021-06-01', 90.24, false),
(1, '2021-07-01', 95.16, false),
(1, '2021-08-01', 101.10, false),
(1, '2021-09-01', 99.57, false),
(1, '2021-10-01', 97.81, false),
(1, '2021-11-01', 83.84, false),
(1, '2021-12-01', 77.96, false),
(1, '2022-01-01', 78.63, false),
(1, '2022-02-01', 83.40, false),
(1, '2022-03-01', 91.04, false),
(1, '2022-04-01', 93.83, false),
(1, '2022-05-01', 96.37, false),
(1, '2022-06-01', 98.75, false),
(1, '2022-07-01', 100.63, false),
(1, '2022-08-01', 108.96, false),
(1, '2022-09-01', 110.18, false),
(1, '2022-10-01', 107.31, false),
(1, '2022-11-01', 91.73, false),
(1, '2022-12-01', 84.85, false),
(1, '2023-01-01', 87.01, true),
(1, '2023-02-01', 91.60, true),
(1, '2023-03-01', 99.23, true),
(1, '2023-04-01', 102.27, true),
(1, '2023-05-01', 104.73, true),
(1, '2023-06-01', 107.09, true),
(1, '2023-07-01', 110.46, true),
(1, '2023-08-01', 117.63, true),
(1, '2023-09-01', 117.52, true),
(1, '2023-10-01', 115.18, true),
(1, '2023-11-01', 100.39, true),
(1, '2023-12-01', 94.56, true);










