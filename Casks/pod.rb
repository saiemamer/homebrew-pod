cask "pod" do
  arch arm: "arm64", intel: "x64"

  version "0.1.3"
  sha256 arm:   "0ae0ad4c01ce81b49fb67b652a6bc900c574da019d69de850ab3f67d9bd57198",
         intel: "091457aa4d65800f624da5620f33c7823f558c1b6fc0432569aa2d66920d986c"

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
