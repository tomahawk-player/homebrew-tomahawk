require 'formula'

class Taglib < Formula
  homepage 'http://taglib.github.io/'
  url 'https://github.com/taglib/taglib/archive/v1.9.1.tar.gz'
  head 'https://github.com/taglib/taglib.git'
  sha1 '44165eda04d49214a0c4de121a4d99ae18b9670b'

  bottle do
    cellar :any
    revision 1
    sha1 "431580f12a7811288b6e3b187ca75bf5e321fd7c" => :yosemite
    sha1 "7b9a9466fcbfb5952b7c97e739fa38a94e110f16" => :mavericks
    sha1 "9f12bf0949b250e67cb606cf389a99d7d2bc49ca" => :mountain_lion
  end

  depends_on 'cmake' => :build

  option :cxx11

  def install
    ENV.cxx11 if build.cxx11?
    ENV.append 'CXXFLAGS', "-DNDEBUG=1"
    system "cmake", "-DWITH_MP4=ON", "-DWITH_ASF=ON", *std_cmake_args
    system "make"
    system "make install"
  end
end
