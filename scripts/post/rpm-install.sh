#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
# set -oue pipefail

# Your code goes here.
rpm-ostree install https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm

# rpm-ostree override replace "/tmp/scripts/post/rpm/steam-1.0.0.78-1.fc38.i686.rpm"
