#!/bin/bash
# Secure Wordpress For CentOS, Debian, Ubuntu, Raspbian, Arch, Fedora, Redhat
# https://github.com/LiveChief/wordpress-install

## Sanity Checks and automagic
function root-check() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "Hello there non ROOT user, you need to run this as ROOT."
    exit
  fi
}

 ## Root Check
root-check

## Detect OS
function dist-check() {
  if [ -e /etc/centos-release ]; then
    DISTRO="CentOS"
  elif [ -e /etc/debian_version ]; then
    DISTRO=$( lsb_release -is )
  elif [ -e /etc/arch-release ]; then
    DISTRO="Arch"
  elif [ -e /etc/fedora-release ]; then
    DISTRO="Fedora"
  elif [ -e /etc/redhat-release ]; then
    DISTRO="Redhat"
  else
    echo "Your distribution is not supported (yet)."
    exit
  fi
}

## Check distro
dist-check

function install-essentials() {
  ## Installation begins here.
if [ "$DISTRO" == "Ubuntu" ]; then
    apt-get install apache2 mysql-server mysql-server php7.0 php7.0-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip libapache2-mod-php7.0 php7.0-mcrypt -y
  elif [ "$DISTRO" == "Debian" ]; then
    apt-get install apache2 mysql-server mysql-server php7.0 php7.0-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip libapache2-mod-php7.0 php7.0-mcrypt -y
  elif [ "$DISTRO" == "Raspbian" ]; then
    apt-get install apache2 mysql-server mysql-server php7.0 php7.0-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip libapache2-mod-php7.0 php7.0-mcrypt -y
  elif [ "$DISTRO" == "Arch" ]; then
    ## Later
  elif [ "$DISTRO" = 'Fedora' ]; then
    ## Later
  elif [ "$DISTRO" == "CentOS" ]; then
    ## Later
  elif [ "$DISTRO" == "Redhat" ]; then
    ## Later
fi
}

## Running Install Essentials
install-essentials

function install-wordpress() {
    ## Install Wordpress
    if [ "$DISTRO" == "Ubuntu" ]; then
    cd /var/www/html/
    rm index.html
    wget https://wordpress.org/latest.tar.gz
    tar -xvzf latest.tar.gz
    rm latest.tar.gz
    mv wordpress/* .
  elif [ "$DISTRO" == "Debian" ]; then
    cd /var/www/html/
    rm index.html
    wget https://wordpress.org/latest.tar.gz
    tar -xvzf latest.tar.gz
    rm latest.tar.gz
    mv wordpress/* .
  elif [ "$DISTRO" == "Raspbian" ]; then
    cd /var/www/html/
    rm index.html
    wget https://wordpress.org/latest.tar.gz
    tar -xvzf latest.tar.gz
    rm latest.tar.gz
    mv wordpress/* .
  elif [ "$DISTRO" == "Arch" ]; then
    ## Later
  elif [ "$DISTRO" = 'Fedora' ]; then
    ## Later
  elif [ "$DISTRO" == "CentOS" ]; then
    ## Later
  elif [ "$DISTRO" == "Redhat" ]; then
    ## Later
fi
}
  RANDOM_PASSWORD="$(date +%s | sha256sum | base64 | head -c 32)

  ## MySQL Setup
  mysql -u root -p
  CREATE DATABASE wordpress_db;
  GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'localhost' IDENTIFIED BY '$RANDOM_PASSWORD';
  FLUSH PRIVILEGES;
  exit;

  ## Install Begins Here
  cd /var/www/html/
  rm index.html
  wget https://wordpress.org/latest.tar.gz
  tar -xvzf latest.tar.gz
  rm latest.tar.gz
  mv wordpress/* .

  ## Give Correct Permissions
  chown -R www-data:www-data /var/www/html
  
## System Commands
if pgrep systemd-journal; then
  ### Apache2
  systemctl enable apache2
  systemctl start apache2
  systemctl restart apache2
  ### MySQL
  systemctl enable mysql
  systemctl start mysql
  systemctl restart mysql
  ## Enable mod rewrite
  sudo a2enmod rewrite
else
   service mysq restart
   service apache2 restart
   sudo a2enmod rewrite
fi
