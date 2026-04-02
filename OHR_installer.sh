#!/bin/bash
#
# Pi-Star GitHub Installer
# By WRQC343 - gmrs-link.com
#

BASE_URL="https://raw.githubusercontent.com/Justice57201/OHR/main"

echo "======================================"
echo " Pi-Star GitHub Installer Starting"
echo "======================================"

echo "[1/5] RW filesystem..."
mount -o remount,rw /

TMP_DIR="/tmp/pistar_install"
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR" || exit 1

echo "[2/5] Downloading from GitHub..."

wget "$BASE_URL/HostFilesUpdate.sh" || { echo "Download failed: HostFilesUpdate.sh"; exit 1; }
wget "$BASE_URL/lh.txt" || { echo "Download failed: lh.txt"; exit 1; }
wget "$BASE_URL/localtx.txt" || { echo "Download failed: localtx.txt"; exit 1; }

echo "[3/5] Installing..."

mv HostFilesUpdate.sh /usr/local/sbin/
chmod 755 /usr/local/sbin/HostFilesUpdate.sh

mv lh.txt /var/www/dashboard/mmdvmhost/lh.php
mv localtx.txt /var/www/dashboard/mmdvmhost/localtx.php

chmod 644 /var/www/dashboard/mmdvmhost/lh.php
chmod 644 /var/www/dashboard/mmdvmhost/localtx.php

echo "[4/5] Cleaning..."
cd / || exit 1
rm -rf "$TMP_DIR"

echo "[5/5] Running HostFilesUpdate.sh..."
cd / || exit 1
/usr/local/sbin/HostFilesUpdate.sh

echo "======================================"
echo " GitHub Install Complete!"
echo "======================================"