# Homebrew tap for Pod

[Pod](https://github.com/saiemamer/pod) is the analytics-engineering fork of Orca.

```sh
brew install --cask saiemamer/pod/pod   # installs Pod.app and the orca CLI
brew upgrade --cask pod                 # updates to the latest Pod release
```

Pod is not code-signed yet, so on first launch right-click Pod in Applications and choose Open. Pod shows new releases inside the app, but macOS only lets a signed app replace itself, so `brew upgrade --cask pod` is the update path. To upgrade automatically, install [homebrew-autoupdate](https://github.com/DomT4/homebrew-autoupdate) and run `brew autoupdate start --upgrade`.

The cask follows Pod's releases: a workflow in this repo checks the latest release every 30 minutes and updates the version and checksums.
