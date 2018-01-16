# EXECUTE THIS SCRIPT WITH FISH

# Fish extensions
omf install bobthefish
omf install foreign-env

sudo apt-get update

# Install node via NVM
sudo apt-get install build-essential libssl-dev
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh -o install_nvm.sh
bash ./install_nvm.sh
source ~/.profile
nvm install v8.9.4
nvm use v8.9.4
node -v
nvm alias default v8.9.4
nvm use default
rm ./install_nvm.sh

# Fix NVM fish
alias nvm="fenv source ~/.nvm/nvm.sh \; nvm $argv"
funcsave nvm

# Install slap
sudo npm install -g slap@latest


