#!/usr/bin/env bash

IMAGE="devops-tool"
echo "Building Docker image..."
docker build -t "$IMAGE" .

echo "Running Docker smoke tests..."
docker run --rm "$IMAGE" help >/dev/null 2>&1
if [ $? -ne 0 ]; then echo "Docker help test failed"; exit 1; fi

docker run --rm "$IMAGE" system-info >/dev/null 2>&1
if [ $? -ne 0 ]; then echo "Docker system-info test failed"; exit 1; fi

docker run --rm "$IMAGE" invalid-command >/dev/null 2>&1
if [ $? -eq 0 ]; then echo "Docker invalid-command test failed"; exit 1; fi

echo "Docker smoke tests passed!"
exit 0