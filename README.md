# Fan Checker for Linux with GUI

This script detects if a cooling fan is present on a Linux system. 

If no fan is found, it prompts the user with a graphical window asking whether to shut down the system.

<img width="1024" height="1024" alt="ChatGPT Image 23 jul 2025, 18_08_36" src="https://github.com/user-attachments/assets/093eaf06-8d2c-46ba-80f4-50c4ccf2d0d1" />


## Features

- Detects fan presence via:
  - hwmon sensors
  - `/boot/firmware/config.txt` overlay (`dtoverlay=gpio-fan`)
  - `dmesg` logs
  - manually labeled GPIO pins
- If no fan is detected, shows a GUI confirmation dialog (via Zenity)
- Logs to `/var/log/fan_check.log`
- Intended for Raspberry Pi but works on any Linux system with a desktop environment

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

## Logging

All events and decisions are logged to:
```
/var/log/fan_check.log
```

## License

MIT License
