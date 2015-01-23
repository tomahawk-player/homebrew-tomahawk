require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Tomahawk < Formula
  homepage ''
  url 'http://downloads.tomahawk-player.org/tomahawk-0.7.0.tar.bz2'
  head 'git://github.com/tomahawk-player/tomahawk.git'
#  md5 '708602116a849c4739480cf52a98bc1a'

  # required:
  depends_on 'cmake' => :build
  depends_on 'pkg-config' => :build
  depends_on 'qjson'
  depends_on 'taglib'
  depends_on 'boost'
  depends_on 'libechonest'
  depends_on 'gnutls'
  depends_on 'google-sparsehash'
  depends_on 'quazip'
  depends_on 'tomahawk-player/tomahawk/kde-phonon'
  depends_on 'tomahawk-player/tomahawk/attica'
  depends_on 'tomahawk-player/tomahawk/lucenepp' => 'c++11'
  depends_on 'tomahawk-player/tomahawk/snorenotify'
  depends_on 'tomahawk-player/tomahawk/lastfmlib'
#  depends_on 'tomahawk-player/tomahawk/qtkeychain'
#  depends_on 'tomahawk-player/tomahawk/phonon-vlc'

  # optional:
  depends_on 'tomahawk-player/tomahawk/jreen'
  depends_on 'qca'
  depends_on 'tomahawk-player/tomahawk/qca-ossl'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install" # if this fails, try separate make/make install steps
    system "exit"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test tomahawk`.
    system "false"
  end
end
