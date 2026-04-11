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

  app "WarpSend.app"

  # Brew Cask auto-strips the quarantine flag, bypassing Gatekeeper warnings.
  zap trash: [
    "~/.config/warpsend",
    "~/Library/Application Support/io.warpsend.desktop",
    "~/Library/Caches/io.warpsend.desktop",
    "~/Library/Preferences/io.warpsend.desktop.plist",
    "~/Library/Saved Application State/io.warpsend.desktop.savedState",
  ]
end
