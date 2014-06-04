#!/bin/sh

set -e

VAGRANT_PROVISION_LOCK=/var/vagrant_provision
BASEDIR=/repos/CentOS
OSVERSION=$(awk '{print $3}' /etc/centos-release)
REPODIR=$BASEDIR/$OSVERSION
ISO_FILENAME=CentOS-${OSVERSION}-x86_64-bin-DVD1.iso
ISO_URL=http://mirror.thelinuxfix.com/CentOS/$OSVERSION/isos/x86_64/$ISO_FILENAME

# Prereqs
yum install -y httpd rsync createrepo parted

if [ -f $VAGRANT_PROVISION_LOCK ];then
	echo Already provisioned. To repeat provisioning, remove $VAGRANT_PROVISION_LOCK >&2
	exit 0
fi

# Disk setup, if available
if [ ! -d /repos ];then
	mkdir /repos
fi

if [ -d /sys/block/sdb ];then
	parted -s /dev/sdb mklabel msdos
	parted -s /dev/sdb mkpart primary ext4 0 100%
	parted -s /dev/sdb set 1 lvm on
	pvcreate /dev/sdb1
	vgcreate repos /dev/sdb1
	lvcreate --name centos -L 5G repos
	mkfs.ext4 /dev/mapper/repos-centos
	mkdir $BASEDIR	
	mount -t /dev/mapper/repos-centos $BASEDIR
fi

mkdir -p $BASEDIR
if [ ! -d /mnt/cdrom ];then
	mkdir /mnt/cdrom
fi

# Get ISO
if [ -f /vagrant_data/$ISO_FILENAME ];then
	# Already exists
	echo Mounting existing ISO
	mount -o loop /vagrant_data/$ISO_FILENAME /mnt/cdrom	
else
	# Download ISO
	echo ISO does not exist. Downloading.
	wget $ISO_URL
	mount -o loop $ISO_FILENAME /mnt/cdrom
fi

# Setup Repo
cp -R -v /mnt/cdrom/Packages $REPODIR
createrepo $REPODIR
umount /mnt/cdrom
if [ -f $ISO_FILENAME ];then
	rm $ISO_FILENAME
fi

cat <<EOF >$BASEDIR/yummirror.repo
[yummirror]
name = Custom CentOS Mirror made using Vagrant
baseurl = http://yumrepo/$REPODIR/\$releasever
EOF

# Setup apache
cat <<EOF >/etc/httpd/conf.d/00-yum.conf
Alias /repos /repos
<Directory /repos>
Options Indexes FollowSymLinks
Order allow,deny
Allow from all
</Directory>
EOF

service httpd start

# Tag
echo This is a CentOS Repo Mirror created on $(date) > /etc/motd

touch $VAGRANT_PROVISION_LOCK
