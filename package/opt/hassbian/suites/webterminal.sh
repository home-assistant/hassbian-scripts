#!/bin/bash
function webterminal-show-short-info {
    echo "Installs an websevice terminal."
}

function webterminal-show-long-info {
    echo "Installs an websevice terminal to controll your installation."
}

function webterminal-show-copyright-info {
	echo "Original consept by Ludeeus <https://github.com/ludeeus>"
}

function webterminal-install-package {
echo "Installing packages."
sudo apt-get install -y openssl shellinabox

echo "Changing config."
sudo sed -i 's/--no-beep/--no-beep --disable-ssl/g' /etc/default/shellinabox

echo "Reloading and starting the service."
sudo service shellinabox reload
sudo service shellinabox restart

ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

echo
echo "Installation done."
echo
echo "You can now access the web terminal here: http://$ip_address:4200"
echo "You can also add this to your Home-Assistant config in an 'panel_iframe'"
echo
echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
