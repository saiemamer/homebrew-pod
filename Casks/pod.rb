cask "pod" do
  arch arm: "arm64", intel: "x64"

  version "0.1.2"
  sha256 arm:   "24f1e328b4f4e72bb48d3569328bad2e4b0d8e220d3fbbdf37602f0dfa2c7d4f",
         intel: "4a0086f006f133211180e79f54423418e3c9be5c6c3a1acedc3e4c2bffcd9f70"

  url "https://github.com/saiemamer/pod/releases/download/v#{version}/pod-macos-#{arch}.dmg",
      verified: "github.com/saiemamer/pod/"
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
  depends_on macos: ">= :monterey"

  app "Pod.app"
  binary "#{appdir}/Pod.app/Contents/Resources/bin/orca"

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
