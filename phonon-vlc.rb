require 'formula'

class PhononVlc <Formula
  homepage 'https://projects.kde.org/projects/kdesupport/phonon/phonon-vlc'
  url 'http://download.kde.org/stable/phonon/phonon-backend-vlc/0.8.2/src/phonon-backend-vlc-0.8.2.tar.xz'
  sha1 'bc7d57d3ecce0293b77b88eba94d091741d33e78'
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
    system "make VERBOSE=1"
    system "make install"
    
    # phonon is dumb and just loads p lugins blindly from the qt plugin path. we're really sure we want to be loaded, so we delete any other
    # phonon backends first. 
    pluginDir = "#{Formula.factory("qt").prefix}/plugins/phonon_backend"
    print "pluginDir: #{pluginDir} #{Formula.factory('qt').prefix}"
    system "rm -f #{pluginDir}/*"
    system "cp #{prefix}/lib/kde4/plugins/phonon_backend/phonon_vlc.so #{pluginDir}"
  end
end
