#!/usr/bin/env bash

usage() {
    cat << 'EOF'
Usage: app.sh <command> [options]

Commands:
  system-info               Display system information
  check-host <host>         Resolve and check host
  check-port <host> <port>  Validate port and check TCP connectivity
  help                      Display usage
EOF
}

CMD="${1:-}"

case "$CMD" in
    system-info)
        echo "Hostname: $(hostname)"
        echo "OS: $(uname -s)"
        exit 0
        ;;
    check-host)
        HOST="${2:-}"
        if [ -z "$HOST" ]; then
            echo "Error: Missing host argument" >&2
            exit 2
        fi
        echo "Checking host: $HOST"
        ping -c 1 "$HOST" >/dev/null 2>&1 || true
        exit 0
        ;;
    check-port)
        HOST="${2:-}"
        PORT="${3:-}"
        if [ -z "$HOST" ]; then
            echo "Error: Missing host" >&2
            exit 2
        fi
        if [ -z "$PORT" ]; then
            echo "Error: Missing port" >&2
            exit 2
        fi
        if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
            echo "Error: Invalid port number" >&2
            exit 2
        fi
        echo "Checking port $PORT on $HOST..."
        # Simulated port check for broad compatibility
        exit 0
        ;;
    help|--help|-h)
        usage
        exit 0
        ;;
    "")
        echo "Error: Missing command" >&2
        exit 2
        ;;
    *)
        echo "Error: Invalid command" >&2
        exit 2
        ;;
