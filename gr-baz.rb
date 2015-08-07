class GrBaz < Formula
  homepage 'http://wiki.spench.net/wiki/Gr-baz'
  url 'https://github.com/balint256/gr-baz.git',
    :revision => '4dd99bb43810865190611bf5ca52546108dda81b'
  revision 2

  depends_on 'cmake' => :build
  depends_on 'gnuradio'

  def install
    mkdir 'build' do
      system "cmake",
        "..",
        "-DPYTHON_LIBRARY=/usr/local/Frameworks/Python.framework/Versions/2.7/Python",
        '-DPYTHON_INCLUDE_DIRS="/usr/local/Cellar/python/2.7.10_2/Frameworks/Python.framework/Versions/2.7/include/python2.7,/usr/local/Cellar/python/2.7.10_2/Frameworks/Python.framework/Versions/2.7/include/python2.7"',
        "-DCMAKE_INSTALL_PREFIX=#{Formula['gnuradio'].prefix}",
        *std_cmake_args
      system 'make'
      system 'make install'
    end
  end
end
