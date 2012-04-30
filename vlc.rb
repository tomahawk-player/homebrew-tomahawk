require 'formula'

class Vlc < Formula
  url 'http://download.videolan.org/pub/videolan/vlc/1.1.12/vlc-1.1.12.tar.bz2'
  homepage 'http://www.videolan.org/vlc'
  md5 '91de1ad308c947e35380f9d747ff5713'

  depends_on 'pcre'
  depends_on 'gettext'
  depends_on 'libgcrypt'
  depends_on 'libshout'
  depends_on 'libmad'
  depends_on 'flac'

  def install
    # Compiler
    cc =   "CC=/Developer/usr/bin/llvm-gcc-4.2"
    cxx =  "CXX=/Developer/usr/bin/llvm-g++-4.2"
    objc = "OBJC=/Developer/usr/bin/llvm-gcc-4.2"
    
    # gettext is keg-only so make sure vlc finds it
    gettext = Formula.factory("gettext")
    ldf = "LDFLAGS=-L#{gettext.lib} -lintl"
    cfl = "CFLAGS=-I#{gettext.include}"
    print "Adding libintl directly to the environment: #{ENV['LDFLAGS']} and #{ENV['CFLAGS']}"

    exp = "export #{cc}; export #{cxx}; export #{objc}; export #{ldf}; export #{cfl}"
    # Additional Libs
    system "#{exp}; cd extras/contrib; ./bootstrap x86_64-apple-darwin10"
    system "#{exp}; cd extras/contrib; make"

    # VLC
    system "#{exp}; ./bootstrap"
    system "#{exp}; ./configure --enable-merge-ffmpeg --enable-debug --disable-asa --enable-macosx --with-macosx-sdk=/Developer/SDKs/MacOSX10.6.sdk --build=x86_64-apple-darwin10 --prefix=#{prefix}"
    system "#{exp}; make install"
  end
end
