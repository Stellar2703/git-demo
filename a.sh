#!/bin/bash

# Linux Practice Questions - All Answers Script
# This script runs all answer commands and continues even on errors
# Date: January 28, 2026

echo "=========================================="
echo "Starting Linux Practice Questions Answers"
echo "=========================================="
echo ""

# Question 3 - Disk Usage Analysis and Cleanup
echo "[Q3] Running Disk Usage Analysis and Cleanup..."
cd /home/student/workspace 2>/dev/null && du -h --max-depth=2 . | sort -hr > disk_analysis.txt && echo "=== LARGE FILES ===" >> disk_analysis.txt && find . -type f -size +100k -exec ls -lh {} \; >> disk_analysis.txt 2>/dev/null && echo "=== DUPLICATE FILES ===" >> disk_analysis.txt && find . -type f -exec md5sum {} \; 2>/dev/null | sort | uniq -d -w 32 >> disk_analysis.txt && echo "=== CLEANUP SUMMARY ===" >> disk_analysis.txt && BEFORE=$(du -s . | cut -f1) && find . -name "*.tmp" -o -name "*.cache" | wc -l >> disk_analysis.txt && find . -name "*.tmp" -delete 2>/dev/null && find . -name "*.cache" -delete 2>/dev/null && AFTER=$(du -s . | cut -f1) && echo "Space freed: $((BEFORE - AFTER))KB" >> disk_analysis.txt || true
echo "[Q3] Completed"
echo ""

# Question 8 - Advanced File Search and Filtering
echo "[Q8] Running Advanced File Search and Filtering..."
cd /home/student/logs 2>/dev/null && find . -mtime -2 > security_audit.txt 2>/dev/null && echo "=== ERROR ENTRIES ===" >> security_audit.txt && grep -n "ERROR\|FAILED" *.log >> security_audit.txt 2>/dev/null && echo "=== SUSPICIOUS IPS ===" >> security_audit.txt && awk '{print $1}' access.log 2>/dev/null | sort | uniq -c | awk '$1 > 10 {count++} END {print "Suspicious IPs:", count+0}' >> security_audit.txt || true
echo "[Q8] Completed"
echo ""

# Question 12 - Log Management and Analysis
echo "[Q12] Running Log Management and Analysis..."
cd /home/student/app_logs 2>/dev/null && echo "LOG ANALYSIS REPORT - $(date)" > log_analysis.txt && echo "=== LOG STATISTICS ===" >> log_analysis.txt && for level in ERROR WARN INFO; do echo "$level: $(grep -c "$level" *.log 2>/dev/null)" >> log_analysis.txt; done && echo "=== ERROR SUMMARY ===" >> log_analysis.txt && grep "ERROR" *.log 2>/dev/null | cut -d: -f3- | sort -u > error_summary.txt && echo "Unique errors found: $(wc -l < error_summary.txt)" >> log_analysis.txt && echo "=== LOG ROTATION ===" >> log_analysis.txt && mv application.log application.log.1 2>/dev/null && touch application.log && echo "application.log rotated successfully" >> log_analysis.txt && echo "Old log size: $(du -h application.log.1 2>/dev/null | cut -f1)" >> log_analysis.txt || true
echo "[Q12] Completed"
echo ""

# Question 14 - Comprehensive System Monitoring
echo "[Q14] Running Comprehensive System Monitoring..."
cd /home/student/monitoring 2>/dev/null && echo "SYSTEM MONITORING REPORT - $(date)" > monitoring_report.txt && echo "=== CPU INFORMATION ===" >> monitoring_report.txt && cat /proc/cpuinfo 2>/dev/null | grep "model name" | head -1 >> monitoring_report.txt && echo "=== MEMORY STATUS ===" >> monitoring_report.txt && free -h >> monitoring_report.txt && echo "=== DISK I/O STATS ===" >> monitoring_report.txt && iostat 2>/dev/null >> monitoring_report.txt || echo "iostat not available" >> monitoring_report.txt && echo "=== NETWORK CONNECTIONS ===" >> monitoring_report.txt && ss -tuln 2>/dev/null | head -10 >> monitoring_report.txt || netstat -tuln 2>/dev/null | head -10 >> monitoring_report.txt && echo "=== SYSTEM UPTIME ===" >> monitoring_report.txt && uptime >> monitoring_report.txt && echo "=== PROCESS COUNT ===" >> monitoring_report.txt && ps aux | wc -l >> monitoring_report.txt || true
echo "[Q14] Completed"
echo ""

# Question 15 - File System Integrity Check
echo "[Q15] Running File System Integrity Check..."
cd /home/student/integrity_check 2>/dev/null && echo "FILE INTEGRITY BASELINE - $(date)" > integrity_baseline.txt && echo "=== MD5 CHECKSUMS ===" >> integrity_baseline.txt && find . -type f -exec md5sum {} \; 2>/dev/null >> integrity_baseline.txt && echo "=== SHA256 CHECKSUMS (CONF FILES) ===" >> integrity_baseline.txt && find . -name "*.conf" -exec sha256sum {} \; 2>/dev/null >> integrity_baseline.txt && echo "=== FILE METADATA ===" >> integrity_baseline.txt && find . -type f -exec ls -l {} \; 2>/dev/null >> integrity_baseline.txt && echo "=== SUMMARY ===" >> integrity_baseline.txt && echo "Total files: $(find . -type f 2>/dev/null | wc -l)" >> integrity_baseline.txt && echo "Total size: $(du -sh . 2>/dev/null | cut -f1)" >> integrity_baseline.txt || true
echo "[Q15] Completed"
echo ""

# Question 131 - Process Management
echo "[Q131] Running Process Management..."
ps aux | grep data_processor | grep -v grep > process_report.txt 2>/dev/null && kill -9 $(pgrep data_processor) 2>/dev/null && sleep 2 && echo "Process terminated at $(date)" > termination_log.txt || true
echo "[Q131] Completed"
echo ""

# Question 132 - System Service Configuration
echo "[Q132] Running System Service Configuration..."
systemctl status company-api 2>/dev/null && systemctl enable company-api 2>/dev/null && systemctl start company-api 2>/dev/null && systemctl status company-api > /home/student/service_status.txt 2>/dev/null || true
echo "[Q132] Completed"
echo ""

# Question 133 - User Account and Group Management
echo "[Q133] Running User Account and Group Management..."
groupadd project_team 2>/dev/null && useradd -m -s /bin/bash alice_dev 2>/dev/null && useradd -m -s /bin/bash bob_test 2>/dev/null && useradd -m -s /bin/bash charlie_ops 2>/dev/null && echo "alice_dev:TempPass123!" | chpasswd 2>/dev/null && echo "bob_test:TempPass123!" | chpasswd 2>/dev/null && echo "charlie_ops:TempPass123!" | chpasswd 2>/dev/null && usermod -a -G project_team,sudo alice_dev 2>/dev/null && usermod -a -G project_team bob_test 2>/dev/null && usermod -a -G project_team charlie_ops 2>/dev/null && getent group project_team > user_management_report.txt 2>/dev/null && id alice_dev >> user_management_report.txt 2>/dev/null && id bob_test >> user_management_report.txt 2>/dev/null && id charlie_ops >> user_management_report.txt 2>/dev/null || true
echo "[Q133] Completed"
echo ""

# Question 134 - Disk Space Analysis and Cleanup
echo "[Q134] Running Disk Space Analysis and Cleanup..."
df -h > disk_usage.txt 2>/dev/null && find /var/log -type f -exec ls -lh {} + 2>/dev/null | sort -k5 -hr | head -10 >> disk_usage.txt && du -sh /home /var /tmp > cleanup_report.txt 2>/dev/null && find /home/student/logs -name "*.log" -mtime +7 -exec gzip {} \; 2>/dev/null && echo "Log files compressed on $(date)" >> cleanup_report.txt && echo "#!/bin/bash" > disk_monitor.sh && echo "usage=\$(df / | tail -1 | awk '{print \$5}' | sed 's/%//')" >> disk_monitor.sh && echo "if [ \$usage -gt 80 ]; then echo \"Warning: Disk usage is \${usage}%\"; fi" >> disk_monitor.sh && chmod +x disk_monitor.sh || true
echo "[Q134] Completed"
echo ""

# Question 135 - Network Interface and Connection Management
echo "[Q135] Running Network Interface and Connection Management..."
ip addr show > network_config.txt 2>/dev/null && netstat -tuln >> network_config.txt 2>/dev/null && ping -c 4 google.com >> network_config.txt 2>&1 && echo "Network connectivity tested on $(date)" >> network_config.txt && echo "#!/bin/bash" > network_monitor.sh && echo "echo \"Network Status Report - \$(date)\" > /tmp/network_status.log" >> network_monitor.sh && echo "ip link show >> /tmp/network_status.log" >> network_monitor.sh && echo "ping -c 1 8.8.8.8 >> /tmp/network_status.log 2>&1" >> network_monitor.sh && chmod +x network_monitor.sh || true
echo "[Q135] Completed"
echo ""

# Question 136 - System Performance Analysis
echo "[Q136] Running System Performance Analysis..."
top -b -n6 -d5 2>/dev/null | grep "Cpu(s)" | tail -1 > cpu_stats.txt && free -h > memory_stats.txt && ps aux --sort=-%cpu | head -6 > top_processes.txt && uptime > load_average.txt && echo "#!/bin/bash" > perf_monitor.sh && echo "echo \"Performance Report - \$(date)\" > /tmp/performance.log" >> perf_monitor.sh && echo "top -b -n1 | head -20 >> /tmp/performance.log" >> perf_monitor.sh && echo "free -h >> /tmp/performance.log" >> perf_monitor.sh && chmod +x perf_monitor.sh && echo "*/5 * * * * /home/student/perf_monitor.sh" | crontab - 2>/dev/null || true
echo "[Q136] Completed"
echo ""

# Question 137 - System Log Analysis
echo "[Q137] Running System Log Analysis..."
grep -c "ERROR" /home/student/app_logs/application.log 2>/dev/null > log_stats.txt && grep -c "WARNING" /home/student/app_logs/application.log 2>/dev/null >> log_stats.txt && grep -c "INFO" /home/student/app_logs/application.log 2>/dev/null >> log_stats.txt && find /home/student/app_logs -name "*.log" -mtime +30 -exec tar -czf archived_logs_$(date +%Y%m%d).tar.gz {} \; 2>/dev/null && echo "/home/student/app_logs/application.log {" > logrotate.conf && echo "    daily" >> logrotate.conf && echo "    rotate 7" >> logrotate.conf && echo "    compress" >> logrotate.conf && echo "    missingok" >> logrotate.conf && echo "}" >> logrotate.conf || true
echo "[Q137] Completed"
echo ""

# Question 138 - File Permissions and Security
echo "[Q138] Running File Permissions and Security..."
mkdir -p /home/student/secure/{public,private,restricted} 2>/dev/null && chmod 755 /home/student/secure/public 2>/dev/null && chmod 750 /home/student/secure/private 2>/dev/null && chmod 700 /home/student/secure/restricted 2>/dev/null && echo "Sensitive data" > /home/student/secure/private/data.txt && echo "Restricted info" > /home/student/secure/restricted/secret.txt && chmod 600 /home/student/secure/restricted/secret.txt 2>/dev/null && find /home/student/secure -type f -exec ls -l {} \; 2>/dev/null > permissions_report.txt && echo "#!/bin/bash" > security_audit.sh && echo "find /home/student/secure -perm /022 -ls" >> security_audit.sh && chmod +x security_audit.sh || true
echo "[Q138] Completed"
echo ""

# Question 139 - System Backup and Recovery
echo "[Q139] Running System Backup and Recovery..."
mkdir -p /home/student/backups/{full,incremental} 2>/dev/null && tar -czf /home/student/backups/full/home_backup_$(date +%Y%m%d).tar.gz /home/student/data 2>/dev/null && echo "#!/bin/bash" > backup_script.sh && echo "BACKUP_DIR=/home/student/backups" >> backup_script.sh && echo "tar -czf \$BACKUP_DIR/incremental/inc_\$(date +%Y%m%d_%H%M).tar.gz /home/student/data" >> backup_script.sh && chmod +x backup_script.sh && echo "0 2 * * * /home/student/backup_script.sh" | crontab - 2>/dev/null && ls -la /home/student/backups/full/ > backup_report.txt 2>/dev/null && echo "Backup created on $(date)" >> backup_report.txt || true
echo "[Q139] Completed"
echo ""

# Question 140 - Environment Configuration
echo "[Q140] Running Environment Configuration..."
echo "export APP_ENV=production" >> ~/.bashrc && echo "export DB_HOST=localhost" >> ~/.bashrc && echo "export MAX_CONNECTIONS=1000" >> ~/.bashrc && source ~/.bashrc 2>/dev/null && echo "* soft nofile 65536" >> /home/student/limits.conf && echo "* hard nofile 65536" >> /home/student/limits.conf && echo "#!/bin/bash" > config_validator.sh && echo "echo \"Environment Variables:\"" >> config_validator.sh && echo "printenv | grep -E \"APP_ENV|DB_HOST|MAX_CONNECTIONS\"" >> config_validator.sh && echo "echo \"System Limits:\"" >> config_validator.sh && echo "ulimit -n" >> config_validator.sh && chmod +x config_validator.sh && cp ~/.bashrc bashrc_backup.txt 2>/dev/null || true
echo "[Q140] Completed"
echo ""

# Question 575 - Create Simple Text File
echo "[Q575] Running Create Simple Text File..."
touch student_info.txt 2>/dev/null && echo -e "Name: John Doe\nCourse: Linux Administration\nLevel: Beginner" > student_info.txt || true
echo "[Q575] Completed"
echo ""

# Question 576 - Copy Files Between Directories
echo "[Q576] Running Copy Files Between Directories..."
cp /home/student/config/system.conf /home/student/backup/ 2>/dev/null && echo "Copy completed successfully" > /home/student/copy_status.txt || true
echo "[Q576] Completed"
echo ""

# Question 577 - Change File Permissions
echo "[Q577] Running Change File Permissions..."
chmod 740 /home/student/scripts/backup_script.sh 2>/dev/null && ls -l /home/student/scripts/backup_script.sh > /home/student/permission_result.txt 2>/dev/null || true
echo "[Q577] Completed"
echo ""

# Question 578 - Analyze Log File Content
echo "[Q578] Running Analyze Log File Content..."
head -n 3 /home/student/logs/error.log > /home/student/first_errors.txt 2>/dev/null && tail -n 3 /home/student/logs/error.log > /home/student/last_errors.txt 2>/dev/null && wc -l /home/student/logs/error.log 2>/dev/null | cut -d" " -f1 > /home/student/line_count.txt || true
echo "[Q578] Completed"
echo ""

# Question 579 - Search for Patterns
echo "[Q579] Running Search for Patterns..."
grep "ERROR" /home/student/data/application.log > /home/student/error_lines.txt 2>/dev/null && grep -c "ERROR" /home/student/data/application.log > /home/student/error_count.txt 2>/dev/null || true
echo "[Q579] Completed"
echo ""

# Question 580 - Display User Information
echo "[Q580] Running Display User Information..."
whoami > /home/student/current_user.txt 2>/dev/null && pwd > /home/student/current_dir.txt && date > /home/student/current_time.txt || true
echo "[Q580] Completed"
echo ""

# Question 581 - Create and Extract Archives
echo "[Q581] Running Create and Extract Archives..."
cd /home/student/documents 2>/dev/null && tar -cvf backup.tar *.txt 2>/dev/null && mkdir -p /home/student/extracted && tar -xvf backup.tar -C /home/student/extracted 2>/dev/null && echo "Archive operations completed" > /home/student/archive_status.txt || true
echo "[Q581] Completed"
echo ""

# Question 582 - Check File Ownership
echo "[Q582] Running Check File Ownership..."
ls -l /home/student/shared/project.txt > /home/student/ownership_info.txt 2>/dev/null && ls -l /home/student/shared/project.txt 2>/dev/null | awk "{print \$3}" > /home/student/owner_name.txt || true
echo "[Q582] Completed"
echo ""

# Question 583 - Create Directory Structure
echo "[Q583] Running Create Directory Structure..."
mkdir -p /home/student/project/{src,docs,tests,config} 2>/dev/null && touch /home/student/project/README.md && ls -la /home/student/project/ > /home/student/directory_tree.txt 2>/dev/null || true
echo "[Q583] Completed"
echo ""

# Question 584 - Modify File Content
echo "[Q584] Running Modify File Content..."
echo "debug_mode=true" >> /home/student/config/settings.conf 2>/dev/null && echo "log_level=debug" >> /home/student/config/settings.conf 2>/dev/null && cat /home/student/config/settings.conf > /home/student/updated_config.txt 2>/dev/null || true
echo "[Q584] Completed"
echo ""

# Question 585 - Gather System Information
echo "[Q585] Running Gather System Information..."
hostname > /home/student/hostname.txt 2>/dev/null && uptime > /home/student/uptime.txt && df -h /home > /home/student/disk_usage.txt 2>/dev/null && echo "=== System Report ===" > /home/student/system_report.txt && echo "Hostname:" >> /home/student/system_report.txt && cat /home/student/hostname.txt >> /home/student/system_report.txt 2>/dev/null && echo "Uptime:" >> /home/student/system_report.txt && cat /home/student/uptime.txt >> /home/student/system_report.txt && echo "Disk Usage:" >> /home/student/system_report.txt && cat /home/student/disk_usage.txt >> /home/student/system_report.txt 2>/dev/null || true
echo "[Q585] Completed"
echo ""

# Question 586 - Compare Configuration Files
echo "[Q586] Running Compare Configuration Files..."
diff /home/student/configs/old_config.conf /home/student/configs/new_config.conf > /home/student/config_diff.txt 2>/dev/null && echo "Configuration differences found and saved" > /home/student/diff_summary.txt || true
echo "[Q586] Completed"
echo ""

# Question 587 - Process User Data
echo "[Q587] Running Process User Data..."
cd /home/student/data 2>/dev/null && sort users.txt > /home/student/sorted_users.txt 2>/dev/null && sort -u users.txt > /home/student/unique_users.txt 2>/dev/null && wc -l /home/student/unique_users.txt 2>/dev/null | awk '{print $1}' > /home/student/user_count.txt || true
echo "[Q587] Completed"
echo ""

# Question 588 - Display Environment Information
echo "[Q588] Running Display Environment Information..."
echo $HOME > /home/student/home_var.txt 2>/dev/null && echo $PATH > /home/student/path_var.txt && echo $SHELL > /home/student/shell_info.txt && echo "Environment variables captured" > /home/student/env_summary.txt || true
echo "[Q588] Completed"
echo ""

# Question 589 - Create File Links
echo "[Q589] Running Create File Links..."
cd /home/student/files 2>/dev/null && ln important.txt important_backup.txt 2>/dev/null && ln -s important.txt important_link.txt 2>/dev/null && ls -l > /home/student/link_info.txt || true
echo "[Q589] Completed"
echo ""

# Question 590 - Monitor User Sessions
echo "[Q590] Running Monitor User Sessions..."
who > /home/student/logged_users.txt 2>/dev/null && echo $$ > /home/student/current_pid.txt && last -n 5 > /home/student/last_login.txt 2>/dev/null && echo "Session monitoring completed" > /home/student/session_status.txt || true
echo "[Q590] Completed"
echo ""

# Question 591 - Analyze File Sizes
echo "[Q591] Running Analyze File Sizes..."
ls -lh /home/student/media/ > /home/student/file_sizes.txt 2>/dev/null && du -sh /home/student/media/ > /home/student/total_size.txt 2>/dev/null && ls -S /home/student/media/ 2>/dev/null | head -n 1 > /home/student/largest_file.txt || true
echo "[Q591] Completed"
echo ""

# Question 592 - Perform File Backup
echo "[Q592] Running Perform File Backup..."
BACKUP_DIR="/home/student/backup_$(date +%Y%m%d)" && mkdir -p "$BACKUP_DIR" 2>/dev/null && cp /home/student/system/*.conf "$BACKUP_DIR/" 2>/dev/null && echo "Backup created: $BACKUP_DIR at $(date)" > /home/student/backup_log.txt && ls -la "$BACKUP_DIR" > /home/student/backup_verification.txt 2>/dev/null || true
echo "[Q592] Completed"
echo ""

# Question 593 - Display User Group Information
echo "[Q593] Running Display User Group Information..."
groups > /home/student/user_groups.txt 2>/dev/null && cat /etc/group > /home/student/all_groups.txt 2>/dev/null && id > /home/student/user_id.txt && echo "User group information collected" > /home/student/group_summary.txt || true
echo "[Q593] Completed"
echo ""

# Question 594 - File Cleanup and Organization
echo "[Q594] Running File Cleanup and Organization..."
find /home/student/messy -name "*.tmp" > /home/student/tmp_files.txt 2>/dev/null && find /home/student/messy -empty -type f > /home/student/empty_files.txt 2>/dev/null && echo "Number of .tmp files found: $(wc -l < /home/student/tmp_files.txt)" > /home/student/cleanup_report.txt && echo "Number of empty files found: $(wc -l < /home/student/empty_files.txt)" >> /home/student/cleanup_report.txt && echo "Cleanup analysis completed" >> /home/student/cleanup_report.txt || true
echo "[Q594] Completed"
echo ""

# Question 595 - Extract CSV Fields
echo "[Q595] Running Extract CSV Fields..."
cut -d"," -f1 /home/student/hr/employees.csv > /home/student/employee_names.txt 2>/dev/null && cut -d"," -f3 /home/student/hr/employees.csv > /home/student/departments.txt 2>/dev/null && cut -d"," -f3 /home/student/hr/employees.csv 2>/dev/null | sort | uniq | wc -l > /home/student/dept_count.txt || true
echo "[Q595] Completed"
echo ""

# Question 596 - Monitor System Processes
echo "[Q596] Running Monitor System Processes..."
ps aux > /home/student/all_processes.txt 2>/dev/null && ps aux | grep bash | grep -v grep > /home/student/bash_processes.txt 2>/dev/null && free -h > /home/student/memory_info.txt && echo "Process monitoring completed at $(date)" > /home/student/process_report.txt || true
echo "[Q596] Completed"
echo ""

# Question 597 - Manage File Timestamps
echo "[Q597] Running Manage File Timestamps..."
ls -la /home/student/timestamps/ > /home/student/file_timestamps.txt 2>/dev/null && touch /home/student/timestamps/old_file.txt 2>/dev/null && echo "File timestamps updated successfully" > /home/student/timestamp_log.txt || true
echo "[Q597] Completed"
echo ""

# Question 598 - Analyze Network Configuration
echo "[Q598] Running Analyze Network Configuration..."
cat /home/student/network/hosts_file.txt > /home/student/hosts_content.txt 2>/dev/null && grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" /home/student/network/hosts_file.txt > /home/student/ip_addresses.txt 2>/dev/null && grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" /home/student/network/hosts_file.txt 2>/dev/null | wc -l > /home/student/ip_count.txt || true
echo "[Q598] Completed"
echo ""

# Question 599 - Filter System Logs
echo "[Q599] Running Filter System Logs..."
grep "WARNING" /home/student/logs/system.log > /home/student/warnings.txt 2>/dev/null && grep "ERROR" /home/student/logs/system.log > /home/student/errors.txt 2>/dev/null && echo "Warnings found: $(grep -c "WARNING" /home/student/logs/system.log 2>/dev/null)" > /home/student/log_summary.txt && echo "Errors found: $(grep -c "ERROR" /home/student/logs/system.log 2>/dev/null)" >> /home/student/log_summary.txt || true
echo "[Q599] Completed"
echo ""

# Question 600 - Permission Management
echo "[Q600] Running Permission Management..."
chmod 755 /home/student/permissions/script1.sh 2>/dev/null && chmod 444 /home/student/permissions/data.txt 2>/dev/null && ls -l /home/student/permissions/ > /home/student/permission_details.txt 2>/dev/null || true
echo "[Q600] Completed"
echo ""

# Question 601 - Work with Date and Calendar
echo "[Q601] Running Work with Date and Calendar..."
date "+%Y-%m-%d" > /home/student/current_date.txt 2>/dev/null && date "+%H:%M:%S" > /home/student/current_time.txt 2>/dev/null && cal > /home/student/calendar.txt 2>/dev/null && echo "Date operations completed on $(date +%Y-%m-%d)" > /home/student/timestamp_info.txt || true
echo "[Q601] Completed"
echo ""

# Question 602 - File Security Operations
echo "[Q602] Running File Security Operations..."
md5sum /home/student/security/important.txt > /home/student/md5_checksum.txt 2>/dev/null && sha256sum /home/student/security/important.txt > /home/student/sha256_checksum.txt 2>/dev/null && echo "File checksums calculated successfully" > /home/student/security_report.txt || true
echo "[Q602] Completed"
echo ""

# Question 603 - Monitor System Resources
echo "[Q603] Running Monitor System Resources..."
cat /proc/cpuinfo 2>/dev/null | head -20 > /home/student/cpu_info.txt && df -h > /home/student/disk_usage.txt 2>/dev/null && ps aux | wc -l > /home/student/process_count.txt 2>/dev/null && echo "=== System Status Report ===" > /home/student/system_status.txt && echo "CPU Info:" >> /home/student/system_status.txt && head -5 /home/student/cpu_info.txt >> /home/student/system_status.txt 2>/dev/null && echo "Disk Usage:" >> /home/student/system_status.txt && head -5 /home/student/disk_usage.txt >> /home/student/system_status.txt 2>/dev/null && echo "Process Count: $(cat /home/student/process_count.txt)" >> /home/student/system_status.txt || true
echo "[Q603] Completed"
echo ""

# Question 604 - Replace Text in Configuration Files
echo "[Q604] Running Replace Text in Configuration Files..."
sed -i "s/localhost/192.168.1.100/g" /home/student/configs/server.conf 2>/dev/null && sed -i "s/port=8080/port=9090/g" /home/student/configs/server.conf 2>/dev/null && cat /home/student/configs/server.conf > /home/student/modified_config.txt 2>/dev/null || true
echo "[Q604] Completed"
echo ""

# Question 605 - Navigate Complex Directory Structures
echo "[Q605] Running Navigate Complex Directory Structures..."
cd /home/student/project/src 2>/dev/null && pwd > current_location.txt && cd ../.. && pwd > /home/student/navigation_path.txt && ls -d */ 2>/dev/null > /home/student/directory_list.txt || echo "No directories found" > /home/student/directory_list.txt || true
echo "[Q605] Completed"
echo ""

# Question 606 - Analyze User Login Activity
echo "[Q606] Running Analyze User Login Activity..."
last -n 10 > /home/student/login_history.txt 2>/dev/null && who > /home/student/current_users.txt 2>/dev/null && uptime -s > /home/student/boot_time.txt 2>/dev/null && echo "Login analysis completed" > /home/student/login_summary.txt || true
echo "[Q606] Completed"
echo ""

# Question 607 - File Search Operations
echo "[Q607] Running File Search Operations..."
find /home/student/search -name "*.txt" > /home/student/txt_files.txt 2>/dev/null && find /home/student/search -size +50c > /home/student/large_files.txt 2>/dev/null && find /home/student/search -mtime -7 > /home/student/recent_files.txt 2>/dev/null || true
echo "[Q607] Completed"
echo ""

# Question 608 - Analyze System Configuration Files
echo "[Q608] Running Analyze System Configuration Files..."
grep "enabled" /home/student/system/config.ini > /home/student/enabled_settings.txt 2>/dev/null && grep -c "^\[" /home/student/system/config.ini > /home/student/section_count.txt 2>/dev/null && grep "=" /home/student/system/config.ini 2>/dev/null | cut -d"=" -f1 > /home/student/parameters.txt || true
echo "[Q608] Completed"
echo ""

# Question 609 - Manage File Compression
echo "[Q609] Running Manage File Compression..."
gzip -c /home/student/compress/large_file.txt > /home/student/compress/large_file.txt.gz 2>/dev/null && echo "Original size: $(ls -lh /home/student/compress/large_file.txt 2>/dev/null | awk "{print \$5}")" > /home/student/size_comparison.txt && echo "Compressed size: $(ls -lh /home/student/compress/large_file.txt.gz 2>/dev/null | awk "{print \$5}")" >> /home/student/size_comparison.txt && echo "Compression completed successfully" > /home/student/compression_report.txt || true
echo "[Q609] Completed"
echo ""

# Question 610 - Customize User Environment
echo "[Q610] Running Customize User Environment..."
env > /home/student/all_env_vars.txt 2>/dev/null && echo $LANG > /home/student/lang_setting.txt && echo $SHLVL > /home/student/shell_level.txt && echo "Environment analysis completed" > /home/student/env_summary.txt || true
echo "[Q610] Completed"
echo ""

# Question 611 - Validate File Content
echo "[Q611] Running Validate File Content..."
grep -E "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" /home/student/validation/email.txt > /home/student/valid_emails.txt 2>/dev/null && grep -cE "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" /home/student/validation/email.txt > /home/student/email_count.txt 2>/dev/null && echo "Email validation completed" > /home/student/validation_report.txt || true
echo "[Q611] Completed"
echo ""

# Question 612 - Gather System Service Information
echo "[Q612] Running Gather System Service Information..."
ps aux | grep -E "(daemon|service)" | grep -v grep > /home/student/running_services.txt 2>/dev/null && uptime | awk -F"load average:" "{print \$2}" > /home/student/load_average.txt 2>/dev/null && uname -r > /home/student/kernel_version.txt && echo "System service analysis completed" > /home/student/service_report.txt || true
echo "[Q612] Completed"
echo ""

# Question 613 - Analyze Directory Tree Structure
echo "[Q613] Running Analyze Directory Tree Structure..."
ls -laR /home/student/tree/ > /home/student/tree_structure.txt 2>/dev/null && find /home/student/tree -type d 2>/dev/null | wc -l > /home/student/dir_count.txt && find /home/student/tree -type f 2>/dev/null | wc -l > /home/student/file_count.txt || true
echo "[Q613] Completed"
echo ""

# Question 614 - Text Processing Operations
echo "[Q614] Running Text Processing Operations..."
tr "[:upper:]" "[:lower:]" < /home/student/textproc/data.txt > /home/student/lowercase_data.txt 2>/dev/null && grep -v "^$" /home/student/textproc/data.txt > /home/student/no_blanks.txt 2>/dev/null && echo "Lines: $(wc -l < /home/student/textproc/data.txt 2>/dev/null)" > /home/student/text_stats.txt && echo "Words: $(wc -w < /home/student/textproc/data.txt 2>/dev/null)" >> /home/student/text_stats.txt && echo "Characters: $(wc -c < /home/student/textproc/data.txt 2>/dev/null)" >> /home/student/text_stats.txt || true
echo "[Q614] Completed"
echo ""

# Question 615 - Display Basic User Account Information
echo "[Q615] Running Display Basic User Account Information..."
whoami > /home/student/my_username.txt 2>/dev/null && id -u > /home/student/my_uid.txt 2>/dev/null && id -g > /home/student/my_gid.txt 2>/dev/null && echo "User information collected successfully" > /home/student/user_info_summary.txt || true
echo "[Q615] Completed"
echo ""

# Question 616 - Analyze File Ownership Information
echo "[Q616] Running Analyze File Ownership Information..."
ls -l /home/student/ownership/ > /home/student/ownership_details.txt 2>/dev/null && ls -l /home/student/ownership/ 2>/dev/null | awk "NR>1 {print \$3}" > /home/student/file_owners.txt && ls -l /home/student/ownership/ 2>/dev/null | awk "NR>1 {print \$4}" > /home/student/file_groups.txt || true
echo "[Q616] Completed"
echo ""

# Question 617 - Set File Permissions Using Symbolic Mode
echo "[Q617] Running Set File Permissions Using Symbolic Mode..."
chmod u+x /home/student/perms/script.sh 2>/dev/null && chmod go-w /home/student/perms/data.txt 2>/dev/null && ls -l /home/student/perms/ > /home/student/updated_permissions.txt 2>/dev/null || true
echo "[Q617] Completed"
echo ""

# Question 618 - Work with Numeric Permission Modes
echo "[Q618] Running Work with Numeric Permission Modes..."
chmod 644 /home/student/numeric/file1.txt 2>/dev/null && chmod 755 /home/student/numeric/file2.txt 2>/dev/null && chmod 600 /home/student/numeric/file3.txt 2>/dev/null && ls -l /home/student/numeric/ > /home/student/numeric_permissions.txt 2>/dev/null || true
echo "[Q618] Completed"
echo ""

# Question 619 - Display User Group Memberships
echo "[Q619] Running Display User Group Memberships..."
groups > /home/student/my_groups.txt 2>/dev/null && id > /home/student/detailed_groups.txt && groups | wc -w > /home/student/group_count.txt 2>/dev/null && echo "Group analysis completed" > /home/student/group_membership.txt || true
echo "[Q619] Completed"
echo ""

# Question 620 - Manage Directory Permissions
echo "[Q620] Running Manage Directory Permissions..."
chmod 755 /home/student/directories/public_dir 2>/dev/null && chmod 700 /home/student/directories/private_dir 2>/dev/null && chmod 750 /home/student/directories/shared_dir 2>/dev/null && ls -ld /home/student/directories/*_dir > /home/student/directory_permissions.txt 2>/dev/null || true
echo "[Q620] Completed"
echo ""

# Question 621 - Analyze Current User Session
echo "[Q621] Running Analyze Current User Session..."
tty > /home/student/terminal_info.txt 2>/dev/null && pwd > /home/student/current_directory.txt && echo $SHELL > /home/student/shell_info.txt && echo "=== User Session Report ===" > /home/student/session_report.txt && echo "Terminal: $(cat /home/student/terminal_info.txt 2>/dev/null)" >> /home/student/session_report.txt && echo "Directory: $(cat /home/student/current_directory.txt)" >> /home/student/session_report.txt && echo "Shell: $(cat /home/student/shell_info.txt)" >> /home/student/session_report.txt || true
echo "[Q621] Completed"
echo ""

# Question 622 - Analyze Complex Permission Scenarios
echo "[Q622] Running Analyze Complex Permission Scenarios..."
stat -c "%n %a" /home/student/complex_perms/* > /home/student/octal_permissions.txt 2>/dev/null && find /home/student/complex_perms -perm -u+x -type f > /home/student/executable_files.txt 2>/dev/null && find /home/student/complex_perms -perm -g+r -type f > /home/student/group_readable.txt 2>/dev/null || true
echo "[Q622] Completed"
echo ""

# Question 623 - Analyze User Home Directory Structure
echo "[Q623] Running Analyze User Home Directory Structure..."
echo $HOME > /home/student/home_path.txt 2>/dev/null && ls -la $HOME 2>/dev/null | grep "^\." > /home/student/hidden_files.txt && du -sh $HOME > /home/student/home_usage.txt 2>/dev/null && echo "Home directory analysis completed" > /home/student/home_analysis.txt || true
echo "[Q623] Completed"
echo ""

# Question 624 - Test File Access Permissions
echo "[Q624] Running Test File Access Permissions..."
if [ -r /home/student/access_test/readable.txt ]; then echo "READ ACCESS: SUCCESS" > /home/student/read_test.txt; else echo "READ ACCESS: FAILED" > /home/student/read_test.txt; fi 2>/dev/null && if echo "test write" >> /home/student/access_test/writable.txt 2>/dev/null; then echo "WRITE ACCESS: SUCCESS" > /home/student/write_test.txt; else echo "WRITE ACCESS: FAILED" > /home/student/write_test.txt; fi && if [ -x /home/student/access_test/executable.sh ]; then echo "EXECUTE ACCESS: SUCCESS" > /home/student/execute_test.txt; else echo "EXECUTE ACCESS: FAILED" > /home/student/execute_test.txt; fi 2>/dev/null || true
echo "[Q624] Completed"
echo ""

# Question 625 - Analyze Process Ownership
echo "[Q625] Running Analyze Process Ownership..."
ps -u $(whoami) > /home/student/my_processes.txt 2>/dev/null && ps -u $(whoami) 2>/dev/null | wc -l > /home/student/process_count.txt && ps -u $(whoami) --sort=-%cpu 2>/dev/null | head -2 | tail -1 > /home/student/top_process.txt && echo "Process ownership analysis completed" > /home/student/process_summary.txt || true
echo "[Q625] Completed"
echo ""

# Question 626 - Understand Special Permission Bits
echo "[Q626] Running Understand Special Permission Bits..."
ls -la /home/student/special_perms/ > /home/student/special_permissions.txt 2>/dev/null && find /home/student/special_perms -type f \( -perm -4000 -o -perm -2000 -o -perm -1000 \) 2>/dev/null > /home/student/special_files.txt && echo "Special permissions analyzed" > /home/student/special_analysis.txt || true
echo "[Q626] Completed"
echo ""

# Question 627 - Display User Resource Limits
echo "[Q627] Running Display User Resource Limits..."
ulimit -a > /home/student/user_limits.txt 2>/dev/null && ulimit -f > /home/student/file_limits.txt 2>/dev/null && ulimit -u > /home/student/process_limits.txt 2>/dev/null && echo "User limits analysis completed" > /home/student/limits_summary.txt || true
echo "[Q627] Completed"
echo ""

# Question 628 - Analyze Permission Inheritance
echo "[Q628] Running Analyze Permission Inheritance..."
cd /home/student/inheritance 2>/dev/null && touch test_file.txt && ls -l test_file.txt > /home/student/default_file_perms.txt 2>/dev/null && mkdir test_dir 2>/dev/null && ls -ld test_dir > /home/student/default_dir_perms.txt 2>/dev/null && umask > /home/student/umask_value.txt || true
echo "[Q628] Completed"
echo ""

# Question 629 - Analyze File Types and Their Permissions
echo "[Q629] Running Analyze File Types and Their Permissions..."
file /home/student/file_types/* > /home/student/file_type_info.txt 2>/dev/null && find /home/student/file_types -type f -executable > /home/student/executable_list.txt 2>/dev/null && find /home/student/file_types -type f -name "*.txt" > /home/student/text_files_list.txt 2>/dev/null || true
echo "[Q629] Completed"
echo ""

# Question 630 - Manage Group-Based Permissions
echo "[Q630] Running Manage Group-Based Permissions..."
cd /home/student/group_work 2>/dev/null && chmod 660 shared.txt 2>/dev/null && chmod 700 private.txt 2>/dev/null && chmod 710 team_script.sh 2>/dev/null && ls -l > /home/student/group_permissions.txt 2>/dev/null || true
echo "[Q630] Completed"
echo ""

# Question 631 - Examine User Authentication Details
echo "[Q631] Running Examine User Authentication Details..."
grep "^$(whoami):" /etc/passwd > /home/student/passwd_info.txt 2>/dev/null && echo $SHELL > /home/student/login_shell.txt && last -n 5 $(whoami) > /home/student/last_login_info.txt 2>/dev/null && echo "Authentication information collected" > /home/student/auth_summary.txt || true
echo "[Q631] Completed"
echo ""

# Question 632 - Troubleshoot Permission Issues
echo "[Q632] Running Troubleshoot Permission Issues..."
ls -l /home/student/troubleshoot/broken_script.sh > /home/student/permission_fix.txt 2>/dev/null && echo "Problem: Script not executable" >> /home/student/permission_fix.txt && chmod +x /home/student/troubleshoot/broken_script.sh 2>/dev/null && echo "Solution: Added execute permission" >> /home/student/permission_fix.txt && if [ -x /home/student/troubleshoot/broken_script.sh ]; then echo "EXECUTION TEST: SUCCESS - Script is now executable" > /home/student/execution_test.txt; else echo "EXECUTION TEST: FAILED" > /home/student/execution_test.txt; fi || true
echo "[Q632] Completed"
echo ""

# Question 633 - Comprehensive User Environment Analysis
echo "[Q633] Running Comprehensive User Environment Analysis..."
export > /home/student/exported_vars.txt 2>/dev/null && echo $PATH | tr ":" "\n" > /home/student/path_breakdown.txt && ls -ld $(pwd) > /home/student/pwd_permissions.txt 2>/dev/null && echo "=== Environment Analysis Report ===" > /home/student/environment_report.txt && echo "Exported variables: $(export 2>/dev/null | wc -l)" >> /home/student/environment_report.txt && echo "PATH entries: $(echo $PATH | tr ":" "\n" | wc -l)" >> /home/student/environment_report.txt && echo "Current directory: $(pwd)" >> /home/student/environment_report.txt && echo "Analysis completed successfully" >> /home/student/environment_report.txt || true
echo "[Q633] Completed"
echo ""

# Question 634 - Perform File Security Audit
echo "[Q634] Running Perform File Security Audit..."
find /home/student/security_audit -type f -perm -002 > /home/student/world_writable.txt 2>/dev/null && find /home/student/security_audit -type f ! -perm -400 > /home/student/no_owner_read.txt 2>/dev/null && echo "=== File Security Audit Report ===" > /home/student/security_audit_report.txt && echo "World-writable files found: $(wc -l < /home/student/world_writable.txt 2>/dev/null)" >> /home/student/security_audit_report.txt && echo "Files without owner read: $(wc -l < /home/student/no_owner_read.txt 2>/dev/null)" >> /home/student/security_audit_report.txt && echo "Security audit completed - Review findings above" >> /home/student/security_audit_report.txt || true
echo "[Q634] Completed"
echo ""

# Question 635 - Create Directory
echo "[Q635] Running Create Directory..."
mkdir /home/student/test_dir 2>/dev/null || true
echo "[Q635] Completed"
echo ""

# Question 636 - List Files
echo "[Q636] Running List Files..."
ls -la /home/student > /home/student/file_list.txt 2>/dev/null || true
echo "[Q636] Completed"
echo ""

# Question 637 - Copy Files
echo "[Q637] Running Copy Files..."
cp /etc/hosts /home/student/test_dir 2>/dev/null || true
echo "[Q637] Completed"
echo ""

# Question 638 - Move Files
echo "[Q638] Running Move Files..."
mv /home/student/test_file.txt /home/student/test_dir/moved_file.txt 2>/dev/null || true
echo "[Q638] Completed"
echo ""

# Question 639 - Delete File
echo "[Q639] Running Delete File..."
rm /home/student/test_dir/moved_file.txt 2>/dev/null || true
echo "[Q639] Completed"
echo ""

# Question 640 - Delete Directory
echo "[Q640] Running Delete Directory..."
rmdir /home/student/test_dir 2>/dev/null || true
echo "[Q640] Completed"
echo ""

# Question 641 - Display File Content
echo "[Q641] Running Display File Content..."
cat /etc/os-release > /home/student/os_info.txt 2>/dev/null || true
echo "[Q641] Completed"
echo ""

# Question 642 - Append to File
echo "[Q642] Running Append to File..."
echo 'Hello Student' >> /home/student/greeting.txt || true
echo "[Q642] Completed"
echo ""

# Question 643 - Overwrite File
echo "[Q643] Running Overwrite File..."
echo 'Initial Text' > /home/student/overwrite_me.txt && echo 'New Text' > /home/student/overwrite_me.txt || true
echo "[Q643] Completed"
echo ""

# Question 644 - Create Symbolic Link
echo "[Q644] Running Create Symbolic Link..."
ln -s /etc/os-release /home/student/link_to_os 2>/dev/null || true
echo "[Q644] Completed"
echo ""

# Question 645 - Find Files
echo "[Q645] Running Find Files..."
find /etc -name '*.conf' > /home/student/conf_files.txt 2>/dev/null || true
echo "[Q645] Completed"
echo ""

# Question 646 - Change Permissions
echo "[Q646] Running Change Permissions..."
touch /home/student/permissions_test.txt && chmod 644 /home/student/permissions_test.txt 2>/dev/null || true
echo "[Q646] Completed"
echo ""

# Question 647 - Create Nested Directories
echo "[Q647] Running Create Nested Directories..."
mkdir -p /home/student/dir1/dir2/dir3 2>/dev/null || true
echo "[Q647] Completed"
echo ""

# Question 648 - Long Listing
echo "[Q648] Running Long Listing..."
ls -la /home/student > /home/student/long_list.txt 2>/dev/null || true
echo "[Q648] Completed"
echo ""

# Question 649 - Count Lines
echo "[Q649] Running Count Lines..."
wc -l /etc/passwd > /home/student/line_count.txt 2>/dev/null || true
echo "[Q649] Completed"
echo ""

# Question 650 - Head Command
echo "[Q650] Running Head Command..."
head -n 5 /etc/services > /home/student/services_head.txt 2>/dev/null || true
echo "[Q650] Completed"
echo ""

# Question 651 - Tail Command
echo "[Q651] Running Tail Command..."
tail -n 3 /etc/services > /home/student/services_tail.txt 2>/dev/null || true
echo "[Q651] Completed"
echo ""

# Question 652 - Create User
echo "[Q652] Running Create User..."
sudo useradd -m testuser 2>/dev/null || true
echo "[Q652] Completed"
echo ""

# Question 653 - Change Ownership
echo "[Q653] Running Change Ownership..."
sudo chown testuser /home/student/greeting.txt 2>/dev/null || true
echo "[Q653] Completed"
echo ""

# Question 43563 - System Process Monitoring
echo "[Q43563] Running System Process Monitoring..."
ps aux > process_list.txt 2>/dev/null && echo "SYSTEM STATUS REPORT - $(date)" > system_status.txt && echo "=== TOP CPU PROCESSES ===" >> system_status.txt && ps aux --sort=-%cpu | head -6 >> system_status.txt 2>/dev/null && echo "=== MEMORY USAGE ===" >> system_status.txt && free -h >> system_status.txt && echo "=== DISK USAGE ===" >> system_status.txt && df -h >> system_status.txt && echo "=== SYSTEM LOAD ===" >> system_status.txt && uptime >> system_status.txt && echo "=== PROCESS COUNT ===" >> system_status.txt && ps aux | wc -l >> system_status.txt || true
echo "[Q43563] Completed"
echo ""

# Question 43564 - Monitor and Log Running Processes
echo "[Q43564] Running Monitor and Log Running Processes..."
ps aux > /home/student/system/processes.txt 2>/dev/null && echo "Total processes: $(ps aux | wc -l)" >> /home/student/system/processes.txt && ps aux | grep "^$(whoami)" > /home/student/system/my_processes.txt 2>/dev/null || true
echo "[Q43564] Completed"
echo ""

# Question 43567 - Change File Ownership
echo "[Q43567] Running Change File Ownership..."
sudo chown dbadmin /backup/db_backup.sql 2>/dev/null && sudo chown :dbgroup /backup/db_backup.sql 2>/dev/null && ls -l /backup/db_backup.sql 2>/dev/null || true
echo "[Q43567] Completed"
echo ""

# Question 43568 - Working in a Project Directory
echo "[Q43568] Running Working in a Project Directory..."
mkdir -p /home/student/project_alpha 2>/dev/null && cd /home/student/project_alpha && touch readme.txt notes.txt todo.txt && echo "Project Alpha Documentation" > readme.txt && cp readme.txt readme_backup.txt || true
echo "[Q43568] Completed"
echo ""

# Question 43569 - Manage Log Files
echo "[Q43569] Running Manage Log Files..."
mkdir -p /home/student/logs 2>/dev/null && echo -e "INFO: Started\nERROR: Failure detected\nINFO: Done" > /home/student/logs/app.log && grep "ERROR" /home/student/logs/app.log > /home/student/logs/error_only.log 2>/dev/null || true
echo "[Q43569] Completed"
echo ""

# Question 43571 - Working with Text Editors
echo "[Q43571] Running Working with Text Editors..."
mkdir -p /home/student/reports 2>/dev/null && cd /home/student/reports && touch report.txt && echo "Bannari Amman Institute of Technology - Cloud Lab." > report.txt || true
echo "[Q43571] Completed"
echo ""

# Question 43572 - Project Folder Access Control
echo "[Q43572] Running Project Folder Access Control..."
mkdir /home/student/projectA 2>/dev/null && chmod 740 /home/student/projectA 2>/dev/null || true
echo "[Q43572] Completed"
echo ""

# Question 43573 - QA Team Shared Folder Access Control
echo "[Q43573] Running QA Team Shared Folder Access Control..."
mkdir /home/student/qa_shared 2>/dev/null && chmod 764 /home/student/qa_shared 2>/dev/null && ls -ld /home/student/qa_shared 2>/dev/null || true
echo "[Q43573] Completed"
echo ""

echo ""
echo "=========================================="
echo "All Questions Completed!"
echo "=========================================="
echo ""
echo "Script execution finished at: $(date)"
echo "Total questions processed: 100+"
echo ""
echo "Note: Some commands may have failed if required directories or files don't exist."
echo "This is normal - the script continued to execute all remaining commands."
