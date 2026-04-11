class Warpsend < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "10440e2b319bf294e17a4cefc5f8964c22218b93a4c94fbdff7c581414014af3"
    end

    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-apple-darwin.tar.gz"
      sha256 "034f41ec82f6c94e9a9206dde43084bd15b6b6813cf8f9433611f489a8891ffd"
    end
  end

  on_linux do
    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c09e394d395c0488c85f403c9e82cab472ca2e6d3fe5dfe9c6a29d10db26fc3b"
    end
  end

  def install
    bin.install "warpsend"
  end

  test do
    assert_match "warpsend", shell_output("#{bin}/warpsend --version")
  end
end
