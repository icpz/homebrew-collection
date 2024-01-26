class ReresolveWireguardDns < Formula
  desc "Re-resolve DNS for Wireguard"
  license "GPL-3.0-only"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "1.0"

  depends_on "bash"

  keg_only "no export"

  resource "reresolve-dns" do
    url "https://gist.githubusercontent.com/icpz/d33a888eed84c76dd59e33a85cc8f1d6/raw/431ca1dffd2ef5b1a9176b0934c3f53d6a2ef17f/reresolve-dns-darwin.sh"
    sha256 "d463e5c836c55453b29ecd00af003a56d08ec935c0dfc828a2b323c542f5406c"
  end

  resource "reresolve-wireguard-dns" do
    url "https://gist.githubusercontent.com/icpz/b7db078f60947bbe81cba56d4f4b7bd5/raw/dc161c6bc82bd1c88d45a5855d269d45c01456cc/reresolve-wireguard-dns.sh"
    sha256 "ae71de6db0f5c0e78c002361f35e6d349762b95e918a7912807005de639558c2"
  end

  def install
    resources.each do |r|
      chmod "+x", r.cached_download
      cp r.cached_download, buildpath/r.name
      bin.install buildpath/r.name
    end
  end

  service do
    run [opt_bin/"reresolve-wireguard-dns"]
    run_type :interval
    interval 180
    environment_variables WG_CONF_DIR: etc/"wireguard",
                          WG_RRDNS:    opt_bin/"reresolve-dns",
                          PATH:        std_service_path_env
  end
end
