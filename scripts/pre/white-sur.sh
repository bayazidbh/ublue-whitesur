#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Install white-sur themes
rpm-ostree install glib2-devel sassc libappstream-glib

mkdir -p /tmp/whitesur

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme /tmp/whitesur/WhiteSur-gtk-theme
/tmp/whitesur/WhiteSur-gtk-theme/install.sh -m -i standard -b default

git clone https://github.com/vinceliuice/WhiteSur-icon-theme /tmp/whitesur/WhiteSur-icon-theme
/tmp/whitesur/WhiteSur-icon-theme/install.sh

git clone https://github.com/vinceliuice/WhiteSur-kde /tmp/whitesur/WhiteSur-kde
/tmp/whitesur/WhiteSur-kde/install.sh
/tmp/whitesur/WhiteSur-kde/sddm/install.sh

git clone https://github.com/vinceliuice/WhiteSur-cursors /tmp/whitesur/WhiteSur-cursors
/tmp/whitesur/WhiteSur-cursors/install.sh

git clone https://github.com/vinceliuice/Monterey-kde /tmp/whitesur/Monterey-kde
/tmp/whitesur/Monterey-kde/install.sh
/tmp/whitesur/Monterey-kde/sddm/install.sh
