#!/bin/bash

function webmin-show-short-info {
  if [[ $INSTALL_MODE = "update" ]]; then
    echo "Webmin update script for Hassbian"
  else
    echo "Webmin install script for Hassbian"
  fi
}

function webmin-show-long-info {
  # I have no idea if this is needed or not but I'm so damn tired right now...
  if [[ $INSTALL_MODE = "update" ]]; then
    echo "Updates the Webmin web-based administration interface on Hassbian."
  else
    echo "Installs the Webmin web-based administration interface on Hassbian."
  fi
}

function webmin-show-copyright-info {
  echo "Copyright(c) 2018 Antoni K <https://github.com/Antoni-K>."
}

function webmin-fix-deps {
  echo "Checking for missing dependencies"
  if ! apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python -y; then
    echo "Dependency installation failed - this might be a known problem. Applying fix..."
    rm /var/lib/dpkg/info/apt-show*
    apt-get -f install apt-show-versions -y
    if apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python -y; then
      echo "Fix successfully applied"
    else
      echo "Applying fix failed"
      if [[ ! $ACCEPT = true ]]; then
        read -p "Do you want to continue (y/N):" -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          echo "Proceeding..."
        else
          return 1
        fi
      else
        echo "Aborting"
        return 1
      fi
    fi
  fi
  return 0
}

function webmin-make-temp-dir {
  pwd=$(pwd)
  if [ ! -d "/tmp/webmin_download" ]; then
    echo "Temp directory doesn't exist; creating"
    cd /tmp || return 1
    mkdir webmin_download || return 1
    cd webmin_download || return 1
    echo "Done"
  fi
  cd /tmp/webmin_download || return 1
  if ! rm -f ./* ; then
    echo "Cleaning /tmp/webmin_download failed"
  fi
  cd || return 1
  cd "$pwd" || return 1
  return 0
}

function webmin-download-bundle {
  WEBMIN_URL_LATEST="http://www.webmin.com/download/deb/webmin-current.deb"
  echo "Downloading .deb package"
  webmin-make-temp-dir || return 1
  cd /tmp/webmin_download || return 1
  wget --content-disposition "$WEBMIN_URL_LATEST" || echo "Download failed" && return 1
  echo "Download successful"
  return 0
}

function webmin-install-bundle {
  cd /tmp/webmin_download || return 1
  PACKAGE_NAME=$(ls)
  echo "Installing Webmin package"
  if ! dpkg --install "$PACKAGE_NAME" ; then
    echo "Package installation failed to due to missing dependencies"
    echo "Installing dependencies"
    if ! webmin-fix-deps ; dpkg --install "$PACKAGE_NAME" ; then
      echo "Installation failed; aborting"
      return 1
    fi
  fi
  return 0
}

function webmin-install-package {
  INSTALL_MODE="install"
  # WEBMIN_REPO="deb https://download.webmin.com/download/repository sarge contrib"
  # Set install mode
  webmin-show-short-info
  webmin-show-copyright-info
  webmin-download-bundle
  webmin-install-bundle

  # Get local IP address for this machine
  ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

  # End
  echo
  echo "Installation done."
  echo
  echo "You can now access the Webmin control panel at https://$ip_address:10000"
  echo
  echo "Do remember than any user with sudo access can log in by default."
  echo
  echo "For more information and tutorials, visit http://www.webmin.com/docs.html"
  echo
  echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  unset pwd
  return 0
}

function webmin-upgrade-package {
  # Set install mode
  INSTALL_MODE="update"
  # Show info
  webmin-show-short-info
  webmin-show-copyright-info
  webmin-fix-deps
  echo "Checking for Webmin updates"
  webmin-download-bundle
  webmin-install-bundle
  unset pwd
  return 0
}
