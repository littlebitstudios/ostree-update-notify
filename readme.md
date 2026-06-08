# OSTree Update Notifier

A set of scripts that provide automatic notifications for pending system updates on Fedora Atomic (and derivative) systems.

This is only tested on Universal Blue's distros ([Bazzite](https://bazzite.gg), [Bluefin](https://projectbluefin.io), [Aurora](https://getaurora.dev)), which have automatic updates enabled by default. I specifically tested on Bazzite (KDE) and Aurora, but since ostree is shared with all Fedora Atomic distros, this should work with any such distro that automatically downloads new updates.

This project is replicated on GitHub ([littlebitstudios/ostree-update-notify](https://github.com/littlebitstudios/ostree-update-notify)), Tangled ([littlebitstudios.com/ostree-update-notify](https://tangled.org/did:plc:pnudcbzg2wt4cxr7tyjtw6mk)), and [Iris Git](https://git.iris.to/#/npub1pra8zgw2hrckthu0xexs5k7xvz5mt6rsfk09e9egehnj7q8mpp9s8vr6v5/ostree-update-notify).

## Demo Images

`kdialog` variant running on Aurora:

<img width="768" height="432" alt="ostnotify-demo-kdialog" src="https://github.com/user-attachments/assets/2787d2f7-1dc6-4fbe-842f-26a249dbb974" />

`zenity` variant running on Bluefin:

<img width="768" height="414" alt="ostnotify-demo-zenity" src="https://github.com/user-attachments/assets/91b9706d-4611-4b9a-99fc-bed04668fbc6" />

*`notify-send` is not shown here because its appearance varies with different desktop environments.*

## Quick Setup

Copy one of these one-liners into a terminal and the script will download itself, show the setup prompts, and clean up the setup files.\
If you want to add custom behavior to the script, then continue to the Download and Installation sections.

Quick setup from GitHub (requires Git):
```sh
eval $(curl https://raw.githubusercontent.com/littlebitstudios/ostree-update-notify/refs/heads/main/quick-setup-github.sh)
```

Quick setup from Tangled:
```sh
eval $(curl https://tangled.org/littlebitstudios.com/ostree-update-notify/raw/main/quick-setup-tangled.sh)
```

## Behavior

If an update is available (ostree deployment staged) then a push notification (using notify-send) or dialog (using kdialog or zenity) will fire telling the user to reboot the system. The dialog variants will allow the user to reboot the system immediately by pressing "Yes".\
For the notify-send variant, the notification is sent as critical, meaning it persists on the screen until dismissed (and on KDE the notification appears with an orange bar next to it).

## Download

If you're viewing this from my file server, you can click the "zip" button (box icon) in the bottom right corner to download the contents of this folder as a zip file. \
If viewing from GitHub you can click the "Code" button on the webpage and "Download ZIP". You can also download a zip file from Iris Git.

Or use `git clone` if you have Git:
```sh
git clone https://github.com/littlebitstudios/ostree-update-notify
```

Or `git clone` from Tangled:
```sh
git clone https://tangled.org/did:plc:pnudcbzg2wt4cxr7tyjtw6mk
```

## Installation

From within the ostree-update-notify folder, run `chmod \+x \*.sh` to make the scripts executable.

Then, run `./setup.sh` to perform an automatic setup, which installs the files and enables the systemd user timer.

### Custom Functionality
There are multiple variants of the script; you can edit the variant you plan to use for custom functionality. The script explains the different notification modes, but the `kdialog` variant is recommended for KDE-based systems and the `zenity` variant is recommended for GNOME-based systems (with the `notify-send` variant being the fallback if you don't know what your environment is).

An example of custom functionality would be to add a `curl` command to trigger a remote notification with webhooks or [ntfy](https://ntfy.sh) (an open-source push notification server).

## Uninstall
If you want to remove the scripts later, run ./remove.sh. If you used the quick setup at the beginning of the readme or removed files manually after installation, you can use one of the commands below to uninstall.

### Quick Uninstall
Quick remove from GitHub (requires Git):
```sh
eval $(curl https://raw.githubusercontent.com/littlebitstudios/ostree-update-notify/refs/heads/main/quick-remove-github.sh)
```

Quick remove from Tangled:
```sh
eval $(curl https://tangled.org/littlebitstudios.com/ostree-update-notify/raw/main/quick-remove-tangled.sh)
```

## License

This project is licensed under the GNU GPL 3.0.
