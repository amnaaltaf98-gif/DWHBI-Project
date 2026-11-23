# Sales Database - Reverse Engineered ERD

```mermaid
erDiagram
    sales_customers ||--o{ sales_transactions : places
    sales_locations ||--o{ sales_transactions : occurs_at
    sales_transactions ||--o{ sales_transaction_lines : contains
    sales_products ||--o{ sales_transaction_lines : includes

    sales_customers {
        integer customer_id PK
    }

    sales_locations {
        integer location_id PK
    }

    sales_products {
        integer product_id PK
    }

    sales_transactions {
        integer transaction_id PK
        integer customer_id FK
        integer location_id FK
    }

    sales_transaction_lines {
        integer line_id PK
        integer transaction_id FK
        integer product_id FK
    }
```

## Evidence
- Source system: SRC_SALES
- Database engine: PostgreSQL
- Schema: public
- Tables: 5
- Columns: 23
- Primary keys: 5
- Foreign keys: 4
- Relationships shown are declared source constraints.