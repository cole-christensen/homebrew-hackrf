class GrFosphor < Formula
  homepage "http://sdr.osmocom.org/trac/wiki/fosphor"
  url      "git://git.osmocom.org/gr-fosphor.git", :revision => "3fdfe7cf812238804f25f5cdfe39f848fd657b33"
  revision 2

  depends_on "cmake" => :build
  depends_on "gnuradio"
  depends_on "glfw3"

  def install
    mkdir "build" do
      python_prefix = `python-config --prefix`.strip
      system 'cmake', '..',
        *std_cmake_args,
        "-DPYTHON_LIBRARY=#{python_prefix}/Python",
        '-DPYTHON_INCLUDE_DIRS="/usr/local/Cellar/python/2.7.10_2/Frameworks/Python.framework/Versions/2.7/include/python2.7,/usr/local/Cellar/python/2.7.10_2/Frameworks/Python.framework/Versions/2.7/include/python2.7"',
        "-DCMAKE_INSTALL_PREFIX=#{Formula['gnuradio'].prefix}"
      system "make"
      system "make", "install"
    end
  end
end
