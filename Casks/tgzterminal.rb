cask "tgzterminal" do
  version "2026.11.6"
  sha256 "686734c52ea127f0143caf040225c475496cbe2650fd05e762f32c534182a973"

  url "https://github.com/timjensgrossinger/tgzterminal/releases/download/tgz-v#{version}/TGZTerminal.dmg"
  name "TGZTerminal"
  desc "WezTerm-based terminal with a sidebar for coding agents"
  homepage "https://github.com/timjensgrossinger/tgzterminal"

  livecheck do
    url :url
    regex(/^tgz-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  # The app has its own updater (tgz-v* releases).
  auto_updates true

  app "TGZTerminal.app"
  binary "#{appdir}/TGZTerminal.app/Contents/MacOS/tgzterminal"

  # Releases are not notarized, so drop the quarantine flag Homebrew sets;
  # otherwise Gatekeeper blocks the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TGZTerminal.app"]
  end
end
