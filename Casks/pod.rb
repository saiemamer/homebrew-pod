cask "pod" do
  arch arm: "arm64", intel: "x64"

  version "0.1.14"
  sha256 arm:   "ae45aea0d86a52ca21f9cba42f75aa6a236f93ba72a22dd37a3eebda0e9c3610",
         intel: "b01c49e7fb8cf599deb2efd43fa5f5da721a51d978e4b98a798134dd4dee6731"

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
  depends_on macos: :monterey

  app "Pod.app"
  # Why target "pod": stock Orca owns the orca command. Inside a terminal that Pod
  # opens, orca still runs Pod's own CLI.
  binary "#{appdir}/Pod.app/Contents/Resources/bin/orca", target: "pod"

  # Why: the build is unsigned, so Gatekeeper would refuse the downloaded app
  # ("the developer cannot be verified"). Clearing quarantine here means
  # brew install and brew upgrade leave an app that opens on double-click.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Pod.app"]
  end

  zap trash: [
    "~/Library/Application Support/Pod",
    "~/Library/Caches/io.github.saiemamer.pod",
    "~/Library/Caches/io.github.saiemamer.pod.ShipIt",
    "~/Library/HTTPStorages/io.github.saiemamer.pod",
    "~/Library/Preferences/io.github.saiemamer.pod.plist",
    "~/Library/Saved Application State/io.github.saiemamer.pod.savedState",
  ]
end
