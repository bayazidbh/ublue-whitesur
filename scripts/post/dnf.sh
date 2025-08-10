#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
dnf install -y --no-best plasma-discover-flatpak plasma-discover-kns plasma-discover-notifier /tmp/scripts/post/rpm/discord-canary-0.0.736-2.fc42.x86_64.rpm
