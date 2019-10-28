#!/bin/bash

echo "Testing for port 3004"
while [ -n "$(nc -z localhost 30004 > /dev/null)" ]; do
  sleep 0.1
  echo "test"
done

echo "Port is open, wait for ready"


sleep 3
echo -n "Confirming safety parameters ... "
echo "confirm user safety parameters" | nc localhost 30001 > /dev/null
echo "done "
