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
    cc =   "CC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc"
    cxx =  "CXX=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++"
    objc = "OBJC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc"

    # gettext is keg-only so make sure vlc finds it
    gettext = Formula.factory("gettext")
    ldf = "LDFLAGS=\"-L#{gettext.lib} -lintl\""
    cfl = ""
    cxxfl = ""
    print "Adding libintl directly to the environment: #{ENV['LDFLAGS']} and #{ENV['CFLAGS']}"

    # this is needed to find some m4 macros installed by homebrew's pkg-config 
    aclocal = "ACLOCAL_ARGS=\"-I /usr/local/share/aclocal\""

    if MacOS.version >= 10.10
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk"
      cfl = "CFLAGS=\"-I#{gettext.include}  -mmacosx-version-min=10.10\""
      cxxfl = "CXXFLAGS=\" -mmacosx-version-min=10.8\""
    elsif MacOS.version >= 10.9
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk"
      cfl = "CFLAGS=\"-I#{gettext.include}  -mmacosx-version-min=10.9\""
      cxxfl = "CXXFLAGS=\" -mmacosx-version-min=10.8\""
    elsif MacOS.version >= 10.8
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
      cfl = "CFLAGS=\"-I#{gettext.include}  -mmacosx-version-min=10.8\""
      cxxfl = "CXXFLAGS=\" -mmacosx-version-min=10.8\""
    else
      sdk = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk"
      cfl = "CFLAGS=\"-I#{gettext.include}  -mmacosx-version-min=10.7\""
      cxxfl = "CXXFLAGS=\" -mmacosx-version-min=10.7\""
    end

    libt = "LIBTOOL=\"/usr/local/bin/glibtool --tag=CC\""
    libtfl = "LIBTOOLFLAGS=--tag=CC"

    exp = ""
    if MacOS.xcode_version.to_f >= 5.0
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

  def patches
    DATA
  end
end

__END__
diff --git a/contrib/src/ffmpeg/rules.mak b/contrib/src/ffmpeg/rules.mak
index 65d9cb8..153e898 100644
--- a/contrib/src/ffmpeg/rules.mak
+++ b/contrib/src/ffmpeg/rules.mak
@@ -8,7 +8,7 @@ ifdef USE_FFMPEG
 HASH=313d75c
 FFMPEG_SNAPURL := http://git.videolan.org/?p=ffmpeg.git;a=snapshot;h=$(HASH);sf=tgz
 else
-HASH=e8049af
+HASH=9bec3ca
 FFMPEG_SNAPURL := http://git.libav.org/?p=libav.git;a=snapshot;h=$(HASH);sf=tgz
 endif

