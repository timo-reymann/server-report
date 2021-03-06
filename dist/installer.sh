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

echo "Starting ServerReport installer ..."


echo "Creating install location at $INSTALL_LOCATION ..."
mkdir -p $INSTALL_LOCATION


# Find __ARCHIVE__ maker, read archive content and decompress it
ARCHIVE=$(awk '/^__ARCHIVE__/ {print NR + 1; exit 0; }' "${0}")
tail -n+${ARCHIVE} "${0}" | tar xpJ -C ${INSTALL_LOCATION}


echo "Creating plugins folder, if not already present ..."
mkdir -p $INSTALL_LOCATION/plugins


echo "Set owner to root and prevent regular users from changing/reading in install folder ..."
chown -R root:root $INSTALL_LOCATION
chmod -R 770 $INSTALL_LOCATION


# Create symlink
echo "Linking report script to $LINK_TO ..."
ln -sf /opt/server-report/run.sh $LINK_TO/report


# Exit before marker
echo -e "\nDone."
exit 0


__ARCHIVE__
�7zXZ  �ִF !   t/��'��] 9I���I�G����")�N�B�� WV�v�p�S.�&���`1��@)�M�9�o{<q�}�Kw�`[�\�$�"Y�	$2N��x��,��8�ײ�&>FU��/R���+_1���W,�ތH�rS�]�k����`�@k��g%F#�v�H�^�M���am�(;Ѹ��S)��R�֨�3# ӥ�i��Mx�)@E�I�~���ѩ�}�v��Q�ud.	q=(|PA��M��r0K� Q�׾�X�~�bNa9������6!7L�ڦ��X���Z�Ϊ�����A:�&�*� q�r��79::KR��}��&�o}�Ӫ�mhei��F�Q���l}�;Z;Z$D+�O@�Q����-�d(�FR@�P���J�<����Gou�6݌�f�i�F��d*�WUN�{Ÿj_a�4'�H�U0���`$c�0�);� H0"�p!�@�3'��d�;}N^
��$gH�;s����6�)�
��鳉��q#�/"U���q �xx�J��{Q�]�F�ئ�Fa�Ƌf�]C��O�q����x,#b���el3t�e�W��a�N�5ƸyA�Xq�/����0.&)#��Q� k�s5(o����CR����:@v�xy.�-��Ɖ��-�)5�d�p�ל��������^�T�����P���B�L2�WN��)Om��&��k=J��H*j*�3�lyɅ�;��%X�4ZX	��}���y�4"j}��M��-ii�"Y���Ӵ@��(��h�K(�2�W5��tగߟ���W�/���y�]�a�d���oR�(���N�����c��,:�����Mۖ`�7w��Q'х�;:����TKN�Vw���ݘ�1�8@XP�*�7"��]eW[s��A�%���7~�-Ӈ�-��l��IP���)ʨ��b����&Л�ڏ�D�T���A<�{�.jR ���{��9uT���Ub�W����[Ȥy�]�9�8�<�1��h;���M��	�Z��ךaJU����3m�h�c�-J�G>�S<-���[A����k�Y?�t̸�d`��-1����w�RҜ�B6�ݕ��	-�k��u�=�d�����?�DXϖ������>�ø<xQS�u�V�\(�>K��������f%��D)v�U�.�MX�w(�$&
�.�.�L���d�KdJp��/�ܰ�I(�K.~�����Ej�x�&��v�'aq�]@�=��㜹�����rv�0�{P��I.�򞼧��wK���<.T3�gt�3�v�o�z�}���>��� )ٓߜfL�u���Hh"Nf�|{��;�I,~��ι(�vmF�H�|�?�T�_�Z_�<�Pp��/�"ck9$��'�8!��+ S *D-'�P��z�鳛�pY�2W�`�h� k}I�*��#n�6��\�5�>    +�$�#�Di ��P  �O獱�g�    YZ