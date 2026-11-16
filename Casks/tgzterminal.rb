cask "tgzterminal" do
  version "2026.11.8"
  sha256 "5ed4ecb9cee576ce22c8e3f91854ac18a88f879ca9054c095f47d518c074d182"

  url "https://github.com/timjensgrossinger/tgzterminal/releases/download/tgz-v#{version}/TGZTerminal.dmg"
  name "TGZTerminal"
  desc "WezTerm-based terminal with a sidebar for coding agents"
  homepage "https://github.com/timjensgrossinger/tgzterminal"

  livecheck do
    url :url
    regex(/^tgz-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on :macos

  app "TGZTerminal.app"
  binary "#{appdir}/TGZTerminal.app/Contents/MacOS/tgzterminal"

  # Releases are not notarized, so drop the quarantine flag Homebrew sets;
  # otherwise Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/TGZTerminal.app"],
        writable_paths: ["TGZTerminal.app"],
        writable_base:  :appdir
  end
end
