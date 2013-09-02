require 'formula'

class Websocketpp < Formula
  head 'git://github.com/zaphoyd/websocketpp'

  depends_on 'cmake' => :build
  depends_on 'qt'
  
  def install
    system "cmake  . #{std_cmake_parameters}"
    system "make install"
  end
end
