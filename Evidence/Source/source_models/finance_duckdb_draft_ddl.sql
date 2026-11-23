-- Reverse-engineered draft DDL
-- Source: Finance DuckDB database
-- Reconstructed from captured metadata

CREATE TABLE finance_accounts (
    account_id INTEGER NOT NULL,
    account_name VARCHAR NOT NULL,
    account_type VARCHAR NOT NULL,
    PRIMARY KEY (account_id)
);

CREATE TABLE finance_budgets (
    budget_id INTEGER NOT NULL,
    department_id INTEGER NOT NULL,
    budget_month DATE NOT NULL,
    budget_amount DECIMAL(14,2) NOT NULL,
    PRIMARY KEY (budget_id),
    FOREIGN KEY (department_id) REFERENCES finance_departments (department_id)
);

CREATE TABLE finance_departments (
    department_id INTEGER NOT NULL,
    department_name VARCHAR NOT NULL,
    PRIMARY KEY (department_id)
);

CREATE TABLE finance_transaction_lines (
    line_id INTEGER NOT NULL,
    transaction_id INTEGER NOT NULL,
    amount DECIMAL(14,2) NOT NULL,
    entry_type VARCHAR NOT NULL,
    PRIMARY KEY (line_id),
    FOREIGN KEY (transaction_id) REFERENCES finance_transactions (transaction_id)
);

CREATE TABLE finance_transactions (
    transaction_id INTEGER NOT NULL,
    department_id INTEGER NOT NULL,
    account_id INTEGER NOT NULL,
    transaction_date DATE NOT NULL,
    description VARCHAR,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (department_id) REFERENCES finance_departments (department_id),
    FOREIGN KEY (account_id) REFERENCES finance_accounts (account_id)
);
