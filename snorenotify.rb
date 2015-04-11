require 'formula'

class Snorenotify < Formula
  head 'git://github.com/Snorenotify/Snorenotify.git'
  url 'https://github.com/Snorenotify/Snorenotify/archive/v0.5.2.tar.gz'
  sha1 '9aa4409422872dd32bd5f831a6201820994065a1'

  depends_on 'cmake' => :build
  depends_on 'qt'
#  depends_on 'snoregrowl'

  def install
  
    if MacOS.version >= 10.9
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk"
      cfl = "CFLAGS=\"-mmacosx-version-min=10.9\""
      cxxfl = "CXXFLAGS=\"-mmacosx-version-min=10.9\""
    elsif MacOS.version >= 10.8
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk"
      cfl = "CFLAGS=\"-mmacosx-version-min=10.8\""
      cxxfl = "CXXFLAGS=\"-mmacosx-version-min=10.8\""
    else
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk"
      cfl = "CFLAGS=\"-mmacosx-version-min=10.7\""
      cxxfl = "CXXFLAGS=\"-mmacosx-version-min=10.7\""
    end

    exp = "export #{cfl}; export #{cxxfl}; export SDKROOT=#{sdk}"

    system "#{exp}; cmake . #{std_cmake_parameters}"
    system "#{exp}; make install"
  end
end
