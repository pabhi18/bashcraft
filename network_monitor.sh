#!/bin/bash


##############################################################################
# Author: Abhinav Pratap
# Version: v0.0.1
#
# Description:
# This script monitors network connectivity and bandwidth usage on a specified 
# network interface. It periodically checks the network status by pinging a 
# target host and calculates the download and upload speeds.
#
# Features:
# - Checks network connectivity by pinging a predefined target.
# - Monitors bandwidth usage by measuring received and transmitted bytes.
# - Displays real-time download and upload speeds in KB/s.
# - Runs continuously at a specified interval.
#
# Usage:
# ./network_monitor.sh
#
# Example:
# ./network_monitor.sh
##############################################################################


TARGET_HOST="8.8.8.8"
NETWORK_INTERFACE="eth0"
INTERVAL=5

# Function to Check Network connectivity
check_connectivity() {
    echo "Checking Network Connectivity..."

    if ping -c 1 -W 1 $TARGET_HOST > /dev/null 2>&1; then
        echo "$(date): Network is UP"
    else
        echo "$(date): Network is DOWN"
    fi
}

# Function to Monitors bandwidth usage by measuring received and transmitted bytes
monitor_bandwidth(){
    echo "Monitoring bandwidth usage..."
    RX_BYTES_BEFORE=$(netstat -ib | grep -m1 -e "$NETWORK_INTERFACE" | awk '{print $7}')
    TX_BYTES_BEFORE=$(netstat -ib | grep -m1 -e "$NETWORK_INTERFACE" | awk '{print $10}')

    sleep $INTERVAL

    RX_BYTES_AFTER=$(netstat -ib | grep -m1 -e "$NETWORK_INTERFACE" | awk '{print $7}')
    TX_BYTES_AFTER=$(netstat -ib | grep -m1 -e "$NETWORK_INTERFACE" | awk '{print $10}')

    RX_RATE=$(( (RX_BYTES_AFTER - RX_BYTES_BEFORE) / INTERVAL ))
    TX_RATE=$(( (TX_BYTES_AFTER - TX_BYTES_BEFORE) / INTERVAL ))

    RX_RATE_KB=$(( RX_RATE / 1024 ))
    TX_RATE_KB=$(( TX_RATE / 1024 ))

    echo "$(date): Download Speed: $RX_RATE_KB KB/s | Upload Speed: $TX_RATE_KB KB/s"
}


while true; do
    check_connectivity
    monitor_bandwidth
    echo "--------------------------------------"
    sleep $INTERVAL
done

