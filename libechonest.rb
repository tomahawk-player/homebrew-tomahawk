require 'formula'

class Libechonest < Formula
  homepage 'https://projects.kde.org/projects/playground/libs/libechonest'
  url 'http://files.lfranchi.com/libechonest-2.0.2.tar.bz2'
  sha1 '346eba6037ff544f84505941832604668c1e5b2b'

  depends_on 'tomahawk-player/tomahawk/cmake' => :build
  depends_on 'qt'
  depends_on 'qjson'

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
