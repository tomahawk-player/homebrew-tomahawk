require 'formula'

class Snorenotify < Formula
  head 'git://github.com/Snorenotify/Snorenotify.git'
#  url ''

  depends_on 'cmake' => :build
  depends_on 'qt'
  depends_on 'cryptopp'
  depends_on 'boost'

  def install
    cfl = "CFLAGS=\"-mmacosx-version-min=10.7\""
    cxxfl = "CXXFLAGS=\"-mmacosx-version-min=10.7\""
    sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
    exp = "export #{cfl}; export #{cxxfl}; export SDKROOT=#{sdk}"

    system "#{exp}; cmake . #{std_cmake_parameters}"
    system "#{exp}; make install"
  end
end
