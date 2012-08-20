require 'formula'

class Vlc < Formula
  # This is a HEAD only formula. the VLC guys say their tarballs are currently having build problems
  homepage 'http://www.videolan.org/vlc'
  head 'git://git.videolan.org/vlc/vlc-2.0.git'

  depends_on 'automake'
  depends_on 'pcre'
  depends_on 'gettext'
  depends_on 'libgcrypt'
  depends_on 'libshout'
  depends_on 'libmad'
  depends_on 'libtool'
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

    # this is needed to find some m4 macros installed by homebrew's pkg-config 
    aclocal = "ACLOCAL_ARGS=\"-I /usr/local/share/aclocal\""

    if MacOS.xcode_version.to_f >= 4.3
      if MacOS.mountain_lion?
        sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk"
      else
        sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk"
      end
    else
      sdk = "/Developer/SDKs/MacOSX10.6.sdk"
    end

    exp = ""
    if MacOS.xcode_version.to_f >= 4.3
      exp = "export #{aclocal}; export #{ldf}; export #{cfl}; export SDKROOT=#{sdk}"
    else
      exp = "export #{path}; export #{aclocal}; export #{cc}; export #{cxx}; export #{objc}; export #{ldf}; export #{cfl}"
    end

    darwinVer = "x86_64-apple-darwin10"

    # Additional Libs
    # KLN 20/08/2012 Added 'make .ogg' and 'make .vorbis' in order to get this recipe to work on OSX 10.6
    system "#{exp}; cd contrib; mkdir -p osx; cd osx; ../bootstrap --host=#{darwinVer} --build=#{darwinVer}"
    system "#{exp}; cd contrib/osx; make prebuilt"
    if MacOS.xcode_version.to_f <= 4.2
      system "cd contrib/osx; make .ogg; make .vorbis"
    end

    # HACK: This file is normally created by the build query git log, but homebrew appears
    # to remove the .git folder just create a blank file so that this step passes 
    system "touch src/revision.txt"

    # VLC
    system "#{exp}; ./bootstrap"
    system "#{exp}; mkdir -p build; cd build; ../extras/package/macosx/configure.sh --disable-asa --disable-macosx --disable-macosx-dialog-provider --with-macosx-sdk=#{sdk} -host=#{darwinVer} --build=#{darwinVer} --prefix=#{prefix}"
    system "#{exp}; cd build; make install"
  end
end
