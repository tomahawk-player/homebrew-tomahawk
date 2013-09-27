require 'formula'

class Quazip < Formula
  url 'http://downloads.sourceforge.net/project/quazip/quazip/0.4.3/quazip-0.4.3.tar.gz'
  homepage ''
  md5 '5e548a988d059430930b61330b5bfade'

  depends_on 'qt'

  def install
    system "qmake PREFIX=#{prefix}"
    system "make"
    system "make install"
#system "install -Dm644 libquazip.a #{prefix}
  end

  def patches
  'https://gist.github.com/lfranchi/1690173/raw/965d6bde2e447f81b3a9c21dcc10675783f781cc/gistfile1.txt'
  end
end
