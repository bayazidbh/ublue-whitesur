#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
# set -oue pipefail

# Your code goes here.
rpm-ostree install https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
rpm-ostree override replace ./post/steam-1.0.0.78-1.fc38.i686.rpm

# rpm-ostree install https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
# rpm-ostree install https://github.com/bayazidbh/ublue-kinoite-customized/raw/live/scripts/post/rpm/epson-inkjet-printer-escpr-1.7.26-1lsb3.2.x86_64.rpm
# rpm-ostree install https://github.com/bayazidbh/ublue-kinoite-customized/raw/live/scripts/post/rpm/epson-printer-utility-1.1.1-1lsb3.2.x86_64.rpm
# rpm-ostree install https://github.com/bayazidbh/ublue-kinoite-customized/raw/live/scripts/post/rpm/epsonscan2-6.7.61.0-1.x86_64.rpm
# rpm-ostree install https://github.com/bayazidbh/ublue-kinoite-customized/raw/live/scripts/post/rpm/epsonscan2-non-free-plugin-1.0.0.6-1.x86_64.rpm
