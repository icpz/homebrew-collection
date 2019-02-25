class CoreutilsDefaultName < Formula
  desc "GNU File, Shell, and Text utilities"
  homepage "https://www.gnu.org/software/coreutils"
  url "https://ftp.gnu.org/gnu/coreutils/coreutils-8.30.tar.xz"
  mirror "https://ftpmirror.gnu.org/coreutils/coreutils-8.30.tar.xz"
  sha256 "e831b3a86091496cdba720411f9748de81507798f6130adeaef872d206e1b057"
  revision 2

  head do
    url "https://git.savannah.gnu.org/git/coreutils.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "bison" => :build
    depends_on "gettext" => :build
    depends_on "texinfo" => :build
    depends_on "wget" => :build
    depends_on "xz" => :build
  end

  conflicts_with "aardvark_shell_utils", :because => "both install `realpath` binaries"
  conflicts_with "b2sum", :because => "both install `b2sum` binaries"
  conflicts_with "ganglia", :because => "both install `gstat` binaries"
  conflicts_with "gegl", :because => "both install `gcut` binaries"
  conflicts_with "idutils", :because => "both install `gid` and `gid.1`"
  conflicts_with "md5sha1sum", :because => "both install `md5sum` and `sha1sum` binaries"
  conflicts_with "truncate", :because => "both install `truncate` binaries"

  def install
    if MacOS.version == :el_capitan
      # Work around unremovable, nested dirs bug that affects lots of
      # GNU projects. See:
      # https://github.com/Homebrew/homebrew/issues/45273
      # https://github.com/Homebrew/homebrew/issues/44993
      # This is thought to be an el_capitan bug:
      # https://lists.gnu.org/archive/html/bug-tar/2015-10/msg00017.html
      ENV["gl_cv_func_getcwd_abort_bug"] = "no"

      # renameatx_np and RENAME_EXCL are available at compile time from Xcode 8
      # (10.12 SDK), but the former is not available at runtime.
      inreplace "lib/renameat2.c", "defined RENAME_EXCL", "defined UNDEFINED_GIBBERISH"
    end

    system "./bootstrap" if build.head?

    args = %W[
      --prefix=#{prefix}
      --without-gmp
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test").write("test")
    (testpath/"test.sha1").write("a94a8fe5ccb19ba61c4c0873d391e987982fbbd3 test")
    system bin/"sha1sum", "-c", "test.sha1"
    system bin/"ln", "-f", "test", "test.sha1"
  end
end
