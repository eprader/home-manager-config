#!/usr/bin/env bash

output=$(sudo nix-env -p /nix/var/nix/profiles/system --list-generations)

generation_ids=$(echo "$output" | awk '{print $1}' | grep -E '^[0-9]+$')

all_but_last_three_generations=$(echo "$generation_ids" | sort -n | head -n -3 | tr '\n' ' ')

# INFO:
# Will result in a no-op if `all_but_last_three_generations` is empty.
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations $all_but_last_three_generations

nix-store --gc

echo "Size of /nix/store: $(du -sh /nix | awk '{print $1}')"

sudo nixos-rebuild switch
