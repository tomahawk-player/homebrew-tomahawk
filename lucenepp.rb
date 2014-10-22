require 'formula'

class Lucenepp < Formula
  homepage 'https://github.com/luceneplusplus/LucenePlusPlus'
  # url 'https://github.com/luceneplusplus/LucenePlusPlus/archive/rel_3.0.6.tar.gz'
  head 'https://github.com/luceneplusplus/LucenePlusPlus.git'

  option :cxx11

  depends_on 'cmake' => :build
  if build.cxx11?
    depends_on 'boost' => 'c++11'
  else
    depends_on 'boost'
  end

  def install
    cmake_args = std_cmake_args
    if build.cxx11?
        cmake_args << '-DCMAKE_CXX_FLAGS=-std=c++11 -stdlib=libc++'
    end
    mkdir 'build' do
        system 'cmake', '..', *cmake_args
        system 'make install'
    end
  end
end
