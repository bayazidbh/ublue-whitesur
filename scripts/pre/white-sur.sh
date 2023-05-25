#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Install white-sur themes
rpm-ostree install glib2-devel sassc libappstream-glib

mkdir -p ./whitesur

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme ./whitesur/WhiteSur-gtk-theme
./whitesur/WhiteSur-gtk-theme/install.sh -m -i standard -b default

git clone https://github.com/vinceliuice/WhiteSur-icon-theme ./whitesur/WhiteSur-icon-theme
./whitesur/WhiteSur-icon-theme/install.sh

git clone https://github.com/vinceliuice/WhiteSur-kde ./whitesur/WhiteSur-kde
./whitesur/WhiteSur-kde/install.sh
./whitesur/WhiteSur-kde/sddm/install.sh

git clone https://github.com/vinceliuice/WhiteSur-cursors ./whitesur/WhiteSur-cursors
./whitesur/WhiteSur-cursors/install.sh

git clone https://github.com/vinceliuice/Monterey-kde ./whitesur/Monterey-kde
./whitesur/Monterey-kde/install.sh
./whitesur/Monterey-kde/sddm/install.sh
