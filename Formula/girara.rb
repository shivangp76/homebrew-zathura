class Girara < Formula
  desc "Interface library"
  homepage "https://pwmt.org/projects/girara/"
  url "https://github.com/pwmt/girara/archive/refs/tags/0.4.5.tar.gz"
  sha256 "9abb84fdb3f8f51e8aef8d53488fd0631357f0713ad5aa4a5c755c23f54b23df"
  license "Zlib"
  head "https://github.com/pwmt/girara.git", branch: "develop"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "cmake"
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "json-c"
  depends_on "json-glib"
  depends_on "libnotify"
  depends_on "libpthread-stubs"

  def install
    inreplace "girara/utils.c" do |s|
      # s.gsub!(/xdg-open/, "open")
      s.gsub!("xdg-open", "open")
    end
    # Set HOMBREW_PREFIX
    ENV["CMAKE_INSTALL_PREFIX"] = prefix

    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    system "true" # TODO
  end
end
