# Acknowledgements: Some configuration source from
# https://github.com/pivotal-casebook/microbrew

require 'formula'

class Vim < Formula
  # Get stable versions from hg repo instead of downloading an increasing
  # number of separate patches.
  url 'https://vim.googlecode.com/hg/', :revision => 'ee53a39d5896'
  version '7.3.000'
  homepage 'http://www.vim.org/'

  head 'https://vim.googlecode.com/hg/'

  skip_clean "bin"

  def install
    # Debugging symbols
    ENV["CFLAGS"] = "-g"

    # No-op the strip
    ENV["STRIP"] = "/usr/bin/true"

    args = [
      "./configure", "--prefix=#{prefix}",
      "--mandir=#{man}",
      "--enable-gui=no",
      "--without-x",
      "--disable-nls",
      "--enable-multibyte",
      "--with-tlib=ncurses",
      "--enable-pythoninterp",
      "--enable-rubyinterp",
      "--with-features=huge"
    ]

    if File.exists?(File.expand_path "~/.rvm/bin/rvm")
      args = ["rvm", "system", "exec"] + args
    end

    system *args
    system "make"
    system "make install"
  end
end
