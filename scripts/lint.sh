#!/usr/bin/env bash

echo "Running linting checks..."

FILES=("app/app.sh" "scripts/lint.sh" "scripts/build.sh" "tests/test.sh")

for f in "${FILES[@]}"; do
    if [ ! -f "$f" ]; then
        echo "Lint Error: Missing required file $f" >&2
        exit 1
    fi
    bash -n "$f" || { echo "Syntax error in $f"; exit 1; }
done

echo "Linting passed successfully."
exit 0