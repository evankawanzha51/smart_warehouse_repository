import mysql.connector
import random
from datetime import datetime, timedelta

# =========================
# KONFIGURASI DATABASE
# =========================

HOST = "localhost"
USER = "root"
PASSWORD = ""
DATABASE = "smart_warehouse"

JUMLAH_DATA = 1000

# =========================
# MASTER ITEM
# =========================

items = [
    ("ITM001", "Sensor Suhu", "Elektronik"),
    ("ITM002", "Bearing", "Mekanik"),
    ("ITM003", "Relay", "Elektrikal"),
    ("ITM004", "Motor DC", "Elektrikal"),
    ("ITM005", "Contactor", "Elektrikal"),
    ("ITM006", "Push Button", "Elektronik"),
    ("ITM007", "MCB", "Elektrikal"),
    ("ITM008", "Limit Switch", "Elektronik"),
    ("ITM009", "Encoder", "Elektronik"),
    ("ITM010", "Kabel NYA", "Elektrikal")
]

rack_locations = [
    "A01","A02","A03",
    "B01","B02","B03",
    "C01","C02","C03"
]

operators = [
    "Operator_A",
    "Operator_B",
    "Operator_C"
]

status_list = [
    "Completed",
    "Verified",
    "Stored"
]

# =========================
# KONEKSI DATABASE
# =========================

db = mysql.connector.connect(
    host=HOST,
    user=USER,
    password=PASSWORD,
    database=DATABASE
)

cursor = db.cursor()

# =========================
# QUERY INSERT
# =========================

query = """
INSERT INTO inventory_transactions
(
transaction_time,
item_code,
item_name,
category,
transaction_type,
quantity,
rack_location,
operator_name,
status
)

VALUES
(%s,%s,%s,%s,%s,%s,%s,%s,%s)
"""

# =========================
# MEMBUAT DATA HISTORIS
# =========================

base_time = datetime.now() - timedelta(days=30)

for i in range(JUMLAH_DATA):

    item_code, item_name, category = random.choice(items)

    transaction_time = base_time + timedelta(
        minutes=random.randint(0, 43200)
    )

    transaction_type = random.choice([
        "MASUK",
        "KELUAR"
    ])

    quantity = random.randint(1, 25)

    rack_location = random.choice(rack_locations)

    operator_name = random.choice(operators)

    status = random.choice(status_list)

    data = (
        transaction_time,
        item_code,
        item_name,
        category,
        transaction_type,
        quantity,
        rack_location,
        operator_name,
        status
    )

    cursor.execute(query, data)

db.commit()

print(f"{JUMLAH_DATA} transaksi berhasil dibuat.")

cursor.close()
db.close()

print("Database connection closed.")