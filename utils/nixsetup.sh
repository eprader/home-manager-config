#prerequisites for this script are: curl being installed

#install nix
#sh <(curl -L https://nixos.org/nix/install) --no-daemon && source $HOME/.nix-profile/etc/profile.d/nix.sh

#enable nix flakes
#nix-env -iA nixpkgs.nixFlakes

#install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
#export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install

#remove default files
rm ~/.config/home-manager/home.nix ~/.bashrc ~/.profile

#symlinking home.nix
ln -s ~/home-manager-config/home.nix ~/.config/home-manager/home.nix

# install nixGl for kitty
#$ nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
#$ nix-env -iA nixgl.auto.nixGLDefault 

#switch to home-manager config
home-manager switch
