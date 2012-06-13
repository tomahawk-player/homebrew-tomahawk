require 'formula'

class Jreen < Formula
  head 'git://github.com/euroelessar/jreen.git'
  url 'http://qutim.org/dwnl/39/libjreen-1.1.0.tar.bz2'
  md5 '84d483d59976fcbaa7951dd0acfa689a'

  depends_on 'qt'
  depends_on 'cmake'
  depends_on 'qca'
  depends_on 'qca-ossl'

  def install
    #system "./configure", "--disable-debug", "--disable-dependency-tracking",
    #                      "--prefix=#{prefix}"
    system "cmake . -DQCA2_INCLUDE_DIR=/usr/local/lib/qca.framework/Headers/ #{std_cmake_parameters}"
    system "make install"
  end
end
