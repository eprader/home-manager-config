#!/usr/bin/env bash

output=$(sudo nix-env -p /nix/var/nix/profiles/system --list-generations)

generation_ids=$(echo "$output" | awk '{print $1}' | grep -E '^[0-9]+$')

all_but_last_two_generations=$(echo "$generation_ids" | sort -n | head -n -2 | tr '\n' ' ')

# INFO:
# Will result in a no-op if `all_but_last_three_generations` is empty.
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations $all_but_last_two_generations

nix-store --gc

# NOTE: For a large nix store this takes a while.
# echo "Size of /nix/store: $(du -sh /nix | awk '{print $1}')"

echo "Attempting to clean up docker."
docker system prune -a --volumes

