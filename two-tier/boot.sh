#!/bin/bash

function set_hostname()  {
   sudo yum install wget
   local_ip=`wget -q -O - http://169.254.169.254/latest/meta-data/local-ipv4`
   HOSTNAME=thiru_nginx-$local_ip
   hostname $HOSTNAME
   echo "HOSTNAME=$HOSTNAME" > /etc/hostname
   echo "HOSTNAME=$HOSTNAME" >> /etc/sysconfig/network
   hostnamectl set-hostname $HOSTNAME --static
   echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg
}

function install_nginx() {
    sudo yum update
    sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum install -y epel-release
    sudo yum update -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
}

function start_nginx()  {
  sudo service nginx restart
}

function install_kafka {
sudo cd /root
sudo wget https://apachemirror.sg.wuchna.com/kafka/2.5.0/kafka-2.5.0-src.tgz
sudo gunzip kafka-2.5.0-src.tgz
sudo tar -xvf kafka-2.5.0-src.tar
}

set_hostname
install_nginx
start_nginx
install_kafka