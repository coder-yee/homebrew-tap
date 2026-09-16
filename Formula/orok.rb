class Orok < Formula
  desc "Manage dedicated SSH keys for GitHub repositories"
  homepage "https://github.com/coder-yee/one-repo-one-key"
  url "https://github.com/coder-yee/one-repo-one-key/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a8b9c1cbd98c9abe2f2936aee783ba9d0db8e05dd20899a60ce654e0ac5fb537"
  license "Apache-2.0"

  uses_from_macos "bash"
  uses_from_macos "git"
  uses_from_macos "openssh"

  def install
    bin.install "orok.sh" => "orok"
  end

  test do
    ENV["LC_ALL"] = "C"
    ENV["ONE_REPO_ONE_KEY_CONFIG_DIR"] = testpath/"config"
    assert_match "Quick clone:", shell_output("#{bin}/orok --help")

    key_dir = testpath/"keys with spaces"
    system bin/"orok", "init", key_dir
    assert_predicate key_dir, :directory?
    assert_equal "#{key_dir.realpath}\n", (testpath/"config/key_dir").read
    assert_equal 0700, key_dir.stat.mode & 0777
    assert_equal 0600, (testpath/"config/key_dir").stat.mode & 0777
  end
end
