# **OSTree Update Notifier**

A set of scripts that provide automatic notifications for pending system updates on Fedora Atomic (and derivative) systems.

This is only tested on Universal Blue's distros ([Bazzite](https://bazzite.gg), [Bluefin](https://projectbluefin.io), [Aurora](https://getaurora.dev)), which have automatic updates enabled by default. I specifically tested on Bazzite (KDE) and Aurora, but since ostree is shared with all Fedora Atomic distros, this should work with any such distro that automatically downloads new updates.

This project is replicated on my home server at https://files.littlebitstudios.com/share/ostree-update-notify and on GitHub at https://github.com/littlebitstudios/ostree-update-notify.

## Demo Images

`kdialog` variant running on Aurora:

![ostnotify kdialog demo](https://files.littlebitstudios.com/public/ostnotify-demo-kdialog-0.4x.png)

`zenity` variant running on Bluefin:

![ostnotify zenity demo](https://files.littlebitstudios.com/public/ostnotify-demo-zenity-0.4x.png)

*`notify-send` is not shown here because its appearance varies with different desktop environments.*

## Quick Setup

Copy this one-liner into a terminal and the script will download itself, show the setup prompts, and clean up the setup files.\
If you want to add custom behavior to the script, then continue to the Download and Installation sections.

```sh
eval $(curl https://files.littlebitstudios.com/share/ostree-update-notify/quick-setup.sh)
```

You can also use this line instead to quick setup from GitHub (requires Git):
```sh
git clone https://github.com/littlebitstudios/ostree-update-notify && cd ostree-update-notify && chmod +x *.sh && ./setup.sh && cd .. && rm -rf ostree-update-notify
```

## **Behavior**

If an update is available (ostree deployment staged) then a push notification (using notify-send) or dialog (using kdialog or zenity) will fire telling the user to reboot the system. The dialog variants will allow the user to reboot the system immediately by pressing "Yes".\
For the notify-send variant, the notification is sent as critical, meaning it persists on the screen until dismissed (and on KDE the notification appears with an orange bar next to it).

## **Download**

If you're viewing this from my file server, you can click the "zip" button (box icon) in the bottom right corner to download the contents of this folder as a zip file. \
If viewing from GitHub you can click the "Code" button on the webpage and "Download ZIP".

You can also paste the below command into a terminal to download the contents of this repository:
```sh
curl https://files.littlebitstudios.com/share/ostree-update-notify?tar | tar -x
```

Or use `git clone` if you have Git:
```sh
git clone https://github.com/littlebitstudios/ostree-update-notify
```

## **Installation**

From within the ostree-update-notify folder, run `chmod \+x \*.sh` to make the scripts executable.

Then, run `./setup.sh` to perform an automatic setup, which installs the files and enables the systemd user timer.

### **Custom Functionality**
There are multiple variants of the script; you can edit the variant you plan to use for custom functionality. The script explains the different notification modes, but the `kdialog` variant is recommended for KDE-based systems and the `zenity` variant is recommended for GNOME-based systems (with the `notify-send` variant being the fallback if you don't know what your environment is).

An example of custom functionality would be to add a `curl` command to trigger a remote notification with webhooks or [ntfy](https://ntfy.sh) (an open-source push notification server).
## **Uninstall**
If you want to remove the scripts later, run ./remove.sh. If you used the quick setup at the beginning of the readme or removed files manually after installation, you can use one of the commands below to uninstall.

### Quick Uninstall
Copy this into a terminal:
```sh
eval $(curl https://files.littlebitstudios.com/share/ostree-update-notify/quick-remove.sh)
```

You can also use this line instead to quick remove from GitHub (requires Git):
```sh
git clone https://github.com/littlebitstudios/ostree-update-notify && cd ostree-update-notify && chmod +x *.sh && ./remove.sh && cd .. && rm -rf ostree-update-notify
```

## License

This project is licensed under the GNU GPL 3.0.
