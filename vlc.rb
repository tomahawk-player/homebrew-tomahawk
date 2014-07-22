require 'formula'

class Vlc < Formula
  # This is a HEAD only formula. the VLC guys say their tarballs are currently having build problems
  homepage 'http://www.videolan.org/vlc'
  head 'git://git.videolan.org/vlc/vlc-2.2.git'

  depends_on 'intltool' => :build
  depends_on 'automake'
  depends_on 'pcre'
  depends_on 'gettext'
  depends_on 'libgcrypt'
  depends_on 'libshout'
  depends_on 'libmad'
  depends_on 'libtool'
  depends_on 'pkg-config'
  depends_on 'flac'
  depends_on 'yasm'

  def install
    # Compiler
    cc =   "CC=/Developer/usr/bin/llvm-gcc-4.2"
    cxx =  "CXX=/Developer/usr/bin/llvm-g++-4.2"
    objc = "OBJC=/Developer/usr/bin/llvm-gcc-4.2"

    if MacOS.version >= 10.8
      cc =   "CC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc"
      cxx =  "CXX=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++"
      objc = "OBJC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc"
    end    

    # gettext is keg-only so make sure vlc finds it
    gettext = Formula.factory("gettext")
    ldf = "LDFLAGS=\"-L#{gettext.lib} -lintl\""
    cfl = "CFLAGS=\"-I#{gettext.include}  -mmacosx-version-min=10.7\""
    cxxfl = "CXXFLAGS=\" -mmacosx-version-min=10.7\""
    print "Adding libintl directly to the environment: #{ENV['LDFLAGS']} and #{ENV['CFLAGS']}"

    # this is needed to find some m4 macros installed by homebrew's pkg-config 
    aclocal = "ACLOCAL_ARGS=\"-I /usr/local/share/aclocal\""

    if MacOS.xcode_version.to_f >= 5.0
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
    elsif MacOS.xcode_version.to_f >= 4.3
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk"
    else
      sdk = "/Developer/SDKs/MacOSX10.6.sdk"
    end

    libt = "LIBTOOL=\"/usr/local/bin/glibtool --tag=CC\""
    libtfl = "LIBTOOLFLAGS=--tag=CC"

    exp = ""
    if MacOS.xcode_version.to_f >= 4.3
      exp = "export #{aclocal}; export #{ldf}; export #{cfl}; export #{cxxfl}; export SDKROOT=#{sdk}"
    else
      exp = "export #{path}; export #{aclocal}; export #{cc}; export #{cxx}; export #{objc}; export #{ldf}; export #{cfl}; export #{cxxfl}; export SDKROOT=#{sdk}; export #{libt}; export #{libtfl}; export OSX_VERSION=#{MacOS.version}"
    end

    darwinVer = "x86_64-apple-darwin10"

    # Additional Libs
    # KLN 20/08/2012 Added 'make .ogg' and 'make .vorbis' in order to get this recipe to work on OSX 10.6
    system "#{exp}; cd contrib; mkdir -p osx; cd osx; ../bootstrap --host=#{darwinVer} --build=#{darwinVer} --disable-sout"
    system "#{exp}; cd contrib/osx; make prebuilt"
    if MacOS.xcode_version.to_f <= 4.2
      system "cd contrib/osx; make .ogg; make .vorbis"
    end
    # libav/ffmpeg in current prebuilts is too old, build a fresh one from source
    system "cd contrib/osx; make .ffmpeg"

    # HACK: This file is normally created by the build query git log, but homebrew appears
    # to remove the .git folder just create a blank file so that this step passes 
    system "touch src/revision.txt"

    # VLC
    system "#{exp}; ./bootstrap"
    system "#{exp}; mkdir -p build; cd build; ../extras/package/macosx/configure.sh --disable-ncurses --disable-asa --disable-macosx --disable-macosx-dialog-provider --disable-libcddb --disable-cdda --with-macosx-sdk=#{sdk} -host=#{darwinVer} --build=#{darwinVer} --prefix=#{prefix}"
    system "#{exp}; cd build; make install"
  end
end
