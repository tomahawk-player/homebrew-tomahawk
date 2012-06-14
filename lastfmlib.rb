require 'formula'

class Lastfmlib < Formula
  head 'git://github.com/eartle/liblastfm.git'
  url 'http://cdn.last.fm/client/liblastfm-1.0.0.tar.gz'
  md5 '2cf7a63da14cbfe96160fbaf41c1bdd5'

  depends_on 'cmake'
  depends_on 'qt'

  def patches
    'https://raw.github.com/gist/2932406/b8356d788d750f1580dc34a78177b0436c806802/liblastfm-4.8-POST-fix'
  end

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
