#!/bin/bash

OUTPUT=$(python3 "${APP_HOME}/test.py")
echo "Score:"
echo "$OUTPUT"
if [[ $(echo "$OUTPUT 0.50" | awk '{print ($1 < $2)}') == 1 ]]; then
    echo "Insufficient Accuracy"
    exit 1
fi
