#!/usr/bin/env python3
import sys

current_service = None
users = set()

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    
    parts = line.split("\t")
    if len(parts) != 2:
        continue
    
    service = parts[0]
    user_id = parts[1]

    if current_service == service:
        users.add(user_id)
    else:
        if current_service:
            print(current_service + "\t" + str(len(users)))
        current_service = service
        users = set([user_id])

if current_service:
    print(current_service + "\t" + str(len(users)))
