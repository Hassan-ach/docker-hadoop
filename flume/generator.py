import random
import time
from datetime import datetime
import os

LEVELS = ["INFO", "DEBUG", "WARN", "ERROR"]
SERVICES = ["auth", "payment", "search", "gateway"]
MESSAGES = [
    "Request processed",
    "User login",
    "Timeout",
    "DB connection",
    "Cache miss",
]

def generate():
    ts = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")
    level = random.choice(LEVELS)
    svc = random.choice(SERVICES)
    msg = random.choice(MESSAGES)
    uid = random.randint(1000, 9999)
    return "{} [{}] {} user={} {}".format(ts, level, svc, uid, msg)

if __name__ == "__main__":
    interval = float(os.environ.get("LOG_INTERVAL", 1))
    while True:
        print(generate(), flush=True)
        time.sleep(interval)

