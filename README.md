# Install Ceph on Single Node

A quick guide for installing Ceph on a single node for demo purposes. It almost goes without saying that this is for tire-kickers who just want to test out the software. Ceph is a powerful distributed storage platform with a focus on spreading the failure domain across disks, servers, racks, pods, and datacenters. It doesn’t get a chance to shine if limited to a single node. With that said, let’s get on with it.

# Prerequistes 

Create VM with Ubuntu 14.04 OS, Add 3 OSD with decent size say 25 GB each

# Linux Install

Here we are going to install ceph on single node Ubuntu 14.04 with One Mon & Three OSD's, Clone this repository to host and open directory "Ceph_Singlenode" and run shell script as per below order

setup.sh   ---->> it will create ceph user and password less access and login to ceph user
Install.sh ---->> Install ceph with 3 OSD's

Here we go, Enjoy !!

   

#Reference

http://docs.ceph.com/docs/master/start/
