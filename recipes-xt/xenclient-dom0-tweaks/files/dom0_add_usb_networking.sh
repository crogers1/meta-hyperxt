#!/bin/sh
#
# Copyright (C) Assured Information Security, Inc.
# Author: Kyle J. Temkin <temkink@ainfosec.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

# Ensure that dom0 networking is enabled.
if [ -e /config/system/dom0-networking-disabled ]; then
    echo "dom0 networking is disabled; not loading drivers."
    echo "To enable dom0 networking, use:"
    echo "    xec set enable-dom0-networking true"
    echo
    exit 1
fi

# Ensure the user isn't about to trip monit.
pidof monit > /dev/null && echo "This script cannot run while Monit is running." && exit 1

# Try to create a file; this will allow us to determine if the disk was
# read-write before we began.
rm -f /etc/disk_was_rw
touch /etc/disk_was_rw

# Fail on any error.
set -e

# Mount the dom0 disk image rw.
mount -oremount,rw /

# Install the relevant drivers, if they're not already installed.
opkg install /usr/share/xenclient/usb_network_drivers/*.ipk

# Modprobe each of our USB network drivers...
modprobe asix -f
modprobe ax88179-178a -f

# Finally, set up the network.
ifconfig eth0 inet 0.0.0.0
ifconfig eth0 up
exec udhcpc -i eth0

# Finally, restore the disk to its initial state.
if [ -e /etc/disk_was_rw ]; then
    rm /etc/disk_was_rw
else
    mount -oremount,ro /
fi



