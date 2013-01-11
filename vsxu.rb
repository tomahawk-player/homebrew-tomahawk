require 'formula'

class Jreen < Formula
  head 'git://github.com/vovoid/vsxu.git'
#  url ''
#  md5 ''

  depends_on 'tomahawk-player/tomahawk/cmake'
  depends_on 'glfw'
  depends_on 'glew'
  depends_on 'ftgl'
#  depends_on 'libpng'
#  depends_on 'libjpeg'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
