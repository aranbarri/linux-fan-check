# Startup Fan Checker for Linux

This script runs at system startup/login and checks if a cooling fan is present on a Linux system.

If no fan is detected during startup, it shows a graphical prompt asking the user whether to shut down the system.

<img width="500" height="500" alt="ChatGPT Image 23 jul 2025, 18_08_36" src="https://github.com/user-attachments/assets/2e40397f-e0a7-4b54-b3af-22d99b1d099f" />


## Features

- Detects fan presence via:
  - hwmon sensors
  - `/boot/firmware/config.txt` overlay (`dtoverlay=gpio-fan`)
  - `dmesg` logs
  - manually labeled GPIO pins
- If no fan is detected, shows a GUI confirmation dialog (via Zenity)
- Logs to `/var/log/fan_check.log`

## Requirements

- Any Linux distribution with a graphical environment (X11 or Wayland)
- `zenity` installed (for the GUI window)
- `shutdown` command available

## Installation

1. Install Zenity:
   ```bash
   sudo apt install zenity
   ```

2. Copy the script to a permanent location:
   ```bash
   sudo cp check_fan.sh /usr/local/bin/
   sudo chmod +x /usr/local/bin/check_fan.sh
   ```

3. To run on login (autostart), copy the desktop entry:
   ```bash
   mkdir -p ~/.config/autostart
   cp fan-check.desktop ~/.config/autostart/
   ```

## Manual Execution

You can run the script manually at any time:
```bash
/usr/local/bin/check_fan.sh
```
Check the logs after executing.

## Logging

All events and decisions are logged to:
```
/var/log/fan_check.log
```

## License

MIT License
