class Bclm < Formula
  desc "macOS command-line utility to limit max battery charge"
  homepage "https://github.com/zackelia/bclm"
  url "https://github.com/zackelia/bclm/archive/v0.0.2.tar.gz"
  sha256 "47a4587ae329b5ce0f07a47e341d41501f1c35f2b38346d5b07e1b486955959f"
  license "https://github.com/zackelia/bclm/blob/master/LICENSE"
  head "https://github.com/zackelia/bclm"

  depends_on xcode: "11.1"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--static-swift-stdlib"
    bin.install ".build/release/bclm"
  end
end

