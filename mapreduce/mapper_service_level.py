#!/usr/bin/env python3
import sys

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue

    parts = line.split()
    if len(parts) < 3:
        continue

    level = parts[1].strip("[]")
    service = parts[2]

    print(service + " " + level + "\t1")
