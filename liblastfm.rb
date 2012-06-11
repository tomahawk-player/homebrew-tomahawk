require 'formula'

class liblastfm < Formula
  head 'git://github.com/eartle/liblastfm.git'
  url 'http://users.last.fm/~michael/client/liblastfm-1.0.0.tar.gz'
  md5 '2cf7a63da14cbfe96160fbaf41c1bdd5'

  depends_on 'cmake'
  depends_on 'qt'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
