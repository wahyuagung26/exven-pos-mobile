-- Schema Database untuk Aplikasi POS Offline-First (SQLite)
-- Updated with UUID v7 and standardized timestamps
-- Simplified for device-only operations

-- =============================================
-- SCHEMA VERSION TRACKING
-- =============================================

CREATE TABLE schema_version (
    version INTEGER PRIMARY KEY,
    applied_at INTEGER DEFAULT (strftime('%s', 'now') * 1000)
);

-- Insert initial version
INSERT INTO schema_version (version) VALUES (1);

-- =============================================
-- BASIC OUTLET & USER INFO
-- =============================================

-- Simplified outlet info (single outlet per device)
CREATE TABLE outlets (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    code TEXT NOT NULL UNIQUE,
    description TEXT,
    address TEXT,
    city TEXT,
    province TEXT,
    postal_code TEXT,
    phone TEXT,
    email TEXT,
    settings TEXT, -- JSON string for offline settings
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL
);

-- Basic user info for offline operation
CREATE TABLE users (
    id TEXT PRIMARY KEY,
    outlet_id TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'cashier', -- cashier, manager, owner
    email TEXT,
    full_name TEXT NOT NULL,
    phone TEXT,
    is_active INTEGER DEFAULT 1, -- SQLite doesn't have native boolean
    last_login_at INTEGER DEFAULT NULL,
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL,
    
    FOREIGN KEY (outlet_id) REFERENCES outlets(id)
);

-- =============================================
-- PRODUCT MANAGEMENT
-- =============================================

-- Simplified product categories
CREATE TABLE product_categories (
    id TEXT PRIMARY KEY,
    parent_id TEXT DEFAULT NULL,
    name TEXT NOT NULL,
    description TEXT,
    sort_order INTEGER DEFAULT 0,
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL,
    
    FOREIGN KEY (parent_id) REFERENCES product_categories(id)
);

-- Products table optimized for offline use
CREATE TABLE products (
    id TEXT PRIMARY KEY,
    category_id TEXT,
    sku TEXT NOT NULL UNIQUE,
    barcode TEXT,
    name TEXT NOT NULL,
    description TEXT,
    unit TEXT DEFAULT 'pcs',
    cost_price REAL DEFAULT 0.00,
    selling_price REAL NOT NULL,
    current_stock INTEGER DEFAULT 0, -- Simple current stock tracking
    min_stock INTEGER DEFAULT 0,
    track_stock INTEGER DEFAULT 1, -- 1 = true, 0 = false
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL,
    
    FOREIGN KEY (category_id) REFERENCES product_categories(id)
);

-- =============================================
-- CUSTOMER MANAGEMENT (SIMPLIFIED)
-- =============================================

-- Basic customer info
CREATE TABLE customers (
    id TEXT PRIMARY KEY,
    code TEXT UNIQUE,
    name TEXT NOT NULL,
    email TEXT,
    phone TEXT,
    address TEXT,
    total_spent REAL DEFAULT 0.00,
    visit_count INTEGER DEFAULT 0,
    last_visit_at INTEGER DEFAULT NULL,
    notes TEXT,
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL
);

-- =============================================
-- TRANSACTIONS
-- =============================================

-- Main transactions table with snapshots for offline reliability
CREATE TABLE transactions (
    id TEXT PRIMARY KEY,
    outlet_id TEXT NOT NULL,
    cashier_id TEXT NOT NULL,
    customer_id TEXT DEFAULT NULL,
    -- Snapshot data for offline reliability
    customer_name_snapshot TEXT,
    customer_phone_snapshot TEXT,
    cashier_name_snapshot TEXT NOT NULL,
    outlet_name_snapshot TEXT NOT NULL,
    outlet_code_snapshot TEXT NOT NULL,
    -- Transaction data
    transaction_number TEXT NOT NULL UNIQUE,
    transaction_date INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    subtotal REAL NOT NULL,
    discount_amount REAL DEFAULT 0.00,
    tax_amount REAL DEFAULT 0.00,
    total_amount REAL NOT NULL,
    paid_amount REAL NOT NULL,
    change_amount REAL DEFAULT 0.00,
    payment_method TEXT NOT NULL, -- cash, transfer, card, ewallet
    status TEXT DEFAULT 'completed', -- completed, cancelled
    notes TEXT,
    -- Sync tracking
    synced_to_cloud INTEGER DEFAULT 0, -- 0 = not synced, 1 = synced
    cloud_transaction_id TEXT DEFAULT NULL, -- ID from cloud after sync
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL,
    
    FOREIGN KEY (outlet_id) REFERENCES outlets(id),
    FOREIGN KEY (cashier_id) REFERENCES users(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Transaction items with product snapshots
CREATE TABLE transaction_items (
    id TEXT PRIMARY KEY,
    transaction_id TEXT NOT NULL,
    product_id TEXT NOT NULL,
    -- Product snapshots for historical accuracy
    product_name_snapshot TEXT NOT NULL,
    product_sku_snapshot TEXT NOT NULL,
    product_category_snapshot TEXT,
    product_unit_snapshot TEXT DEFAULT 'pcs',
    -- Transaction item data
    quantity INTEGER NOT NULL,
    unit_price REAL NOT NULL,
    cost_price_snapshot REAL DEFAULT 0.00,
    discount_amount REAL DEFAULT 0.00,
    total_price REAL NOT NULL,
    notes TEXT,
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL,
    
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Multiple payment methods support
CREATE TABLE transaction_payments (
    id TEXT PRIMARY KEY,
    transaction_id TEXT NOT NULL,
    payment_method TEXT NOT NULL, -- cash, card, transfer, ewallet
    amount REAL NOT NULL,
    reference_number TEXT, -- For non-cash payments
    notes TEXT,
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL,
    
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE
);

-- =============================================
-- CASH MANAGEMENT (SHIFT TRACKING)
-- =============================================

-- Simple cash drawer/shift management
CREATE TABLE cash_shifts (
    id TEXT PRIMARY KEY,
    outlet_id TEXT NOT NULL,
    cashier_id TEXT NOT NULL,
    cashier_name_snapshot TEXT NOT NULL,
    shift_start INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    shift_end INTEGER DEFAULT NULL,
    opening_balance REAL DEFAULT 0.00,
    closing_balance REAL DEFAULT NULL,
    expected_cash REAL DEFAULT NULL,
    cash_sales REAL DEFAULT 0.00,
    non_cash_sales REAL DEFAULT 0.00,
    total_transactions INTEGER DEFAULT 0,
    notes TEXT,
    status TEXT DEFAULT 'open', -- open, closed
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL,
    
    FOREIGN KEY (outlet_id) REFERENCES outlets(id),
    FOREIGN KEY (cashier_id) REFERENCES users(id)
);

-- =============================================
-- EXPENSES TRACKING
-- =============================================

-- Simple expense tracking for daily operations
CREATE TABLE expenses (
    id TEXT PRIMARY KEY,
    outlet_id TEXT NOT NULL,
    cashier_id TEXT NOT NULL,
    cashier_name_snapshot TEXT NOT NULL,
    category TEXT NOT NULL, -- operasional, bahan_baku, transport, dll
    description TEXT NOT NULL,
    amount REAL NOT NULL,
    expense_date INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    receipt_photo TEXT, -- Base64 or file path
    notes TEXT,
    -- Sync tracking
    synced_to_cloud INTEGER DEFAULT 0,
    cloud_expense_id TEXT DEFAULT NULL,
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    deleted_at INTEGER DEFAULT NULL,
    
    FOREIGN KEY (outlet_id) REFERENCES outlets(id),
    FOREIGN KEY (cashier_id) REFERENCES users(id)
);

-- =============================================
-- SYNC TRACKING & CLOUD BACKUP
-- =============================================

-- Track which records need to be synced to cloud
CREATE TABLE sync_queue (
    id TEXT PRIMARY KEY,
    table_name TEXT NOT NULL,
    record_id TEXT NOT NULL,
    operation TEXT NOT NULL, -- insert, update, delete
    data TEXT, -- JSON string of the record
    retry_count INTEGER DEFAULT 0,
    last_error TEXT DEFAULT NULL,
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000)
);

-- Track sync history for debugging
CREATE TABLE sync_history (
    id TEXT PRIMARY KEY,
    sync_type TEXT NOT NULL, -- manual, auto, scheduled
    records_synced INTEGER DEFAULT 0,
    records_failed INTEGER DEFAULT 0,
    sync_start INTEGER DEFAULT (strftime('%s', 'now') * 1000),
    sync_end INTEGER DEFAULT NULL,
    status TEXT DEFAULT 'running', -- running, completed, failed
    error_message TEXT DEFAULT NULL,
    created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000)
);

-- =============================================
-- APP SETTINGS & CONFIGURATION
-- =============================================

-- Local app settings and preferences
CREATE TABLE app_settings (
    key TEXT PRIMARY KEY,
    value TEXT,
    description TEXT,
    updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000)
);

-- Insert default settings
INSERT INTO app_settings (key, value, description) VALUES 
('app_version', '1.0.0', 'Current app version'),
('last_backup', NULL, 'Last successful backup timestamp'),
('auto_backup_enabled', '1', 'Enable automatic cloud backup'),
('receipt_printer_enabled', '0', 'Enable receipt printer'),
('low_stock_alert', '1', 'Enable low stock alerts'),
('tax_enabled', '0', 'Enable tax calculation'),
('default_tax_rate', '11.0', 'Default tax rate percentage'),
('currency_symbol', 'Rp', 'Currency symbol for display'),
('receipt_footer_text', 'Terima kasih atas kunjungan Anda!', 'Footer text for receipts');

-- =============================================
-- INDEXES FOR PERFORMANCE
-- =============================================

-- Indexes for better query performance
CREATE INDEX idx_products_sku ON products(sku) WHERE deleted_at IS NULL;
CREATE INDEX idx_products_barcode ON products(barcode) WHERE deleted_at IS NULL;
CREATE INDEX idx_products_name ON products(name) WHERE deleted_at IS NULL;
CREATE INDEX idx_products_category ON products(category_id) WHERE deleted_at IS NULL;

CREATE INDEX idx_transactions_date ON transactions(transaction_date) WHERE deleted_at IS NULL;
CREATE INDEX idx_transactions_cashier ON transactions(cashier_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_transactions_status ON transactions(status) WHERE deleted_at IS NULL;
CREATE INDEX idx_transactions_sync ON transactions(synced_to_cloud) WHERE deleted_at IS NULL;

CREATE INDEX idx_transaction_items_transaction ON transaction_items(transaction_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_transaction_items_product ON transaction_items(product_id) WHERE deleted_at IS NULL;

CREATE INDEX idx_customers_phone ON customers(phone) WHERE deleted_at IS NULL;
CREATE INDEX idx_customers_code ON customers(code) WHERE deleted_at IS NULL;

CREATE INDEX idx_cash_shifts_cashier_date ON cash_shifts(cashier_id, shift_start) WHERE deleted_at IS NULL;
CREATE INDEX idx_cash_shifts_status ON cash_shifts(status) WHERE deleted_at IS NULL;

CREATE INDEX idx_expenses_date ON expenses(expense_date) WHERE deleted_at IS NULL;
CREATE INDEX idx_expenses_category ON expenses(category) WHERE deleted_at IS NULL;
CREATE INDEX idx_expenses_sync ON expenses(synced_to_cloud) WHERE deleted_at IS NULL;

CREATE INDEX idx_sync_queue_table_operation ON sync_queue(table_name, operation);
CREATE INDEX idx_sync_queue_retry ON sync_queue(retry_count);

-- =============================================
-- VIEWS FOR COMMON QUERIES
-- =============================================

-- View for daily sales summary
CREATE VIEW daily_sales_summary AS
SELECT 
    DATE(transaction_date / 1000, 'unixepoch', 'localtime') as sale_date,
    COUNT(*) as total_transactions,
    SUM(total_amount) as total_sales,
    SUM(CASE WHEN payment_method = 'cash' THEN total_amount ELSE 0 END) as cash_sales,
    SUM(CASE WHEN payment_method != 'cash' THEN total_amount ELSE 0 END) as non_cash_sales,
    AVG(total_amount) as average_transaction
FROM transactions 
WHERE deleted_at IS NULL AND status = 'completed'
GROUP BY DATE(transaction_date / 1000, 'unixepoch', 'localtime')
ORDER BY sale_date DESC;

-- View for top selling products
CREATE VIEW top_selling_products AS
SELECT 
    ti.product_id,
    ti.product_name_snapshot as product_name,
    ti.product_sku_snapshot as product_sku,
    SUM(ti.quantity) as total_quantity,
    SUM(ti.total_price) as total_revenue,
    COUNT(DISTINCT ti.transaction_id) as transaction_count
FROM transaction_items ti
JOIN transactions t ON ti.transaction_id = t.id
WHERE ti.deleted_at IS NULL 
    AND t.deleted_at IS NULL 
    AND t.status = 'completed'
GROUP BY ti.product_id, ti.product_name_snapshot, ti.product_sku_snapshot
ORDER BY total_quantity DESC;

-- View for low stock products
CREATE VIEW low_stock_products AS
SELECT 
    id,
    sku,
    name,
    current_stock,
    min_stock,
    (min_stock - current_stock) as stock_deficit
FROM products 
WHERE deleted_at IS NULL 
    AND track_stock = 1 
    AND current_stock <= min_stock
ORDER BY stock_deficit DESC;

-- =============================================
-- NOTE: NO TRIGGERS - ALL LOGIC IN SERVICE LAYER
-- =============================================

-- All business logic operations will be handled in Flutter/Dart service layer:
-- 1. updated_at fields will be managed by service methods
-- 2. Customer stats updates handled by TransactionService
-- 3. Product stock updates handled by InventoryService  
-- 4. Sync queue managed by SyncService
-- 5. Manual transaction management for data consistency
--
-- Benefits:
-- - Predictable performance
-- - Easy debugging and testing
-- - Explicit error handling
-- - Better separation of concerns
-- - No hidden side effects