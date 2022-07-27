#prerequisites
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install curl
#installing nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon && . /home/emanuel/.nix-profile/etc/profile.d/nix.sh

#enable nix flakes
#nix-env -iA nixpkgs.nixFlakes

#installing home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault  
