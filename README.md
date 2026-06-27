# Cleanup The Nix Store


After the initial clone use 
```bash
git remote set-url origin git@github.com:eprader/home-manager-config.git
```

> [!WARNING]
> Removes all but the last generation!

sudo nix-collect-garbage -d

nix-collect-garbage -d

TODO: look into bloat / cache cleanup tools e.g. null-e or rasa.
