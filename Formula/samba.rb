class Samba < Formula
  desc "Samba is the standard Windows interoperability suite of programs for Linux and Unix"
  homepage "https://www.samba.org/"
  url "https://download.samba.org/pub/samba/stable/samba-4.11.5.tar.gz"
  sha256 "f3e299ff62e424c0c259a2e60ca30979c8a65244d7ef6b54667902dac639d93f"

  depends_on "pkg-config" => :build
  depends_on "python"
  depends_on "gnutls"
  depends_on "readline"
  depends_on "libiconv"
  depends_on "popt"
  depends_on "zlib"
  depends_on "lmdb"
  depends_on "libarchive"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula["readline"].opt_lib/"pkgconfig"}"
    ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula["zlib"].opt_lib/"pkgconfig"}"
    ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula["libarchive"].opt_lib/"pkgconfig"}"

    args = %W[
      --prefix=#{prefix}
      --python=#{Formula["python"].bin/"python3"}
      --mandir=#{prefix}/share/man
      --with-libiconv=#{Formula["libiconv"].opt_prefix}
      --without-ad-dc
      --without-json
      --without-acl-support
    ]

    system "./configure", *args
    system "make", "-j#{ENV.make_jobs}"
    system "make", "install"
  end

end
