-- Reverse-engineered draft DDL
-- Source: Inventory SQLite database
-- Reconstructed from captured metadata

CREATE TABLE inventory_locations (
    location_id INTEGER,
    city TEXT NOT NULL,
    region TEXT NOT NULL,
    country TEXT NOT NULL,
    CONSTRAINT SRC_INVENTORY:inventory_locations:PRIMARY_KEY PRIMARY KEY (location_id)
);

CREATE TABLE inventory_products (
    product_id INTEGER,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    CONSTRAINT SRC_INVENTORY:inventory_products:PRIMARY_KEY PRIMARY KEY (product_id)
);

CREATE TABLE inventory_stock_levels (
    stock_id INTEGER,
    product_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    quantity_on_hand INTEGER NOT NULL,
    last_updated TEXT NOT NULL,
    CONSTRAINT SRC_INVENTORY:inventory_stock_levels:FK:1 FOREIGN KEY (product_id) REFERENCES inventory_products (product_id),
    CONSTRAINT SRC_INVENTORY:inventory_stock_levels:FK:0 FOREIGN KEY (location_id) REFERENCES inventory_locations (location_id),
    CONSTRAINT SRC_INVENTORY:inventory_stock_levels:PRIMARY_KEY PRIMARY KEY (stock_id)
);

CREATE TABLE inventory_transaction_lines (
    line_id INTEGER,
    transaction_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_cost REAL NOT NULL,
    line_total REAL NOT NULL,
    CONSTRAINT SRC_INVENTORY:inventory_transaction_lines:FK:0 FOREIGN KEY (product_id) REFERENCES inventory_products (product_id),
    CONSTRAINT SRC_INVENTORY:inventory_transaction_lines:FK:1 FOREIGN KEY (transaction_id) REFERENCES inventory_transactions (transaction_id),
    CONSTRAINT SRC_INVENTORY:inventory_transaction_lines:PRIMARY_KEY PRIMARY KEY (line_id)
);

CREATE TABLE inventory_transactions (
    transaction_id INTEGER,
    location_id INTEGER NOT NULL,
    transaction_date TEXT NOT NULL,
    transaction_type TEXT NOT NULL,
    CONSTRAINT SRC_INVENTORY:inventory_transactions:FK:0 FOREIGN KEY (location_id) REFERENCES inventory_locations (location_id),
    CONSTRAINT SRC_INVENTORY:inventory_transactions:PRIMARY_KEY PRIMARY KEY (transaction_id)
);
