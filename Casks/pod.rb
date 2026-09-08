cask "pod" do
  arch arm: "arm64", intel: "x64"

  version "0.1.9"
  sha256 arm:   "ca9c0130381a2bfa4cdf15f2188793d7f5f58f81b910976b7fdcdf1fc1fee4d1",
         intel: "a61fbf921b493ffb9a8d9c4091fdf5db55f99072902d7cf1539a6b9135c748fb"

  url "https://github.com/saiemamer/pod/releases/download/v#{version}/pod-macos-#{arch}.dmg"
  name "Pod"
  desc "Analytics-engineering IDE (dbt, Omni, cross-repo agent initiatives) forked from Orca"
  homepage "https://github.com/saiemamer/pod"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Why no auto_updates: Pod builds are unsigned, and macOS only lets a signed app
  # replace itself, so brew upgrade is the update path.
  conflicts_with cask: ["orca", "orca@rc"]
  depends_on macos: :monterey

  app "Pod.app"
  binary "#{appdir}/Pod.app/Contents/Resources/bin/orca"

  # Why: the build is unsigned, so Gatekeeper would refuse the downloaded app
  # ("the developer cannot be verified"). Clearing quarantine here means
  # brew install and brew upgrade leave an app that opens on double-click.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Pod.app"]
  end

  zap trash: [
    "~/.orca",
    "~/Library/Application Support/orca",
    "~/Library/Caches/io.github.saiemamer.pod",
    "~/Library/Caches/io.github.saiemamer.pod.ShipIt",
    "~/Library/HTTPStorages/io.github.saiemamer.pod",
    "~/Library/Preferences/io.github.saiemamer.pod.plist",
    "~/Library/Saved Application State/io.github.saiemamer.pod.savedState",
  ]
end
