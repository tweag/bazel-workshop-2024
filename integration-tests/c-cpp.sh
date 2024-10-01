#!/usr/bin/env bash

set -e

CLIENT="$1"
SERVER="$2"

"$SERVER" &
SERVER_PID="$!"

trap 'kill $SERVER_PID' HUP INT QUIT ABRT ALRM TERM

sleep 2

BASE_URL="http://localhost:9999"

ORDER_PLACED_0=$("$CLIENT" -u "$BASE_URL" -o -f chocolate -n 3)
ORDER_PLACED_1=$("$CLIENT" -u "$BASE_URL" -o -f vanilla -n 1)
ORDER_STATUS_0=$("$CLIENT" -u "$BASE_URL" -s 0)
ORDER_STATUS_1=$("$CLIENT" -u "$BASE_URL" -s 1)

test "$ORDER_PLACED_0" = '{"id":0,"desired_number":3,"flavor":"chocolate"}'
test "$ORDER_PLACED_1" = '{"id":1,"desired_number":1,"flavor":"vanilla"}'
test "$ORDER_STATUS_0" = '{"status":"IN_PREPARATION","id":0}'
test "$ORDER_STATUS_1" = '{"status":"IN_DELIVERY","id":1}'

kill "$SERVER_PID"
