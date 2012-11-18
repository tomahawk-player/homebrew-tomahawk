require 'formula'

class PhononVlc <Formula
  homepage 'https://projects.kde.org/projects/kdesupport/phonon/phonon-vlc'
  url "http://mirrors.mit.edu/kde/stable/phonon/phonon-backend-vlc/0.5.0/src/phonon-backend-vlc-0.5.0.tar.xz"
  md5 "fc5dc2b353fa0d9e428ecfc3c485eb66"

  head 'git://anongit.kde.org/phonon-vlc'

  depends_on 'cmake' => :build
  depends_on 'xz' => :build
  depends_on 'kde-phonon'
  depends_on 'vlc'
  depends_on 'libogg'
  depends_on 'libvorbis'
  depends_on 'faad2'

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
    # Turn of an additional phonon option
    return [ "https://raw.github.com/gist/1291340/a430e5653d8082a3093e6ed405ee6960149e89fd/phonon-no-video-patch",
             "https://raw.github.com/gist/1974948/409ad5e13f9e80b86dff7119bdcc8c1c31c6e065/phononvlc-check-bundle-patch",
             "https://raw.github.com/gist/2916817/4bc649a2acd2eba1f15d72e0d77a36012ed50080/phonon-vlc-set-plugin-path.patch",
             "https://raw.github.com/gist/4105819/670e93027417ec36ff730ada6abbc2e8b305c3ae/phonon-vlc-optimize-debug" ]
  end
end
