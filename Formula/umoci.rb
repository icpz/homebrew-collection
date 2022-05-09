class Umoci < Formula
  desc "umoci modifies Open Container images"
  homepage "https://umo.ci"
  license "Apache-2.0"
  head "https://github.com/opencontainers/umoci.git", branch: "main"

  depends_on "go" => :build

  def install
    system "make", "umoci.static"
    mv "umoci.static", "umoci"

    bin.install "umoci"
  end
end
