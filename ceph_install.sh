# A very minimal ceph install script, using ceph-deploy

#Author Pandiyan maestropandy@gmail.com
set -x

RELEASE=${1:debian-jewel}
# Creating a directory based on timestamp..not unique enough
mkdir -p ~/ceph-deploy/install-$(date +%Y%m%d%H%M%S) && cd $_

#Install ceph key
wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -

#install ceph by pointing release repo to your Ubuntu sources list.
echo deb http://download.ceph.com/debian-jewel/ trusty main | sudo tee /etc/apt/sources.list.d/ceph.list

#Check & remove existing ceph setup
ceph-remove () {
ceph-deploy purge $HOST
ceph-deploy purgedata $HOST
ceph-deploy forgetkeys

#Ready to  update & install ceph-deploy
sudo apt-get update && sudo apt-get install -y ceph-deploy

#Deploy ceph
HOST=$(hostname -s)
FQDN=$(hostname -f)
ceph-remove
ceph-deploy new $HOST

#Add below lines into ceph.conf, pool size for number of replicas of data
#Chooseleaf s required to tell ceph we are only a single node and that it’s OK to store the same copy of data on the same physical node
cat <<EOF >> ceph.conf
osd pool default size=2
osd crush chooseleaf type = 0
EOF


#Time to install ceph
ceph-deploy install $HOST 

#Create Monitor
ceph-deploy mon create-initial 

#Create OSD & OSD with mounted drives /dev/sdb /dev/sdc /dev/sdd
ceph-deploy osd prepare $HOST:sdb $HOST:sdc $HOST:sdd
ceph-deploy osd activate $HOST:/dev/sdb1 $HOST:/dev/sdc1 $HOST:/dev/sdd1

#Restribute config and keys
ceph-deploy admin $HOST

#Read permission to read keyring
sudo chmod +r /etc/ceph/ceph.client.admin.keyring

sleep 30

#Here we go, check ceph health
ceph -s 



