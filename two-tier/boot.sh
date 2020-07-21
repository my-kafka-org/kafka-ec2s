#!/bin/bash

function set_hostname()  {
   sudo apt-get -y install wget
   local_ip=`wget -q -O - http://169.254.169.254/latest/meta-data/local-ipv4`
   HOSTNAME=thiru_nginx-$local_ip
   hostname $HOSTNAME
   echo "HOSTNAME=$HOSTNAME" > /etc/hostname
   echo "HOSTNAME=$HOSTNAME" >> /etc/sysconfig/network
   hostnamectl set-hostname $HOSTNAME --static
   echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg
}

function install_nginx() {
    sudo apt-get update
    sudo apt-get -y install nginx
}

function start_nginx()  {
  sudo service nginx restart
}

function install_kafka {
sudo cd /
sudo wget https://apachemirror.sg.wuchna.com/kafka/2.5.0/kafka-2.5.0-src.tgz
sudo gunzip kafka-2.5.0-src.tgz
sudo tar -xvf kafka-2.5.0-src.tar
}

set_hostname
install_nginx
start_nginx