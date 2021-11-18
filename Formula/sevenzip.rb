class Sevenzip < Formula
  desc "7-Zip is a file archiver with a high compression ratio"
  homepage "https://7-zip.org"
  url "https://7-zip.org/a/7z2104-src.7z"
  version "21.04b"
  sha256 "5e6b84c8824025033465b82b5b4da5436ae9e0a1430632d72916937d8f9508e8"
  license all_of: ["LGPL-2.1-or-later", "BSD-3-Clause"]

  on_linux do
    depends_on "gcc@9" => :build
  end

  def install
    cd "CPP/7zip/Bundles/Alone2" do
      on_macos do
        suffix = Hardware::CPU.arm? ? "arm64" : "x64"
        system "make", "-f", "../../cmpl_mac_#{suffix}.mak"

        bin.install "b/m_#{suffix}/7zz"
      end

      on_linux do
        system "make", "CXX=#{Formula["gcc@9"].opt_bin}/g++-9", "-f", "../../cmpl_gcc.mak"

        bin.install "b/g/7zz"
      end
    end
  end

  test do
    (testpath/"foo.txt").write("hello world!\n")
    system bin/"7zz", "a", "-t7z", "foo.7z", "foo.txt"
    system bin/"7zz", "e", "foo.7z", "-oout"
    assert_equal "hello world!\n", File.read(testpath/"out/foo.txt")
  end
end
