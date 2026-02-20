#!/usr/bin/env python3
import sys

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue

    parts = line.split()
    if len(parts) < 4:
        continue

    service = parts[2]
    user_part = parts[3]

    if user_part.startswith("user="):
        user_id = user_part.split("=")[1]
        print(f"{service}\t{user_id}")

