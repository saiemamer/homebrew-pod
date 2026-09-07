cask "pod" do
  arch arm: "arm64", intel: "x64"

  version "0.1.5"
  sha256 arm:   "6402316823d5eeef6f4b9eac661d9a0eaf7f90a4c86086671f928317768cfa1f",
         intel: "a31c8c382ad935096fa65df749543b94a230f941a40a34bc94a5037e759f0246"

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
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Pod.app"]
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
