#!/bin/bash

set -ouex pipefail

# Copy Files to Container
rsync -rvKl /ctx/system_files/shared/ /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1
dnf5 config-manager -y setopt rpmfusion-free.enabled=1
dnf5 config-manager -y setopt rpmfusion-free-updates.enabled=1
dnf5 config-manager -y setopt rpmfusion-nonfree.enabled=1
dnf5 config-manager -y setopt rpmfusion-nonfree-updates.enabled=1
# this installs a package from fedora repos
dnf5 install -y tmux kvantum mpd intel-compute-runtime oneapi-level-zero intel-level-zero-gpu-raytracing

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

mkdir /nix
