# Setup Environment

# Author Pandiyan maestropandy@gmail.com

set -x

#want a dedicated user to handle ceph configs and installs so lets create that user now
sudo useradd -m -s /bin/bash ceph-deploy
sudo passwd ceph-deploy

#user needs passwordless sudo configured.
echo "ceph-deploy ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ceph-deploy

#Verify permissions are correct on this file
sudo chmod 0440 /etc/sudoers.d/ceph-deploy

#switch to new user
sudo su - ceph-deploy

#ceph-deploy utility functions by ssh’ing to other nodes and executing commands. 
#To accomplish this we need to create an RSA key pair to allow passwordless logins to the nodes
ssh-keygen


#install the generated public key on our destination nodes
ssh-copy-id ceph-deploy@hostname
