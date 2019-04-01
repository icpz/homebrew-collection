class GrepDefaultName < Formula
  desc "GNU grep, egrep and fgrep"
  homepage "https://www.gnu.org/software/grep/"
  url "https://ftp.gnu.org/gnu/grep/grep-3.3.tar.xz"
  mirror "https://ftpmirror.gnu.org/grep/grep-3.3.tar.xz"
  sha256 "b960541c499619efd6afe1fa795402e4733c8e11ebf9fafccc0bb4bccdc5b514"

  depends_on "pkg-config" => :build
  depends_on "pcre"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-nls
      --prefix=#{prefix}
      --infodir=#{info}
      --mandir=#{man}
      --with-packager=Homebrew
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    text_file = testpath/"file.txt"
    text_file.write "This line should be matched"

    grepped = shell_output("#{bin}/grep match #{text_file}")
    assert_match "should be matched", grepped
  end
end
