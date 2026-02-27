# Waybar Dotfiles for Omarchy

A custom Waybar configuration featuring a retro gaming aesthetic with Pacman-themed workspace indicators.

![Waybar Preview](Waybar.png)

---

## Features

### 🎮 Workspace Styling
- **Pacman & Ghosts Theme**: Hyprland workspaces displayed as Pacman and colorful ghosts
- **Omarchy & Arch Icons**: Selectable distro icons in `config.jsonc`

### 📊 System Information
| Module | Description |
|--------|-------------|
| Network | Real-time upload/download speed display via custom script |
| Date/Time | Current date and time with update indicator |
| Wi-Fi | Wireless connection status |
| Bluetooth | Bluetooth connection status |
| Audio | Volume control indicator |
| CPU | Temperature and utilization monitoring |
| Disk | Storage usage overview |
| Battery | Battery level with percentage display |

---

## Installation

1. **Copy the network speed script**:
   ```bash
   # Create scripts directory if it doesn't exist
   mkdir -p ~/.config/waybar/scripts
   
   # Copy the net-speed.sh script
   cp scripts/net-speed.sh ~/.config/waybar/scripts/
   ```

2. **Replace configuration files**:
   ```bash
   cp config.jsonc ~/.config/waybar/
   cp style.css ~/.config/waybar/
   ```

3. **Restart Waybar** to apply changes.

---

## License

This project is licensed under the GNU General Public License v3.0 (GPL-3.0).  
See the [LICENSE](LICENSE) file for details.