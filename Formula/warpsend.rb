class Warpsend < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "d89924b84361b984cdb62d7c2266eef141c6f1e0de075b72887fe46f081cb19b"
    end

    on_intel do
      odie "WarpSend does not support Intel macOS. Apple Silicon (M1/M2/M3/M4) only."
    end
  end

  on_linux do
    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4e4ba666b0ed98132a707e2f5a0f2c17cb6bb1c9af7e3195e6c3855c5de84abb"
    end
  end

  def install
    bin.install "warpsend"
  end

  test do
    assert_match "warpsend", shell_output("#{bin}/warpsend --version")
  end
end
