#!/bin/bash

# Check if a pending deployment exists
rpm-ostree status --pending-exit-77

# Check the exit code of the previous command ($?)
if [ $? -eq 77 ]; then
    # If the exit code is 77, a deployment is staged.
    # The notification is set to critical to force it to persist on the screen until dismissed
    notify-send --urgency=critical \
    "Update ready, reboot your system" \
    "Your system has been updated in the background. Reboot to apply the updates."
fi
