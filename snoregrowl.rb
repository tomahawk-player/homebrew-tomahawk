require 'formula'

class Snoregrowl < Formula
  head 'git://github.com/Snorenotify/SnoreGrowl.git'
  url 'https://github.com/Snorenotify/SnoreGrowl/archive/v0.4.0.tar.gz'
  sha1 '16b84d2fb673438c8250cefd95f7e4c145e4cf22'

  depends_on 'cmake' => :build

  def install
  
    if MacOS.version >= 10.9
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk"
      cfl = "CFLAGS=\"-mmacosx-version-min=10.9\""
      cxxfl = "CXXFLAGS=\"-mmacosx-version-min=10.9\""
    elsif MacOS.version >= 10.8
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
      cfl = "CFLAGS=\"-mmacosx-version-min=10.8\""
      cxxfl = "CXXFLAGS=\"-mmacosx-version-min=10.8\""
    else
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk"
      cfl = "CFLAGS=\"-mmacosx-version-min=10.7\""
      cxxfl = "CXXFLAGS=\"-mmacosx-version-min=10.7\""
    end

    exp = "export #{cfl}; export #{cxxfl}; export SDKROOT=#{sdk}"

    system "#{exp}; cmake . #{std_cmake_parameters}"
    system "#{exp}; make install"
  end
end
