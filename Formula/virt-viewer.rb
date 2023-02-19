class VirtViewer < Formula
  desc "App for virtualized guest interaction"
  homepage "https://virt-manager.org/"
  url "https://releases.pagure.org/virt-viewer/virt-viewer-11.0.tar.xz"
  sha256 "a43fa2325c4c1c77a5c8c98065ac30ef0511a21ac98e590f22340869bad9abd0"

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "glib"
  depends_on "gobject-introspection"
  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "hicolor-icon-theme"
  depends_on "libvirt"
  depends_on "libvirt-glib"
  depends_on "shared-mime-info"
  depends_on "spice-gtk"
  depends_on "spice-protocol"

  patch :DATA

  def install
    args = %W[
      -Dspice=enabled
      -Dvnc=enabled
    ]

    system "meson", "setup", *std_meson_args, *args, "build"
    system "meson", "compile", "-C", "build", "-v"

    ENV["DESTDIR"] = "/"
    system "meson", "install", "-C", "build"
  end

  def post_install
    # manual update of mime database
    system "#{Formula["shared-mime-info"].opt_bin}/update-mime-database", "#{HOMEBREW_PREFIX}/share/mime"
    # manual icon cache update step
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system "#{bin}/virt-viewer", "--version"
  end
end

__END__
--- a/data/meson.build	2021-11-19 03:24:49
+++ b/data/meson.build	2023-02-19 14:52:47
@@ -2,7 +2,6 @@
   desktop = 'remote-viewer.desktop'

   i18n.merge_file (
-    desktop,
     type: 'desktop',
     input: desktop + '.in',
     output: desktop,
@@ -14,7 +13,6 @@
   mimetypes = 'virt-viewer-mime.xml'

   i18n.merge_file (
-    mimetypes,
     type: 'xml',
     input: mimetypes + '.in',
     output: mimetypes,
@@ -27,7 +25,6 @@
   metainfo = 'remote-viewer.appdata.xml'

   i18n.merge_file (
-    metainfo,
     type: 'xml',
     input: metainfo + '.in',
     output: metainfo,

