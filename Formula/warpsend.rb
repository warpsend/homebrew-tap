class Warpsend < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "e3cdabadf93d6509c374ca97ff5e0cfa7f31b6621470265c8f2e749812861dcb"
    end

    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-apple-darwin.tar.gz"
      sha256 "70f0e5c84637a2fb191c5337dd9dda51b59879e8ab74e30ae30e97a1ef2321db"
    end
  end

  on_linux do
    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b57ad161c743401b8af1ca7bcc5c7a4969b3685367997ae0923a07e78cc1a8a1"
    end
  end

  def install
    bin.install "warpsend"
  end

  test do
    assert_match "warpsend", shell_output("#{bin}/warpsend --version")
  end
end
