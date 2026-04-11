class Warpsend < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "7258ede2f85cfc6bf6a622c3e07a6a23c2f63d700def1fb1fe19330953fcaee3"
    end

    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-apple-darwin.tar.gz"
      sha256 "119f380a685eb6b5c2b5ef96eda3d5dd0dae60ce5e27215e992c86616c5a0264"
    end
  end

  on_linux do
    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ee7e914209d7596a3cf24f45655bdcafab9b8e048af93687014153aa51664ab4"
    end
  end

  def install
    bin.install "warpsend"
  end

  test do
    assert_match "warpsend", shell_output("#{bin}/warpsend --version")
  end
end
