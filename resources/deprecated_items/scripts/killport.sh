#!/bin/bash

# Check if port number is provided as argument
if [ -z "$1" ]; then
  echo "Usage: $0 <port>"
  exit 1
fi

# Get the port number from the argument
port="$1"

# Find the process ID (PID) using the given port
pid=$(lsof -t -i :"$port")

# Check if a process is running on the specified port
if [ -z "$pid" ]; then
  echo "No process found using port $port"
else
  # Kill the process using the obtained PID
  kill -9 "$pid"
  echo "Process with PID $pid killed, which was using port $port"
fi
