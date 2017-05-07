#!/bin/bash
sudo chown -R root:root package/
dpkg-deb --build package/
sudo chown -R landrash:landrash package/

