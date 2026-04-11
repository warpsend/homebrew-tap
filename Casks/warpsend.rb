cask "warpsend" do
  version "0.1.2"

  on_arm do
    url "https://app.warpsend.io/_agent/desktop/WarpSend-#{version}-macos-aarch64.dmg"
    sha256 "4264d0d648d906f3e485de192b28ef22016aeac0423356a2c3a7444526c2277b"
  end

  on_intel do
    url "https://app.warpsend.io/_agent/desktop/WarpSend-#{version}-macos-x86_64.dmg"
    sha256 "fef74ab281fe745cbaed5cb87b428b7c49f093840efc0af4484c28de036d9f41"
  end

  name "WarpSend"
  desc "Fast, encrypted NAS-to-NAS file transfer — Desktop app"
  homepage "https://warpsend.io"

  # The Desktop app is a thin shell that spawns `warpsend run` (the CLI
  # supervisor) and opens its web UI in a native window. It cannot run
  # without the CLI — depending on the formula guarantees both are installed
  # together with a single `brew install --cask` command.
  depends_on formula: "warpsend/tap/warpsend"

  app "WarpSend.app"

  zap trash: [
    "~/.config/warpsend",
    "~/Library/Application Support/io.warpsend.desktop",
    "~/Library/Caches/io.warpsend.desktop",
    "~/Library/Preferences/io.warpsend.desktop.plist",
    "~/Library/Saved Application State/io.warpsend.desktop.savedState",
  ]
end
