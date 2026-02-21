#!/usr/bin/env python3
import sys

current_key = None
current_count = 0

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    
    parts = line.split("\t")
    if len(parts) != 2:
        continue
    
    key = parts[0]
    value = int(parts[1])

    if current_key == key:
        current_count += value
    else:
        if current_key:
            print(current_key + "\t" + str(current_count))
        current_key = key
        current_count = value

if current_key:
    print(current_key + "\t" + str(current_count))
