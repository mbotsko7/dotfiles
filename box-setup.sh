# EXECUTE THIS SCRIPT WITH FISH

# Fish extensions
omf install bobthefish
omf install foreign-env

# Install node 8 via PPA
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
rm nodesource_setup.sh

sudo apt-get install nodejs build-essential

# Install slap
sudo npm install -g slap@latest


