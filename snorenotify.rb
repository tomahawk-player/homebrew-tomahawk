require 'formula'

class Snorenotify < Formula
  head 'git://github.com/Snorenotify/Snorenotify.git'
#  url ''

  depends_on 'cmake' => :build
  depends_on 'qt'
  depends_on 'cryptopp'
  depends_on 'boost'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
