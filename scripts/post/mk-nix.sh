#!/usr/bin/env bash

set -ouex pipefail

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!

# Your code goes here.
mkdir /nix
echo "keep" > /nix/.keep