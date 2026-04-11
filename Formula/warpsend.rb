class Warpsend < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "81d203d021ba620777351b83c5d68958dfca64818cebe610ad44023713a8b087"
    end

    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-apple-darwin.tar.gz"
      sha256 "767913e04b610c19f60e882ddb353b9218d068cc7133340fe1f429a0d6d9ae11"
    end
  end

  on_linux do
    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-unknown-linux-musl.tar.gz"
      sha256 "29521c46b763d0215c417db90a6f409953aa8d7110ee56f486234ef0e4b08251"
    end
  end

  def install
    bin.install "warpsend"
  end

  test do
    assert_match "warpsend", shell_output("#{bin}/warpsend --version")
  end
end
