-- Reverse-engineered draft DDL
-- Source: Sales PostgreSQL database
-- Reconstructed from captured metadata

CREATE TABLE public.sales_customers (
    customer_id BIGINT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    city VARCHAR(100),
    country VARCHAR(100),
    CONSTRAINT sales_customers_pkey PRIMARY KEY (customer_id)
);

CREATE TABLE public.sales_locations (
    location_id BIGINT NOT NULL,
    city VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    CONSTRAINT sales_locations_pkey PRIMARY KEY (location_id)
);

CREATE TABLE public.sales_products (
    product_id BIGINT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    unit_price NUMERIC(12,2) NOT NULL,
    CONSTRAINT sales_products_pkey PRIMARY KEY (product_id)
);

CREATE TABLE public.sales_transaction_lines (
    line_id BIGINT NOT NULL,
    transaction_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(12,2) NOT NULL,
    line_total NUMERIC(14,2) NOT NULL,
    CONSTRAINT sales_transaction_lines_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.sales_products (product_id),
    CONSTRAINT sales_transaction_lines_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.sales_transactions (transaction_id),
    CONSTRAINT sales_transaction_lines_pkey PRIMARY KEY (line_id)
);

CREATE TABLE public.sales_transactions (
    transaction_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    location_id BIGINT NOT NULL,
    transaction_date DATE NOT NULL,
    CONSTRAINT sales_transactions_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.sales_customers (customer_id),
    CONSTRAINT sales_transactions_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.sales_locations (location_id),
    CONSTRAINT sales_transactions_pkey PRIMARY KEY (transaction_id)
);
