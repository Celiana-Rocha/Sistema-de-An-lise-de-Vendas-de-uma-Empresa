﻿# Sistema de Análise de Vendas de uma Empresa

## Objetivos
 
Criar um banco de dados para armazenar dados de vendas, produtos, clientes e regiões, permitindo que você analise o desempenho de vendas, comportamento dos clientes e tendências de mercado.

Projeto criado com SQLite, foi feito um banco de dados criado localmente com dados fictícios para uso durante este projeto. 

# Tecnologias 🧩

![SQLite](https://img.shields.io/badge/SQLite-483d8b.svg?style=for-the-badge&logo=SQLite&logoColor=white)
![VS Code](https://img.shields.io/badge/VS%20Code-483d8b.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)

# Projeto 🚀



 

###  1. Tabela de Produtos (products)
#### Colunas:

- ```id``` (INTEGER, PRIMARY KEY).

- ```name``` (TEXT, nome do produto).

- ```category``` (TEXT, categoria do produto).

- ```price``` (REAL, preço do produto).

### 2. Tabela de Clientes (customers)

#### Colunas:

- ```id``` (INTEGER, PRIMARY KEY)

- ```name``` (TEXT, nome do cliente)

- ```email``` (TEXT, email do cliente)

- ```region``` (TEXT, região do cliente)

###  3. Tabela de Vendas (sales)

#### Colunas:

- ```id``` (INTEGER, PRIMARY KEY)

- ```product_id``` (INTEGER, FK de produtos)

- ```customer_id``` (INTEGER, FK de clientes)

- ```sale_date``` (DATE, data da venda)

- ```quantity``` (INTEGER, quantidade vendida)

```total_price``` (REAL, valor total da venda)

### 4. Tabela de Regiões (regions)

#### Colunas:

- ```region``` (TEXT, PRIMARY KEY)

- ```country``` (TEXT, país da região)

- ```sales_target``` (REAL, meta de vendas para a região)



 <details>

<summary>Criação das Tabelas e Inserção de Dados ⌨ </summary>

```
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

```



```
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
```

</details>

## Consultas para Análise de Dados 🖥

### 1. Total de Vendas por Produto

Descobrir o total de vendas de cada produto.

```
SELECT t2.name AS Produto, SUM(t1.total_price) AS Total_Vendido
FROM sales t1
JOIN products t2 ON t1.product_id = t2.id
GROUP BY t2.name;

```

### 2. Quantidade Vendida por Categoria

Verificar quantos itens de cada categoria foram vendidos.

```
SELECT t2.category AS Categoria, SUM(t1.quantity) AS Quantidade_Vendida
FROM sales t1
JOIN products t2 ON t1.product_id = t2.id
GROUP BY t2.category;

```

### 3. Total de Vendas por Região

Consultar as vendas totais por região.

```
SELECT c.region AS Regiao, SUM(s.total_price) AS Total_Vendido
FROM sales s
JOIN customers c ON s.customer_id = c.id
GROUP BY c.region;
```

### 4. Clientes que Compraram Mais de R$ 2000

Filtrar os clientes que gastaram mais de um valor específico.

```
SELECT c.name AS Cliente, SUM(s.total_price) AS Valor_Gasto
FROM sales s
JOIN customers c ON s.customer_id = c.id
GROUP BY c.name
HAVING SUM(s.total_price) > 2000;

```


### 5. Comparação entre Meta e Vendas por Região

Verificar se as regiões atingiram a meta de vendas.

```
SELECT r.region, r.sales_target, SUM(s.total_price) AS Vendas_Reais
FROM sales s
JOIN customers c ON s.customer_id = c.id
JOIN regions r ON c.region = r.region
GROUP BY r.region;

```

### 6. Produto Mais Vendido

Identificar qual produto teve o maior volume de vendas.

```
SELECT p.name AS Produto, SUM(s.quantity) AS Quantidade_Vendida
FROM sales s
JOIN products p ON s.product_id = p.id
GROUP BY p.name
ORDER BY Quantidade_Vendida DESC
LIMIT 1;

```

# Considerações Finais

O que aprendi com esse projeto:

- JOINs: Consultas que integram dados de múltiplas tabelas.
- Agregações: Como usar SUM, COUNT, AVG, e outras funções agregadas.
- Agrupamentos e Filtros: Uso de GROUP BY e HAVING para analisar dados agrupados.
- Análise de Tendências: Identificação de padrões de vendas, melhores clientes e produtos.
- Otimização de Consultas: Refinar as consultas para serem mais eficientes em cenários com grandes volumes de dados.


