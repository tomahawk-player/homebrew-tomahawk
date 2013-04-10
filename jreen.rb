require 'formula'

class Jreen < Formula
  head 'git://github.com/euroelessar/jreen.git'
  url 'http://download.tomahawk-player.org/libjreen-1.1.1.tar.bz2'
  md5 '180c4a3356b6d5865292e33de2a29820'

  depends_on 'qt'
  depends_on 'tomahawk-player/tomahawk/cmake'
  depends_on 'qca'
  depends_on 'qca-ossl'

  def install
    system "cmake . -DQCA2_INCLUDE_DIR=/usr/local/lib/qca.framework/Headers/ #{std_cmake_parameters}"
    system "make install"
  end
end
