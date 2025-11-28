#!/bin/bash

set -euo pipefail

SERVICE_NAME="ostree-update-notify"
USER_SCRIPT_PATH="$HOME/userscripts/${SERVICE_NAME}.sh"
USER_SERVICE_PATH="$HOME/.config/systemd/user/${SERVICE_NAME}.service"
USER_TIMER_PATH="$HOME/.config/systemd/user/${SERVICE_NAME}.timer"

echo ""
echo "--- OSTree Update Notifier Removal ---"
echo "This will remove the OSTree Update Notifier from your system."
echo "--------------------------------------"
echo ""

# --- 1. User Input Logic ---
read -r -p "Press Enter to continue or any other key to cancel: " USER_INPUT

if [[ -n "$USER_INPUT" ]]; then
    echo "Removal cancelled by user."
    exit 1
fi

# --- 1. Systemd Deactivation (Stopping Timer) ---

echo "Stopping and disabling the systemd timer..."
# It's crucial to disable/stop the timer first, before removing its files.
# Use '|| true' to prevent script exit on error if the unit is already inactive.
systemctl --user disable --now "${SERVICE_NAME}.timer" || true
systemctl --user stop "${SERVICE_NAME}.timer" || true

# --- 2. File Removal (Physical Deletion) ---

# Remove the unit files
echo "Removing unit files..."
# rm -f ignores errors if the file doesn't exist.
rm -f "${USER_SERVICE_PATH}"
rm -f "${USER_TIMER_PATH}"

# Remove the script file
echo "Removing script file..."
rm -f "${USER_SCRIPT_PATH}"

# --- 3. Systemd Cleanup (Final Reload) ---

# This step must be last to remove systemd's knowledge of the units
# after they have been physically deleted from the filesystem.
echo "Reloading user systemd daemon to finalize removal..."
systemctl --user daemon-reload

echo "--- Removal Complete! ---"