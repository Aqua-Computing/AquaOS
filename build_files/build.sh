#!/bin/bash

set -ouex pipefail

IMAGE_PRETTY_NAME="AquaOS"
IMAGE_LIKE="fedora"

#### Branding 

tee /usr/lib/os-release <<EOF
NAME="${IMAGE_PRETTY_NAME}"
VERSION="$1.0 (One)"
RELEASE_TYPE=development
ID=aquaos
ID_LIKE="${IMAGE_LIKE}"
VERSION_ID=$1
VERSION_CODENAME="$RainDrop"
PRETTY_NAME="$AquaOS"
ANSI_COLOR="0;38;2;255;255;255"
CPE_NAME="cpe:/o:aqua-computing:aquaos-1"
DEFAULT_HOSTNAME="aqua"
HOME_URL="https://github.com/Aqua-Computing/AquaOS"
DOCUMENTATION_URL="https://github.com/Aqua-Computing/AquaOS"
SUPPORT_URL="https://github.com/Aqua-Computing/AquaOS/issues"
BUG_REPORT_URL="https://github.com/Aqua-Computing/AquaOS/issues"
SUPPORT_END=$2027-12-31
OSTREE_VERSION='$1.0'
BUILD_ID="$Development 1.0"
BOOTLOADER_NAME="${IMAGE_PRETTY_NAME} One"
IMAGE_ID="$aquaos-1.0"
EOF

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux
dnf5 install -y htop

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket



