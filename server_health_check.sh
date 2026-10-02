 #!/bin/bash

health_status="OK"

echo "=============================="
echo " LINUX SERVER HEALTH CHECK"
echo "=============================="
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo "Uptime: $(uptime)"
echo 
echo "----- MEMORY CHECK -----"
free -h
memory_usage=$(free | awk '/Mem:/ {print $3/$2*100}')
echo "memory usage: ${memory_usage}%"
if (( ${memory_usage%.*} >= 80 )); then
echo "Status: WARNING"
health_status="WARNING"
else
echo "Status: OK"
fi
echo 
echo "----- CPU CHECK -----"
top -bn1 | grep "Cpu(s)"
cpu_usage=$(top -bn1 | awk -F',' '/Cpu\(s\)/ {print 100 - $4}')
echo "CPU Usage: ${cpu_usage}%"
if (( ${cpu_usage%.*} >= 80 )); then
echo "Status: WARNING"
health_status="WARNING"
else
echo "Status: OK"
fi

echo 
echo "----- DISK CHECK -----"
df -h
echo 
echo "------ DISK STATUS ------"
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
echo "Disk Usage: $disk_usage%"
if [ "$disk_usage" -ge 80 ]; then
echo "Status: WARNING"
health_status: "WARNING"
else 
echo "Status: ok"
fi 


echo 
echo "-------- SERVICE CHECK --------"

ssh_status=$(systemctl is-active sshd)
echo "SSH Service: $ssh_status"

if [ "$ssh_status" = "active" ]; then 
echo "Status: OK"
else 
echo "Status: WARNING"
health_status="WARNING"
fi



echo 
echo "-------- NETWORK CHECK --------"

if ping -c 4 8.8.8.8 > /dev/null 2>&1;
then 
echo "Internet Connectivity: OK"
else 
echo "Internet Connectivity: WARRNING"
health_status="WARNING"
fi


echo 
echo "-------- APACHE SERVICE CHECK --------"

apache_status=$(systemctl is-active httpd)

echo "Apache Service: $apache_status"

if [ "$apache_status" = "active" ];
then
echo "Status: OK"
else
echo "Status: WARNING"
health_status="WARNING"
fi


echo 
echo "==============================================="
echo "       SERVER HEALTH SUMMARY"
echo "==============================================="

echo "Overall Status:  $health_status"

echo "================================================"
