require 'formula'

class Jreen < Formula
  head 'git://github.com/euroelessar/jreen.git'
  url 'http://qutim.org/dwnl/33/libjreen-1.0.5.tar.bz2'
  md5 'f74492bbdf8e238e281aa1778725e714'

  depends_on 'cmake'
  depends_on 'qca'
  depends_on 'qca-ossl'

  def install
    #system "./configure", "--disable-debug", "--disable-dependency-tracking",
    #                      "--prefix=#{prefix}"
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
