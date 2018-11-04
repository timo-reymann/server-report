#!/bin/bash

# Install location for conf and co
INSTALL_LOCATION="/opt/server-report"

# Specify folder for binary
LINK_TO="/usr/local/sbin"

# Require root
if [ "$(whoami)" != "root" ]; then
        echo "ERROR Install script must be run as root"
        exit -1
fi

echo ""
echo "ServerReport installer"
echo ""


echo "Creating install location at $INSTALL_LOCATION ..."
mkdir -p $INSTALL_LOCATION


# Find __ARCHIVE__ maker, read archive content and decompress it
ARCHIVE=$(awk '/^__ARCHIVE__/ {print NR + 1; exit 0; }' "${0}")
tail -n+${ARCHIVE} "${0}" | tar xpJv -C ${INSTALL_LOCATION}


echo "Creating plugins folder, if not already present ..."
mkdir -p $INSTALL_LOCATION/plugins


echo "Set owner to root and prevent regular users from changing/reading in install folder ..."
chown -R root:root $INSTALL_LOCATION
chmod -R 770 $INSTALL_LOCATION


# Create symlink
echo "Linking report script to $LINK_TO ..."
ln -sf /opt/server-report/run.sh $LINK_TO/report


# Exit before marker
echo "Done."
exit 0


__ARCHIVE__
