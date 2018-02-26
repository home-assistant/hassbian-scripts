#!/bin/bash

function webmin-show-short-info {
  echo "Webmin install script for Hassbian"


function webmin-show-long-info {
  echo "Installs the Webmin web-based administration interface on Hassbian."
}

function webmin-show-copyright-info {
  echo "Copyright(c) 2018 Antoni K <https://github.com/Antoni-K>."
}

function webmin-show-repo-message {
  if [ "$INSTALL_MODE" == "install" ]; then
    echo "Repository found, proceeding with installation"
  else
    echo "Repository found, proceeding with update"
  fi
}

function webmin-check-repo {
  SOURCES_LIST=$(cat /etc/apt/sources.list)
  echo "Checking if Webmin repo entry exists"
  if grep -q 'deb https://download.webmin.com/download/repository sarge contrib' <<< $SOURCES_LIST; then
    webmin-show-repo-message
  else
    echo "Webmin repository not found, adding it now"
    sed -i '$a deb https://download.webmin.com/download/repository sarge contrib' /etc/apt/sources.list
  fi
  unset SOURCES_LIST
  unset INSTALL_MODE
}

function webmin-check-keys {
  echo "Checking for GnuPG"
  if type "gnupg" &> /dev/null; then
    echo "GnuPG found, proceeding"
  else
    echo "GnuPG (an apt-key requirement) not found, installing"
    apt-get update
    apt-get install gnupg
  fi
  echo "Creating directory for the Webmin repo key"
  cd /etc
  mkdir webmin_keys
  cd webmin_keys
  echo "Downloading Webmin repo key"
  wget "http://www.webmin.com/jcameron-key.asc"
  echo "Adding key with apt-key"
  apt-key add jcameron-key.asc
  if [ $? -eq 0 ]; then
    echo "Repo key added successfully"
  fi
}

function get-local-ip {
  LOCAL_IP=$(hostname -I)
}

function webmin-install-package {
  WEBMIN_REPO="deb https://download.webmin.com/download/repository sarge contrib"

  # Set install mode
  INSTALL_MODE="install"
  webmin-show-short-info
  webmin-show-copyright-info

  # Check if repo is installed and install apt-transport-https support program
  webmin-check-repo
  echo "Installing required apt-get HTTPS support program"
  apt-get install apt-transport-https -y

  # Updating apt
  echo "Updating apt-get"
  apt-get update

  # Installing actual Webmin packages
  echo "Installing Webmin packages"
  apt-get install webmin -y
  if ! [ $? -eq 0 ]; then
    echo "Installation failed - Attempting fix"
    rm /var/lib/dpkg/info/apt-show*
    apt-get -f install apt-show-versions -y
    apt-get install webmin -y
    if ! [ $? -eq 0 ]; then
      echo "Fix successfully applied"
    fi
  fi

  # Get local IP address for this machine
  get-local-ip

  # End
  echo
  echo "Installation done."
  echo
  echo "You can now access the Webmin control panel at http://$IP:10000"
  echo
  echo "For more information and tutorials, visit http://www.webmin.com/docs.html"
  echo
  echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 0
}

function webmin-upgrade-package {
  # Set install mode
  INSTALL_MODE="update"
  # Show info
  webmin-show-short-info
  webmin-show-copyright-info
  webmin-check-repo

  echo "Updating apt-get"
  apt-get update

  echo "Checking for Webmin updates"
  apt-get upgrade webmin -y
  return 0
}
