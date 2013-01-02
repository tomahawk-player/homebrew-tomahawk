require 'formula'

class Libechonest < Formula
  homepage 'https://projects.kde.org/projects/playground/libs/libechonest'
  url 'http://files.lfranchi.com/libechonest-2.0.1.tar.bz2'
  sha1 '5dd98ffb370e0e199e37ece4a1775a05594f3dcb'

  depends_on 'tomahawk-player/tomahawk/cmake' => :build
  depends_on 'qt'
  depends_on 'qjson'

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
