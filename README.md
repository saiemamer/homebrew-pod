# Homebrew tap for Pod

[Pod](https://github.com/saiemamer/pod) is the analytics-engineering fork of Orca.

```sh
brew install --cask saiemamer/pod/pod              # installs Pod.app and the orca CLI
xattr -dr com.apple.quarantine /Applications/Pod.app   # unsigned build: let macOS open it
brew upgrade --cask pod                            # updates to the latest Pod release (then the xattr line again)
```

Pod is not code-signed yet, so macOS refuses to open a fresh download ("the developer cannot be verified") until the quarantine attribute is removed with the `xattr` line above, or by right-clicking Pod in Applications and choosing Open once. Pod shows new releases inside the app, but macOS only lets a signed app replace itself, so `brew upgrade` is the update path. To upgrade automatically, install [homebrew-autoupdate](https://github.com/DomT4/homebrew-autoupdate) and run `brew autoupdate start --upgrade`.

The cask follows Pod's releases: a workflow in this repo checks the latest release every 30 minutes and updates the version and checksums.
