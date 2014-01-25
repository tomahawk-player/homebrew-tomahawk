require 'formula'

class PhononVlc <Formula
  homepage 'https://projects.kde.org/projects/kdesupport/phonon/phonon-vlc'
  url "http://mirrors.mit.edu/kde/stable/phonon/phonon-backend-vlc/0.7.1/phonon-backend-vlc-0.7.1.tar.xz"
#  md5 "d227b92619124a2b85e2d2e5f0fff90e"

  head 'git://anongit.kde.org/phonon-vlc'

  depends_on 'cmake' => :build
  depends_on 'xz' => :build
  depends_on 'kde-phonon'
  depends_on 'vlc'
  depends_on 'libogg'
  depends_on 'libvorbis'
  depends_on 'faad2'
  depends_on 'qt'

  def install
    #make sure to use the keg-only kde-phonon not the phonon installed with qt
    phonon = Formula.factory("kde-phonon")

    system "cmake . #{std_cmake_parameters} -DPhonon_DIR:PATH=#{phonon.lib}/cmake/phonon"
    system "make install"
    
    # phonon is dumb and just loads p lugins blindly from the qt plugin path. we're really sure we want to be loaded, so we delete any other
    # phonon backends first. 
    pluginDir = "#{Formula.factory("qt").prefix}/plugins/phonon_backend"
    print "pluginDir: #{pluginDir} #{Formula.factory('qt').prefix}"
    system "rm -f #{pluginDir}/*"
    system "cp #{prefix}/lib/kde4/plugins/phonon_backend/phonon_vlc.so #{pluginDir}"
  end

  def patches
    return [ "https://gist.github.com/muesli/8618253/raw/800912c99712102e9d56d849db3b4081df4f4bca/phonon-vlc-oneinstance.patch" ]
  end
end
  