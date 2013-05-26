require 'formula'

class Clucene < Formula
  homepage 'http://sourceforge.net/projects/clucene/'
  url 'http://downloads.sourceforge.net/project/clucene/clucene-core-unstable/2.3/clucene-core-2.3.3.4.tar.gz'
  md5 '48d647fbd8ef8889e5a7f422c1bfda94'
  head 'git://clucene.git.sourceforge.net/gitroot/clucene/clucene'
  
  depends_on 'cmake' => :build

  def install
#     if ARGV.build_head?
      system "cmake #{std_cmake_parameters} ."
#     else
#       system "./configure", "--disable-debug", "--disable-dependency-tracking",
#                             "--prefix=#{prefix}"
#     end

    # Serialize the install step. See:
    # https://github.com/mxcl/homebrew/issues/8712
    ENV.j1
    system "make install"
  end
end
