# Cleanup The Nix Store


After the initial clone use 
```bash
git remote set-url origin git@github.com:eprader/home-manager-config.git
```

> [!WARNING]
> Removes all but the last generation!

sudo nix-collect-garbage -d
sudo nix-store --optimise

nix-collect-garbage -d

TODO: look into bloat / cache cleanup tools e.g. null-e or rasa.


## Docker

```bash
docker system prune -af
```

# Updating

## NixOS
Updating nixos requires to change the nixos channel to a later `x.x` release.
```bash
sudo nix-channel --add https://nixos.org/channels/nixos-x.x nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable
sudo nix-channel --update
nrs --upgrade
```

## Home Manager
Updating home-manager requires to change the channel to a later `x.x` release.
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-x.x.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable unstable
nix-channel --update
hms
```
