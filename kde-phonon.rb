require 'formula'

class KdePhonon < Formula
  url 'ftp://ftp.kde.org/pub/kde/stable/phonon/4.6.0/src/phonon-4.6.0.tar.xz'
  homepage 'http://phonon.kde.org/'
  md5 'bbe0c1c62ed14c31479c4c1a6cf1e173'
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

  def patches
    DATA
  end
end

__END__
diff --git a/cmake/FindPhononInternal.cmake b/cmake/FindPhononInternal.cmake
index 7c52f09..a36af8f 100644
--- a/cmake/FindPhononInternal.cmake
+++ b/cmake/FindPhononInternal.cmake
@@ -407,9 +407,9 @@ if (CMAKE_COMPILER_IS_GNUCXX)

       try_compile(_compile_result ${CMAKE_BINARY_DIR} ${_source_file} CMAKE_FLAGS "${_include_dirs}" COMPILE_OUTPUT_VARIABLE _compile_output_var)

-      if(NOT _compile_result)
-         message(FATAL_ERROR "Qt compiled without support for -fvisibility=hidden. This will break plugins and linking of some applications. Please fix your Qt installation.")
-      endif(NOT _compile_result)
+      #if(NOT _compile_result)
+          #message(FATAL_ERROR "Qt compiled without support for -fvisibility=hidden. This will break plugins and linking of some applications. Please fix your Qt installation.")
+      #endif(NOT _compile_result)

       if (GCC_IS_NEWER_THAN_4_2)
         set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility-inlines-hidden")

