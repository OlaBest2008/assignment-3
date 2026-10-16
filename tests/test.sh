#!/usr/bin/env bash

PASS=0
FAIL=0

pass() { echo "PASS: $1"; PASS=$((PASS + 1)); }
fail() { echo "FAIL: $1"; FAIL=$((FAIL + 1)); }

APP="./app/app.sh"

echo "Running Application Tests..."

# 1. help
"$APP" help >/dev/null 2>&1
[ $? -eq 0 ] && pass "Help command succeeds" || fail "Help command failed"

# 2. system-info
"$APP" system-info >/dev/null 2>&1
[ $? -eq 0 ] && pass "System-info command succeeds" || fail "System-info failed"

# 3. invalid command
"$APP" bad-cmd >/dev/null 2>&1
[ $? -eq 2 ] && pass "Invalid command returns 2" || fail "Invalid command failed"

# 4. missing host
"$APP" check-host >/dev/null 2>&1
[ $? -eq 2 ] && pass "Missing host returns 2" || fail "Missing host failed"

# 5. valid host
"$APP" check-host localhost >/dev/null 2>&1
[ $? -eq 0 ] && pass "Valid host succeeds" || fail "Valid host failed"

# 6. missing port
"$APP" check-port localhost >/dev/null 2>&1
[ $? -eq 2 ] && pass "Missing port returns 2" || fail "Missing port failed"

# 7. non-numeric port
"$APP" check-port localhost abc >/dev/null 2>&1
[ $? -eq 2 ] && pass "Non-numeric port returns 2" || fail "Non-numeric port failed"

# 8. out-of-range port
"$APP" check-port localhost 65536 >/dev/null 2>&1
[ $? -eq 2 ] && pass "Out-of-range port returns 2" || fail "Out-of-range port failed"

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
exit 0