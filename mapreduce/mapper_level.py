#!/usr/bin/env python3
import sys

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue

    parts = line.split()
    if len(parts) < 2:
        continue

    level = parts[1].strip("[]")
    print(f"{level}\t1")

