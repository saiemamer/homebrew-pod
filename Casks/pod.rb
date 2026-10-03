cask "pod" do
  arch arm: "arm64", intel: "x64"

  version "0.1.11"
  sha256 arm:   "1fbf03ce053380f0a2afec38842256e1ef11f653418d8cc6eb6440d7380187fe",
         intel: "8135419694f9a07b2533064165f4c164dca8441b68aaebaf95385b4f34b3592a"

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
