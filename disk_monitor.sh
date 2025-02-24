#!/bin/bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

send_alert() {
  echo "$(tput setaf 1)ALERT: $1 usage exceeded threshold! Current value: $2%$(tput sgr0)"
}

while true; do
  ## Monitor CPU
  cpu_usage=$(top -l 1 | grep -i "CPU usage" | awk '{print $3 + $5}')
  cpu_usage=${cpu_usage%.*}
  if ((cpu_usage >= CPU_THRESHOLD)); then
    send_alert "CPU" "$cpu_usage"
  fi

  ## Monitor memory
  total_usage=$(sysctl -n hw.memsize)
  memory_usage=$(vm_stat | awk '/Pages active/ {print $3}' | awk -v total="$total_usage" '{printf "%.1f", ($1 * 16384) / total * 100}')
  memory_usage=${memory_usage%.*}
  if ((memory_usage >= MEMORY_THRESHOLD)); then
    send_alert "Memory" "$memory_usage"
  fi

  ## Monitor disk
  disk_usage=$(df -h / | awk 'NR==2 {print $5}')
  disk_usage=${disk_usage%\%}  # Remove '%' symbol
  if ((disk_usage >= DISK_THRESHOLD)); then
    send_alert "Disk" "$disk_usage"
  fi

  ## Display current stats
  clear
  echo "Resource Usage:"
  echo "CPU: $cpu_usage%"
  echo "Memory: $memory_usage%"
  echo "Disk: $disk_usage%"
  sleep 2
done

