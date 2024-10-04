# Satori auto installer script

This script will auto install satori neuron into your machine

## ⚠️ WARNING ⚠️

If you install Satori on a VPS, you must set up authentification with an SSH key

You can also run this script to auto-configure the config file of ssh after setting up an ssh key :
`wget -O - https://raw.githubusercontent.com/lamat1111/password-connection-disabler/master/configure_ssh.sh | bash`

All credit for this script goes to [LaMaT1111](https://github.com/lamat1111/password-connection-disabler)

## Run the script :

To run the script, simply paste this command : `TODO`

This will do the following :

- Install vnstat, make, htop and fail2ban packages
- Activate and enable fail2ban
- Install Docker
- Download Satori directory
- Modify the `satori.py` file and set the port container from `24601:24601` to `127.0.0.1:24601:24601`
- Setup the node and service
- Start the node directly


**It's very important to set the port connection on Docker, otherwise, anybody who has your VPS's IP address and your port can access through the Satori Dashboard and steal your Satori**
