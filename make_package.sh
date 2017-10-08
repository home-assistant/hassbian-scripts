#!/bin/bash
sudo chown -R root:root package/
dpkg-deb --build package/
sudo chown -R landrash:landrash package/
scp package.deb pi@hassbian.local:~/
ssh pi@hassbian.local "dpkg -i package.deb && rm package.deb"
