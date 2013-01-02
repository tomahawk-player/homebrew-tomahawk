require 'formula'

class Attica < Formula
  homepage 'http://www.kde.org/'
  url 'ftp://ftp.kde.org/pub/kde/stable/attica/attica-0.4.0.tar.bz2'
  md5 '2de3a49d79884ed3ce9df491bf35a86b'

  depends_on 'tomahawk-player/tomahawk/cmake' => :build
  depends_on 'qt'

  def install
    system "cmake #{std_cmake_parameters} ."
    system "make install"
  end
end
