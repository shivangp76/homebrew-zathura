# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Girara < Formula
  homepage "https://pwmt.org/projects/girara/"
  url "https://github.com/pwmt/girara/archive/0.3.0.tar.gz"
  sha256 "f4565831e34ee157843a5f31bed6318ed3134c69e62ab3d7b66862b79d6fa56e"
  version "0.3.0"

  # depends_on "cmake" => :build
  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on 'pkg-config'
  depends_on 'gtk+3'
  depends_on 'gettext'
  depends_on 'meson'
  depends_on 'libnotify'

  def install
    inreplace "girara/utils.c" do |s|
      s.gsub! /xdg-open/, "open"
    end
    inreplace "meson.build", /'libm'/, "'m'"
    # Set HOMBREW_PREFIX
    ENV['CMAKE_INSTALL_PREFIX'] = prefix

    system "mkdir build"
    system "meson build --prefix #{prefix}"
    system "cd build && ninja && ninja install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test girara`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

