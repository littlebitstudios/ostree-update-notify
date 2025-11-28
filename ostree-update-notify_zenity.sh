#!/bin/bash

# Check if a pending deployment exists
rpm-ostree status --pending-exit-77

# Check the exit code of the previous command ($?)
if [ $? -eq 77 ]; then
    zenity --question --text="A system update is ready. Reboot the system now?"

    if [ $? -eq 0 ]; then
       reboot
    fi
fi
