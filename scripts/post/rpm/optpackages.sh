#!/usr/bin/env bash
set -oue pipefail

RECIPE_FILE="/usr/share/ublue-os/recipe.yml"
get_yaml_array() {
    mapfile -t "${1}" < <(yq -- "${2}" "${RECIPE_FILE}")
}

# Add repo files.
get_yaml_array optpackages '.rpm.optfix[]'
if [[ ${#optpackages[@]} -gt 0 ]]; then
    echo "-- Creating symlinks to fix packages that install to /opt --"
    mkdir -p "/var/opt"
    ln -s "/var/opt"  "/opt"
    for optpackage in "${optpackages[@]}"; do
        optpackage="${optpackage%\"}"
        optpackage="${optpackage#\"}"
        mkdir -p "/usr/lib/opt/${optpackage}"
        ln -s "../../usr/lib/opt/${optpackage}" "/var/opt/${optpackage}"
        echo "Created symlinks for ${optpackage}"
    done
    echo "---"
fi
