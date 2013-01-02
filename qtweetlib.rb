require 'formula'

class Qtweetlib < Formula
  url 'https://github.com/downloads/minimoog/QTweetLib/QTweetLib-0.5.tar.gz'
  head 'https://github.com/minimoog/QTweetLib.git'
  homepage 'https://github.com/minimoog/QTweetLib'
  md5 'bf1a7cf45eb63479bf5d81d807b0d518'

  depends_on 'tomahawk-player/tomahawk/cmake'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end

end
