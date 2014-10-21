require 'formula'

class KdePhonon < Formula
  url 'ftp://ftp.kde.org/pub/kde/stable/phonon/4.8.1/phonon-4.8.1.tar.xz'
  homepage 'http://phonon.kde.org/'
  sha1 '652872be8144c88974aa1992de5ae705a90e3be1'
  head 'git://anongit.kde.org/phonon.git'

  depends_on 'cmake' => :build
  depends_on 'automoc4' => :build
  depends_on 'qt'
  depends_on 'glib' => :build
  depends_on 'xz' => :build

  keg_only "This package is already supplied by Qt and is only needed by KDE packages."

  def install
# inreplace 'cmake/FindPhononInternal.cmake',
    system "cmake -DCMAKE_CXX_FLAGS=\"-stdlib=libc++\" #{std_cmake_parameters} -DPHONON_NO_DBUS=TRUE ."
    system "make install"
  end

#  def patches
#    DATA
#  end
end
