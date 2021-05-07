class M7zip < Formula
  desc "7-Zip is a file archiver with a high compression ratio"
  homepage "https://7-zip.org"
  url "https://7-zip.org/a/7z2102-src.7z"
  version "21.02a"
  sha256 "ee9755feaa034e7075712bc6b1fad25440bd0a8f21f106a16e37bc4b409f1122"

  def install
    cd "CPP/7zip/Bundles/Alone2" do
      suffix = Hardware::CPU.arm? ? "arm64" : "x64"
      system "make", "-f", "../../cmpl_mac_" + suffix + ".mak"

      bin.install "b/m_" + suffix + "/7zz"
    end
  end
end
