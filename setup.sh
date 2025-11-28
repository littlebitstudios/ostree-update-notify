#!/bin/bash

# setup.sh

set -euo pipefail

echo ""
echo "--- OSTree Update Notifier Setup ---"
echo "This script will perform the following actions:"
echo "- Create necessary directories: $HOME/.config/systemd/user and $HOME/userscripts"
echo "- Copy unit files to: $HOME/.config/systemd/user"
echo "- Copy script file to: $HOME/userscripts"
echo "- Reload the user systemd manager"
echo "- Enable and start the update check timer"
echo "--------------------------------------"
echo ""

# --- 1. User Input Logic: Start/Cancel ---
read -r -p "Press Enter to continue or any other key to cancel: " USER_INPUT

if [[ -n "$USER_INPUT" ]]; then
    echo "Setup cancelled by user."
    exit 1
fi

echo ""
echo "------ Select Notification Mode ------"
echo "This script supports three options for notifying you about updates, two of which are actionable."
echo ""
echo "kdialog: Actionable dialog for KDE-based systems."
echo "zenity: Actionable dialog for GNOME-based systems."
echo "notify-send: Non-actionable push notification."
echo ""
echo "Generally, if you're seeing a Windows-like taskbar, you're on KDE."
echo "If you're seeing a top panel with a clock in the center, you're on GNOME."
echo "If you don't know what environment you're on, choose notify-send."
echo "--------------------------------------"
echo ""

# --- 1. User Input Logic: Notification Mode with Validation ---
# Removed the redundant 'read' command here.

while true; do
    # This 'read' command is now the only one prompting for the notification option
    read -r -p "Choose your notification option (kdialog/zenity/notify-send): " SCRIPT_VARIANT

    # Convert the input to lowercase for case-insensitive checking
    # This makes 'KDialog', 'kDIALOG', and 'kdialog' all valid
    SCRIPT_VARIANT_LOWER=$(echo "$SCRIPT_VARIANT" | tr '[:upper:]' '[:lower:]')

    case "$SCRIPT_VARIANT_LOWER" in
        # Valid options
        kdialog|zenity|notify-send)
            # Input is valid, so break out of the while loop
            echo ""
            echo "--- Selection Validated: Using $SCRIPT_VARIANT_LOWER mode. ---"
            break
            ;;

        # Invalid option (includes empty input)
        *)
            echo "❌ Invalid option: '$SCRIPT_VARIANT'. Please choose one of 'kdialog', 'zenity', or 'notify-send'."
            echo ""
            ;;
    esac
done

# --- 2. Directory Creation and File Copy ---

# Create the user systemd directory if it doesn't exist (using -p for 'parents' and 'no error if exists')
echo "Creating directory: $HOME/.config/systemd/user"
mkdir -p $HOME/.config/systemd/user

# Create the user scripts directory
echo "Creating directory: $HOME/userscripts"
mkdir -p $HOME/userscripts

# Copy the unit files (using $HOME for path expansion)
echo "Copying unit and timer files..."
cp ./ostree-update-notify.service $HOME/.config/systemd/user/
cp ./ostree-update-notify.timer $HOME/.config/systemd/user/

# Copy the executable script (ensuring we set the executable bit)
echo "Copying script and setting permissions..."
cp "./ostree-update-notify_$SCRIPT_VARIANT_LOWER.sh" $HOME/userscripts/
chmod +x "$HOME/userscripts/ostree-update-notify_$SCRIPT_VARIANT_LOWER.sh"

# Rename the copied script to the common name
echo "Renaming script to ostree-update-notify.sh..."
mv "$HOME/userscripts/ostree-update-notify_$SCRIPT_VARIANT_LOWER.sh" $HOME/userscripts/ostree-update-notify.sh

# --- 3. Systemd Activation ---

echo "Reloading user systemd daemon..."
systemctl --user daemon-reload

echo "Enabling and starting the ostree update check timer..."
# The timer is usually started with --now to run the initial check immediately
systemctl --user enable --now ostree-update-notify.timer

echo "--- Setup Complete! ---"
echo "You will now see notifications for system updates."
