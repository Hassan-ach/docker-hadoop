#!/usr/bin/env python3
import sys

current_service = None
users = set()

for line in sys.stdin:
    service, user_id = line.strip().split("\t")

    if current_service == service:
        users.add(user_id)
    else:
        if current_service:
            print(f"{current_service}\t{len(users)}")
        current_service = service
        users = {user_id}

if current_service:
    print(f"{current_service}\t{len(users)}")

