cask "pod" do
  arch arm: "arm64", intel: "x64"

  version "0.1.15"
  sha256 arm:   "71190661a20801352e13b57bc62d3552582111a103d66b862a7bc589c4a86d33",
         intel: "dd428eed5eb673e4780c143188eb7bd63984467c937d0dbc21c958a880fbcc49"

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
