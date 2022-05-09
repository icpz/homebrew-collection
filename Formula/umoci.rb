class Umoci < Formula
  desc "umoci modifies Open Container images"
  homepage "https://umo.ci"
  license "Apache-2.0"
  head "https://github.com/opencontainers/umoci.git", branch: "main"

  depends_on "go" => :build
  depends_on "go-md2man" => :build

  def install
    system "make", "umoci.static", "docs"

    bin.install "umoci.static" => "umoci"
    man1.install Dir["doc/man/*.1"]
  end
end
