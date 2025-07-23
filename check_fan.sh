#!/bin/bash

LOGFILE="/var/log/fan_check.log"
CONFIG_FILE="/boot/firmware/config.txt"
export DISPLAY=:0

log() {
    echo "[$(date '+%F %T')] $1" >> "$LOGFILE"
}

log "===== FAN DETECTION CHECK STARTED ====="

fan_detected=false

# 1. Check for 'fan' sensor in hwmon
if grep -iq fan /sys/class/hwmon/*/name 2>/dev/null; then
    log "[OK] Fan sensor detected in hwmon"
    fan_detected=true
fi

# 2. Check for gpio-fan overlay in config.txt
if grep -q "^dtoverlay=gpio-fan" "$CONFIG_FILE"; then
    log "[OK] dtoverlay=gpio-fan found in config.txt"
    fan_detected=true
fi

# 3. Check if gpio-fan driver is loaded in dmesg
if dmesg | grep -i gpio-fan > /dev/null; then
    log "[OK] gpio-fan detected in dmesg"
    fan_detected=true
fi

# 4. Check for manually labeled fan GPIO
if grep -iq fan /sys/kernel/debug/gpio 2>/dev/null; then
    log "[OK] Fan-related GPIO manually configured"
    fan_detected=true
fi

# Exit if fan is detected
if [ "$fan_detected" = true ]; then
    log "[SUCCESS] Fan detected. Exiting normally."
    exit 0
fi

# No fan detected — show shutdown prompt
log "[ERROR] No fan detected. Prompting user."

zenity --question \
    --title="Fan Not Detected" \
    --width=300 \
    --text="⚠️ No fan was detected on this system.\n\nWould you like to shut down now?"

if [ $? -eq 0 ]; then
    log "[ACTION] User confirmed shutdown via Zenity."
    shutdown now
else
    log "[ACTION] User canceled shutdown via Zenity. Exiting."
    exit 1
fi
