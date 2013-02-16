require 'formula'

class Libechonest < Formula
  homepage 'https://projects.kde.org/projects/playground/libs/libechonest'
  url 'http://files.lfranchi.com/libechonest-2.0.3.tar.bz2'
  sha1 '2fbcfbb9107c0538ba7dd7361e2049cc272d09c8'

  depends_on 'tomahawk-player/tomahawk/cmake' => :build
  depends_on 'qt'
  depends_on 'qjson'

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
