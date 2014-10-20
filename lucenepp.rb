require 'formula'

class Lucenepp < Formula
  homepage 'https://github.com/luceneplusplus/LucenePlusPlus'
  # url 'https://github.com/luceneplusplus/LucenePlusPlus/archive/rel_3.0.6.tar.gz'
  head 'https://github.com/luceneplusplus/LucenePlusPlus.git'

  depends_on 'cmake' => :build
  depends_on 'boost'

  def install
    system "mkdir build && cd build && cmake #{std_cmake_parameters} .. && make install"
  end
end
