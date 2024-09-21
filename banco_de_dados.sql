CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT,
    price REAL
);

CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT,
    region TEXT
);

CREATE TABLE sales (
    id INTEGER PRIMARY KEY,
    product_id INTEGER,
    customer_id INTEGER,
    sale_date DATE,
    quantity INTEGER,
    total_price REAL,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE regions (
    region TEXT PRIMARY KEY,
    country TEXT,
    sales_target REAL
);


-- Inserção de produtos
INSERT INTO products (id, name, category, price) VALUES
(1, 'Laptop', 'Eletrônicos', 1500.00),
(2, 'Smartphone', 'Eletrônicos', 800.00),
(3, 'Geladeira', 'Eletrodomésticos', 1200.00);

-- Inserção de clientes
INSERT INTO customers (id, name, email, region) VALUES
(1, 'João Silva', 'joao@example.com', 'Norte'),
(2, 'Maria Oliveira', 'maria@example.com', 'Sul'),
(3, 'Carlos Sousa', 'carlos@example.com', 'Sudeste');

-- Inserção de vendas
INSERT INTO sales (id, product_id, customer_id, sale_date, quantity, total_price) VALUES
(1, 1, 1, '2024-09-01', 2, 3000.00),
(2, 2, 2, '2024-09-02', 1, 800.00),
(3, 3, 3, '2024-09-03', 1, 1200.00);

-- Inserção de regiões
INSERT INTO regions (region, country, sales_target) VALUES
('Norte', 'Brasil', 50000.00),
('Sul', 'Brasil', 60000.00),
('Sudeste', 'Brasil', 80000.00);


-- Produto mais vendidos
SELECT t2.name AS Produto, SUM(t1.total_price) AS Total_Vendido
FROM sales t1
JOIN products t2 ON t1.product_id = t2.id
GROUP BY t2.name;

-- Quantidade Vendida por Categoria
SELECT t2.category AS Categoria, SUM(t1.quantity) AS Quantidade_Vendida
FROM sales t1
JOIN products t2 ON t1.product_id = t2.id
GROUP BY t2.category;

-- Total de Vendas por Região

SELECT c.region AS Regiao, SUM(s.total_price) AS Total_Vendido
FROM sales s
JOIN customers c ON s.customer_id = c.id
GROUP BY c.region;

-- Clientes que Compraram Mais de R$ 2000

SELECT c.name AS Cliente, SUM(s.total_price) AS Valor_Gasto
FROM sales s
JOIN customers c ON s.customer_id = c.id
GROUP BY c.name
HAVING SUM(s.total_price) > 2000;


-- Comparação entre Meta e Vendas por Região

SELECT r.region, r.sales_target, SUM(s.total_price) AS Vendas_Reais
FROM sales s
JOIN customers c ON s.customer_id = c.id
JOIN regions r ON c.region = r.region
GROUP BY r.region;

-- Produto Mais Vendido

SELECT p.name AS Produto, SUM(s.quantity) AS Quantidade_Vendida
FROM sales s
JOIN products p ON s.product_id = p.id
GROUP BY p.name
ORDER BY Quantidade_Vendida DESC
LIMIT 1;

