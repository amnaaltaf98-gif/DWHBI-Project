# Inventory Database - Reverse Engineered ERD

```mermaid
erDiagram
    inventory_products ||--o{ inventory_stock_levels : tracks
    inventory_locations ||--o{ inventory_stock_levels : stores
    inventory_products ||--o{ inventory_transaction_lines : includes
    inventory_transactions ||--o{ inventory_transaction_lines : contains
    inventory_locations ||--o{ inventory_transactions : occurs_at

    inventory_products {
        integer product_id PK
    }
    inventory_locations {
        integer location_id PK
    }
    inventory_stock_levels {
        integer stock_id PK
        integer product_id FK
        integer location_id FK
    }
    inventory_transactions {
        integer transaction_id PK
        integer location_id FK
    }
    inventory_transaction_lines {
        integer line_id PK
        integer transaction_id FK
        integer product_id FK
    }
```

## Evidence
- Source system: SRC_INVENTORY
- Database engine: SQLite
- Schema: main
- Tables: 5
- Columns: 22
- Primary keys: 5
- Foreign keys: 5
- Relationships shown are declared source constraints.