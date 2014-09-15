require 'formula'

class Lucenepp < Formula
  homepage 'https://github.com/luceneplusplus/LucenePlusPlus'
  head 'https://github.com/luceneplusplus/LucenePlusPlus.git'
  
  depends_on 'cmake' => :build

  def install
    system "mkdir build && cd build && cmake #{std_cmake_parameters} .. && make install"
  end
end
