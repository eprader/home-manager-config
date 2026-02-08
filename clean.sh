#!/usr/bin/env bash

output=$(nix-env --list-generations)

generation_ids=$(echo "$output" | awk '{print $1}' | grep -E '^[0-9]+$')

all_but_last_three_generations=$(echo "$generation_ids" | sort -n | head -n -2 | tr '\n' ' ')

# INFO:
# Will result in a no-op if `all_but_last_three_generations` is empty.
nix-env --delete-generations $all_but_last_three_generations

nix-store --gc

echo "Size of /nix/store: $(du -sh /nix | awk '{print $1}')"
