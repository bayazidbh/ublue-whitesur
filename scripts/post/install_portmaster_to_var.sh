#!/usr/bin/env bash
set -e # Exit on error

if [ "$EUID" -ne 0 ]; then
	echo "To ensure correct permissions, this script must be run as root."
	exit 1
fi

install_location="/var/lib/safing-portmaster" # Must not include trailing slash

echo "-> Creating Portmaster program directory at '${install_location}'"
mkdir -p "${install_location}"

echo "-> Creating Portmaster exports directory at '${install_location}/exports'"
mkdir -p "${install_location}/exports/share/applications"
mkdir -p "${install_location}/exports/share/icons"
mkdir -p "${install_location}/exports/units"

temp_dir=$(mktemp -d)


echo "-> Downloading 'portmaster-start'"
wget -q --show-progress -O "$temp_dir/portmaster-start" https://updates.safing.io/latest/linux_amd64/start/portmaster-start
echo "-> Downloading 'portmaster.service'"
wget -q --show-progress -O "$temp_dir/portmaster.service" https://raw.githubusercontent.com/safing/portmaster-packaging/master/linux/portmaster.service
echo "-> Downloading 'portmaster.desktop'"
wget -q --show-progress -O "$temp_dir/portmaster.desktop" https://raw.githubusercontent.com/safing/portmaster-packaging/master/linux/portmaster.desktop
echo "-> Downloading 'portmaster_notifier.desktop'"
wget -q --show-progress -O "$temp_dir/portmaster_notifier.desktop" https://raw.githubusercontent.com/safing/portmaster-packaging/master/linux/portmaster_notifier.desktop
echo "-> Downloading 'portmaster_logo.png'"
wget -q --show-progress -O "$temp_dir/portmaster_logo.png" https://raw.githubusercontent.com/safing/portmaster-packaging/master/linux/portmaster_logo.png


echo "-> Patching paths in 'portmaster.service'"
sed -i "s|/opt/safing/portmaster|${install_location}|g" "$temp_dir/portmaster.service"
echo "-> Patching paths in 'portmaster.desktop'"
sed -i "s|/opt/safing/portmaster|${install_location}|g" "$temp_dir/portmaster.desktop"
echo "-> Patching paths in 'portmaster_notifier.desktop'"
sed -i "s|/opt/safing/portmaster|${install_location}|g" "$temp_dir/portmaster_notifier.desktop"


echo "-> Installing 'portmaster-start' and setting security context"
install -m 0755 "$temp_dir/portmaster-start" "${install_location}/portmaster-start"
chcon -t bin_t "${install_location}/portmaster-start"
echo "-> Installing 'portmaster.service'"
install -m 0644 "$temp_dir/portmaster.service" "${install_location}/exports/units/portmaster.service"
echo "-> Installing 'portmaster.desktop'"
install -m 0644 "$temp_dir/portmaster.desktop" "${install_location}/exports/share/applications/portmaster.desktop"
echo "-> Installing 'portmaster_notifier.desktop'"
install -m 0644 "$temp_dir/portmaster_notifier.desktop" "${install_location}/exports/share/applications/portmaster_notifier.desktop"
echo "-> Installing 'portmaster_logo.png' (as 'portmaster.png')"
install -m 0644 "$temp_dir/portmaster_logo.png" "${install_location}/exports/share/icons/portmaster.png"

echo "-> Running 'portmaster-start update' to download Portmaster data"
"${install_location}/portmaster-start" update --data="${install_location}"

echo "-> (Workaround) Moving 'portmaster.service' to '/etc/systemd/system' and reverse-symlinking it since systemd wants units on the same filesystem"
mv "${install_location}/exports/units/portmaster.service" /etc/systemd/system/portmaster.service
ln -s /etc/systemd/system/portmaster.service "${install_location}/exports/units/portmaster.service"

echo "-> Enabling 'portmaster' service"
systemctl daemon-reload
systemctl enable "portmaster.service"

echo "-> Creating 'portmaster_notifier' autostart"
ln -s "${install_location}/exports/share/applications/portmaster_notifier.desktop" /etc/xdg/autostart/portmaster_notifier.desktop

echo "-> Adding '$install_location' to \$XDG_DATA_DIRS to show desktop entries (applies after next login)"
echo "XDG_DATA_DIRS=$install_location/exports/share:\$XDG_DATA_DIRS" >/etc/profile.d/zzz-portmaster-to-xdg-data-dirs.sh # We prepend 'zzz' since profile.d scripts aren't numbered on Fedora, and we want to run after any other scripts that modify XDG_DATA_DIRS.

echo "-> Removing '${temp_dir}'"
rm -rf "$temp_dir"

echo "-> Done, Portmaster and its tray/notifier application will start with the next boot."
