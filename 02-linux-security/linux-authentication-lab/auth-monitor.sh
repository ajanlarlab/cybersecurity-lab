#!/usr/bin/env bash

# Linux Authentication Monitor
# Version: 1.0.0
# Category: Blue Team / SOC

set -u

TIME_WINDOW="10 minutes ago"
HIGH_THRESHOLD=3

# Read authentication logs
if ! logs=$(sudo journalctl _COMM=sudo --since "$TIME_WINDOW" --no-pager); then
    echo "[ERROR] Unable to read authentication logs." >&2
    exit 1
fi

# Count authentication failure records
count=$(grep -ic "authentication failure" <<< "$logs")
grep_status=$?

if [ "$grep_status" -gt 1 ]; then
    echo "[ERROR] Log analysis failed." >&2
    exit 1
fi

echo "========================================"
echo " Linux Authentication Monitor v1.0.0"
echo "========================================"
echo "Analysis date: $(date)"
echo "Time window: Last 10 minutes"
echo "Authentication failure records: $count"
echo "----------------------------------------"

# Evaluate security alert level
if [ "$count" -ge "$HIGH_THRESHOLD" ]; then
    echo "[HIGH] Repeated authentication failures detected."
elif [ "$count" -ge 1 ]; then
    echo "[WARNING] Authentication failure detected."
else
    echo "[NORMAL] No matching authentication failure records."
fi

echo "========================================"

exit 0
