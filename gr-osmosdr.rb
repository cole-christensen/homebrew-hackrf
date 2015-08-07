require 'formula'

class GrOsmosdr < Formula
  homepage 'http://sdr.osmocom.org/trac/wiki/GrOsmoSDR'
  url 'git://git.osmocom.org/gr-osmosdr',
    :shallow => true,
    :revision => '86ad584204762eeb01f07daa683673f1ec3f1df5'
  revision 3

  depends_on 'cmake' => :build
  depends_on 'gnuradio'
  depends_on 'rtlsdr'

  def install
    mkdir 'build' do
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

  def python_path
    python = Formula['python']
    kegs = python.rack.children.reject { |p| p.basename.to_s == '.DS_Store' }
    kegs.find { |p| Keg.new(p).linked? } || kegs.last
  end
end
