# Homebrew tap for Pod

[Pod](https://github.com/saiemamer/pod) is the analytics-engineering fork of Orca.

```sh
brew install --cask saiemamer/pod/pod   # installs Pod.app and the orca CLI
brew upgrade --cask pod                 # updates to the latest Pod release
```

Pod is not code-signed yet; the cask clears macOS's quarantine attribute after install and upgrade so the app opens normally. Pod shows new releases inside the app with a button that runs the upgrade in Terminal, and macOS only lets a signed app replace itself, so brew is the update path. To upgrade automatically, install [homebrew-autoupdate](https://github.com/DomT4/homebrew-autoupdate) and run `brew autoupdate start --upgrade`.

The cask follows Pod's releases: a workflow in this repo checks the latest release every 30 minutes and updates the version and checksums.
