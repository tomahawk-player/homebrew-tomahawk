require 'formula'

class KdePhonon < Formula
  url 'http://download.kde.org/stable/phonon/4.8.3/src/phonon-4.8.3.tar.xz'
  homepage 'http://phonon.kde.org/'
  sha1 'aac5dc44ae4821e6165c6735b9c6063dd111ac03'
  head 'git://anongit.kde.org/phonon.git'

  depends_on 'cmake' => :build
  depends_on 'automoc4' => :build
  depends_on 'qt'
  depends_on 'glib' => :build
  depends_on 'xz' => :build

  keg_only "This package is already supplied by Qt and is only needed by KDE packages."

  def install
# inreplace 'cmake/FindPhononInternal.cmake',
    system "cmake #{std_cmake_parameters} -DPHONON_NO_DBUS=TRUE ."
    system "make install"
  end

#  def patches
#    DATA
#  end
end
