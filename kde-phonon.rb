require 'formula'

class KdePhonon < Formula
  url 'ftp://ftp.kde.org/pub/kde/stable/phonon/4.7.2/phonon-4.7.2.tar.xz'
  homepage 'http://phonon.kde.org/'
#  md5 'bbe0c1c62ed14c31479c4c1a6cf1e173'
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
