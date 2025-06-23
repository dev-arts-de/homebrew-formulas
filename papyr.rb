# frozen_string_literal: true

class Papyr < Formula
  desc "Intelligently renames PDF files using AI"
  homepage "https://github.com/dev-arts-de/papyr"
  url "https://github.com/dev-arts-de/papyr/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "65287e6d1c163bfb3540bda3d83d77c3f05f9551b9a34ccdb71200316f5ad098"
  license "MIT"

  depends_on "python@3.12"

  resource "openai" do
    url "https://pypi.io/packages/source/o/openai/openai-1.35.7.tar.gz"
    sha256 "009bfa1504c9c7ef64d87be55936d142325656bbc6d98c68b669d6472e4beb09"
  end

  # Hier wurde der SHA256-Hash für pypdf2 korrigiert.
  resource "pypdf2" do
    url "https://pypi.io/packages/source/P/PyPDF2/PyPDF2-3.0.1.tar.gz"
    sha256 "a74408f69ba6271f71b9352ef4ed03dc53a31aa404d29b5d31f53bfecfee1440"
  end

  resource "tqdm" do
    url "https://pypi.io/packages/source/t/tqdm/tqdm-4.66.4.tar.gz"
    sha256 "232de5fbe2a3c5822b39882256e093aad569f6e1f0611a9efe58a2d1522a46c1"
  end

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources
    libexec.install "papyr.py"
    (bin/"papyr").write_env_script libexec/"papyr.py", PATH: "#{venv.root}/bin:$PATH"
  end

  test do
    assert_match "usage: papyr", shell_output("#{bin}/papyr --help")
  end
end

