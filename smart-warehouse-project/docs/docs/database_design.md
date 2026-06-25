# Database Design

Database Name:
smart_warehouse

## Table: inventory_transactions

Purpose:
Store warehouse transaction history.

Columns:

* id
* transaction_time
* item_code
* item_name
* category
* transaction_type
* quantity
* rack_location
* operator_name
* status

## Future Tables

* master_items
* plc_commands
* plc_feedback
* warehouse_status
