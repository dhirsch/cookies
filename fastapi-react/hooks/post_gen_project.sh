#!/bin/bash
while true; do
    read -p "Do you wish to run the install script? [y/n] " yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done