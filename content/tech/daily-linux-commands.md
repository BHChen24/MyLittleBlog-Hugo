---
title: "Daily Linux commands"
date: 2026-09-10T11:27:00
description: "Use Linux like the Windows"
tags: ["linux"]
categories: ["Practices"]
---

> 🔔 **Prelude:
> With these commands you are able to do most text-related work the same as you are on Windows.**

## Linux Common Commands

### System Management

#### System Information

```bash
# Basic system information
lscpu                                  # Detailed CPU information
uname -a                               # Kernel and architecture info
cat /etc/os-release                    # Distribution information

# Hardware information
lsblk                                  # Block devices
lsusb                                  # USB devices
lspci                                  # PCI devices

```

#### Package Management

```bash
# dpkg package management
sudo dpkg -i package.deb                           # Install deb package
dpkg -l | grep package_name                        # Search installed packages
dpkg -L package_name                               # List package files
dpkg -S /path/to/file                              # Find which package owns file

```

### Monitoring and Performance

#### Memory and Disk

```bash
# Memory usage
free -h                                # Human readable format
watch -n 1 free -h                     # Real-time monitoring

# Disk usage
df -h                                  # Disk usage
du -sh /path/to/directory              # Directory size
du -h --max-depth=1 | sort -hr         # Sort directories by size
sudo fdisk -l                          # Partition table info

```

#### System Monitoring

```bash
# Temperature monitoring
vcgencmd measure_temp                   # Raspberry Pi temperature
sensors                                # General temperature sensors
watch -n 1 vcgencmd measure_temp        # Real-time temperature monitoring

# Process monitoring
ps aux                                 # All processes
top                                    # Real-time process monitor
htop                                   # Enhanced top
ps aux --sort=-%mem | head -10         # Sort by memory usage
ps aux --sort=-%cpu | head -10         # Sort by CPU usage

# I/O monitoring
sudo iotop                             # I/O usage
sudo iotop -o                          # Show only processes doing I/O

```

#### Network Monitoring

```bash
# Connection status
ss -tuln                               # Network connections
ss -a                                  # All connections
ss -tuln | grep :22                    # Specific port

# Traffic monitoring
iftop                                  # Interface traffic (requires installation)
nethogs                               # Traffic by process (requires installation)

```

### Processes and Services

#### Process Management

```bash
# Find processes
pgrep -f "process_name"                # Find process PID
ps aux | grep "process_name"           # Detailed information

# Terminate processes
kill PID                               # Normal termination
kill -9 PID                            # Force termination
pkill "process_name"                   # Terminate by name

```

#### Background Jobs

```bash
# Background execution
command &                              # Start in background
nohup command &                        # Run without hangup

# Job control
Ctrl + Z                               # Suspend current process
bg                                     # Continue in background
fg                                     # Bring to foreground
jobs                                   # List background jobs

# tmux sessions
tmux new-session -d -s session_name "command"
tmux attach -t session_name

```

#### Service Management

```bash
# systemd services
systemctl status service_name          # Check status
systemctl start/stop/restart service_name
systemctl enable/disable service_name  # Auto-start on boot

# Log viewing
journalctl -u service_name             # Service logs
journalctl -f                          # Real-time logs
journalctl --since "2 hours ago"       # Time range

```

#### Scheduled Tasks

```bash
# cron jobs
crontab -e                             # Edit
crontab -l                             # List

# Syntax: minute hour day month weekday command
# 0 2 * * * /home/user/backup.sh      # Run daily at 2 AM
# */10 * * * * /usr/bin/check.sh      # Run every 10 minutes

```

### Network Management

#### Network Interfaces

```bash
# View network interfaces
ip addr show                           # All interfaces
ip a                                   # Short form
ip link show up                        # Enabled interfaces

# Manage interfaces
sudo ip link set eth0 up/down          # Enable/disable interface

# Routing information
ip route show                          # Routing table
ip route | grep default                # Default gateway

```

#### WiFi Management

```bash
# NetworkManager
nmcli dev wifi list                    # Scan WiFi
nmcli dev wifi connect "SSID" password "password"
nmcli connection show                  # Saved connections

# Traditional tools
iwconfig                               # WiFi interface status

```

#### Network Testing

```bash
# Connectivity testing
ping google.com
ping -c 4 google.com                   # Limit count
traceroute google.com                  # Path tracing

# Port testing
nc -zv google.com 80                   # Port connectivity
nmap -p 22,80,443 target_host          # Port scanning

# DNS queries
dig google.com                         # DNS lookup
cat /etc/resolv.conf                   # DNS configuration

# Firewall
sudo ufw status                        # Ubuntu firewall status

```

### Files and Text

#### File Finding

```bash
# Find by name
find /path -name "filename"
find . -name "*.txt"                   # By extension
find . -type f -name "*.log"           # Files only
find . -type d -name "temp*"           # Directories only

# Command location
which python3                          # Command location
whereis python3                        # Binary, source, manual

# Fast search
sudo updatedb                          # Update database
locate filename                        # Quick search

```

#### Content Search

```bash
# Basic search
grep "pattern" file.txt
grep "pattern" *.txt                   # Multiple files

# Common options
grep -i "pattern" file                 # Ignore case
grep -r "pattern" directory/           # Recursive search
grep -n "pattern" file                 # Show line numbers
grep -v "pattern" file                 # Invert match

# Context search
grep -A 3 "pattern" file               # Show 3 lines after
grep -B 3 "pattern" file               # Show 3 lines before
grep -C 3 "pattern" file               # Show 3 lines around

```

#### File Content Operations

```bash
# View files
cat file.txt                           # Full content
head -20 file.txt                      # First 20 lines
tail -20 file.txt                      # Last 20 lines
tail -f file.txt                       # Follow changes
less file.txt                          # Paged viewing

# Sort and unique
sort file.txt                          # Sort
sort -n numbers.txt                    # Numeric sort
sort file.txt | uniq                   # Remove duplicates

# File comparison
diff file1.txt file2.txt               # Basic comparison
diff -u file1 file2                    # Unified format
diff -y file1 file2                    # Side-by-side

```

#### Text Processing and Pipes

```bash
# sed stream editor
sed 's/old/new/g' file.txt             # Global replacement
sed -i 's/old/new/g' file.txt          # In-place modification
sed '/pattern/d' file.txt              # Delete matching lines
sed -n '1,10p' file.txt                # Print specific lines

# awk text processing
awk '{print $1}' file.txt              # Print first column
awk '{print $1, $3}' file.txt          # Print multiple columns
awk '/pattern/ {print $2}' file.txt    # Conditional print
awk -F':' '{print $1}' /etc/passwd     # Specify delimiter
awk '{sum += $1} END {print sum}' numbers.txt  # Calculate sum

# Pipes and redirection
command > file.txt                     # Output redirection
command >> file.txt                    # Append redirection
command 2> error.log                   # Error redirection
command &> all.log                     # All output redirection

# Pipe operations
command1 | command2                    # Basic pipe
cat log | grep "ERROR" | awk '{print $1}' | sort | uniq -c

# tee splitting
command | tee file.txt                 # Output to both file and terminal
command | tee -a file.txt              # Append mode
echo "text" | sudo tee /root/file.txt > /dev/null  # Privilege escalation write

```

### Transfer and Compression

#### Network Downloads

```bash
# wget downloads
wget https://example.com/file.zip
wget -O newname.zip https://example.com/file.zip  # Specify filename
wget -c https://example.com/largefile.iso         # Resume download

# curl downloads
curl -O https://example.com/file.zip               # Keep original filename
curl -o newname.zip https://example.com/file.zip   # Specify filename
curl -C - -O https://example.com/largefile.iso     # Resume download

```

#### Remote Transfer

```bash
# scp secure copy
scp file.txt user@remote:/path/                    # Upload file
scp -r directory/ user@remote:/path/               # Upload directory
scp user@remote:/path/file.txt ./                  # Download file
scp -P 2222 file.txt user@remote:/path/            # Specify port

# rsync synchronization
rsync -av source/ destination/                     # Basic sync
rsync -av --delete source/ destination/            # Delete extra files
rsync -av source/ user@remote:/path/               # Remote sync
rsync -avz --progress source/ destination/         # Compression + progress

```

#### Compression and Extraction

```bash
# tar archives
tar -czf archive.tar.gz files/                     # Create compressed archive
tar -xzf archive.tar.gz                            # Extract archive
tar -tzf archive.tar.gz                            # View contents
tar -xzf archive.tar.gz -C /destination/           # Extract to directory

# zip compression
zip -r archive.zip directory/                      # Compress directory
unzip archive.zip                                  # Extract
unzip archive.zip -d /destination/                 # Extract to directory
unzip -l archive.zip                               # View contents

```

### Device Management

#### USB Devices

```bash
# USB device management
lsusb                                  # USB device list
lsusb -v                               # Detailed information
watch -n 1 lsusb                       # Real-time monitoring

# Mount USB
sudo mkdir /mnt/usb
sudo mount /dev/sdb1 /mnt/usb          # Mount
sudo umount /mnt/usb                   # Unmount

```

#### Bluetooth Devices

```bash
# Bluetooth management
systemctl status bluetooth             # Service status
sudo hciconfig hci0 up                 # Enable adapter
sudo hcitool scan                      # Scan devices

# Bluetooth console
bluetoothctl
# Common commands: power on, scan on, pair <MAC>, connect <MAC>

```

#### Audio Devices

```bash
# Audio devices
aplay -l                               # Playback devices
arecord -l                             # Recording devices
pactl list sinks short                 # PulseAudio output devices

# Volume control
alsamixer                              # Graphical mixer
amixer sset Master 80%                 # Set volume
pactl set-sink-volume @DEFAULT_SINK@ 50%

```

### Quick Operations

#### History Operations

```bash
# History search
Ctrl + R                               # Reverse search history
Ctrl + S                               # Forward search history
history                                # Show history list
history | grep "pattern"               # Search history commands

# ! operator (history expansion)
!!                                     # Repeat last command
!$                                     # Last argument of previous command
!^                                     # First argument of previous command
!*                                     # All arguments of previous command
!n                                     # Execute nth command in history
!ssh                                   # Execute most recent command starting with ssh
!?config                               # Execute most recent command containing config

# Quick substitution
^old^new                               # Replace old with new in last command
!!:s/old/new                           # Same as above, sed-style replacement
sudo !!                                # Add sudo to previous command

# Argument operations
echo !$                                # Show last argument of previous command
ls !*                                  # Use all arguments from previous command with ls

```

#### Quick Editing

```bash
# Cursor movement
Ctrl + A                               # Move to beginning of line
Ctrl + E                               # Move to end of line
Ctrl + F                               # Move forward one character
Ctrl + B                               # Move backward one character
Alt + F                                # Move forward one word
Alt + B                                # Move backward one word

# Deletion operations
Ctrl + K                               # Delete from cursor to end of line
Ctrl + U                               # Delete from cursor to beginning of line
Ctrl + W                               # Delete previous word
Alt + D                                # Delete next word
Ctrl + H                               # Delete previous character (same as Backspace)
Ctrl + D                               # Delete current character

# Copy and paste
Ctrl + Y                               # Paste last deleted content
Alt + Y                                # Cycle through deletion history

# Other editing
Ctrl + T                               # Transpose current and previous character
Alt + T                                # Transpose current and previous word
Alt + U                                # Convert current word to uppercase
Alt + L                                # Convert current word to lowercase
Alt + C                                # Capitalize current word
Ctrl + _                               # Undo last edit

# System control
Ctrl + L                               # Clear screen
Ctrl + C                               # Interrupt current command
Ctrl + Z                               # Suspend current process
Ctrl + D                               # End input/exit shell

# Auto-completion
Tab                                    # Auto-complete
Tab Tab                                # Show all possible completions
Alt + .                                # Insert last argument of previous command
Alt + *                                # Expand all possible completions for current word

```

#### Directory and File Operations

```bash
# Directory operations
cd -                                   # Return to previous directory
pushd/popd                             # Directory stack operations
mkdir -p path/to/deep/directory        # Create nested directories

# {} Brace expansion - generates multiple names
touch file{1,2,3}.txt                  # Creates file1.txt file2.txt file3.txt
mkdir {backup,temp,logs}               # Create multiple directories
cp file.txt{,.bak}                     # Copy to file.txt.bak
echo {A..Z}                           # Expand A B C ... Z
echo {1..10}                          # Expand 1 2 3 ... 10
echo {01..10}                         # Expand 01 02 03 ... 10 (preserve format)

# [] Bracket matching - matches existing files
ls file[123].txt                       # Match file1.txt file2.txt file3.txt
ls file[1-5].txt                       # Match file1.txt to file5.txt
ls [abc]*.txt                          # Match txt files starting with a, b, or c
ls [A-Z]*.log                          # Match log files starting with uppercase
ls file[!123].txt                      # Match files except file1,2,3.txt
rm temp[0-9][0-9].tmp                  # Delete files like temp01.tmp to temp99.tmp

# Wildcard combinations
cp *.{jpg,png,gif} images/             # Copy all image files
ls file[1-3].{txt,log}                 # Match file1.txt, file1.log, etc.
find . -name "*[0-9].txt"              # Find txt files ending with digits

```
