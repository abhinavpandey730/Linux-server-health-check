# Linux Server Health Check System

A Bash-based Linux server monitoring tool that checks system health and reports potential issues.

## Features

- Checks CPU usage and detects high CPU utilization
- Moniters memory usage and detects high memory utilization
- Monitores disk usage and provides warning when usage reaches the threshold
- Checks SSH service status
- Checks Apache web server service status
- Checks network connectivity
- Shows overall server health status
- Genarates timestamped health reports and log files

## Technologies Used

- Linux
- Bash Shell Scripting
- systemd
- Apache HTTP Server

## Health Thresholds

| Check | Threshold | Status |
|----|----|----|
| CPU | 80% or above | WARNING |
| Memory | 80% or above | WARNING |
| Disk | 80% or above | WARNING |

## How to Run

chmod +x server_health_check.sh
./server_health_check.sh

bash server_health_check.sh | tee "logs/health_report_$(date '+%C%y-%m-%d_%H-%m-%S').txt"

## Requirements 

- Red Hat Enterprise Linux (RHEL)
- Bash Shell
- Required Linux commands: free, top, df, ping, systemctl, awk

## Project Purpose 

This project helps linux administrators quickly monitor important server resources and services.
It can identify high resource usages and inactive services before they affect server availability.

## Future Improvements

- Email alerts for critical server issues
- Schedule automatic health checks using cron
- Add monitoring for additional Linux service
