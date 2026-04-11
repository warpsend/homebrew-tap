class Warpsend < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "449c08c61dac96d8aa615119f002bde2ba355ae3333963fe46852e0805adfbf8"
    end

    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-apple-darwin.tar.gz"
      sha256 "cafd2661fdc529278a7eb1affef848edf86b579522574dbd7e699ac1971a0248"
    end
  end

  on_linux do
    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-unknown-linux-musl.tar.gz"
      sha256 "230d1a5f4c54c20ede4de8ffa4241b60d062651e4e7afa6250c45f3088981a2d"
    end
  end

  def install
    bin.install "warpsend"
  end

  test do
    assert_match "warpsend", shell_output("#{bin}/warpsend --version")
  end
end
