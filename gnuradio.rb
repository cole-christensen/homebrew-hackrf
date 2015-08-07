class Gnuradio < Formula
  homepage "http://gnuradio.org"
  url "http://gnuradio.org/git/gnuradio.git", :tag => "v3.7.7.1", :revision => '608c13518e2d5e30b4eed633d7286eb1ebb60ad9'
  #  revision 2

  depends_on "cmake" => :build
  depends_on "Cheetah" => :python
  depends_on "lxml" => :python
  depends_on "numpy" => :python
  depends_on "scipy" => :python
  depends_on "matplotlib" => :python
  depends_on "python"
  depends_on "boost"
  depends_on "cppunit"
  depends_on "gsl"
  depends_on "fftw"
  depends_on "swig" => :run
  depends_on "pygtk"
  depends_on "sdl"
  depends_on "libusb"
  depends_on "orc"
  depends_on "pyqt" unless ARGV.include?("--without-qt")
  depends_on "pyqwt" unless ARGV.include?("--without-qt")
  depends_on "doxygen" if ARGV.include?("--with-docs")
  depends_on "sphinx" if ARGV.include?("--with-docs")

  #  fails_with :clang do
  #    build 421
  #    cause "Fails to compile .S files."
  #  end

  #  fails_with :llvm

  def options
    [
      ["--with-qt", "Build gr-qtgui."],
      ["--with-docs", "Build docs."]
    ]
  end

  #  def patches
  #    DATA
  #  end

  def install
    #    ENV["CC"] = "/usr/bin/llvm-gcc"
    #    ENV["HOMEBREW_CC"] = "llvm-gcc"
    #    ENV["LD"] = "/usr/bin/llvm-gcc"
    #    ENV["CXX"] = "/usr/bin/llvm-g++"
    #    ENV["HOMEBREW_CXX"] = "llvm-g++"
    mkdir "build" do
      args = ["-DCMAKE_PREFIX_PATH=#{prefix}", "-DQWT_INCLUDE_DIRS=#{HOMEBREW_PREFIX}/lib/qwt.framework/Headers"] + std_cmake_args
      args << "-DENABLE_GR_QTGUI=OFF" if ARGV.include?("--without-qt")
      args << "-DENABLE_DOXYGEN=OFF" unless ARGV.include?("--with-docs")

      # From opencv.rb
      python_prefix = `python-config --prefix`.strip
      # Python is actually a library. The libpythonX.Y.dylib points to this lib, too.
      args << "-DPYTHON_LIBRARY=#{python_prefix}/Python"
      args << '-DPYTHON_INCLUDE_DIRS="/usr/local/Cellar/python/2.7.10_2/Frameworks/Python.framework/Versions/2.7/include/python2.7,/usr/local/Cellar/python/2.7.10_2/Frameworks/Python.framework/Versions/2.7/include/python2.7"'
      args << "-DPYTHON_PACKAGES_PATH=/usr/local/lib/python2.7/site-packages"

      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  def python_path
    python = Formula["python"]
    kegs = python.rack.children.reject { |p| p.basename.to_s == ".DS_Store" }
    kegs.find { |p| Keg.new(p).linked? } || kegs.last
  end

  def caveats
    <<-EOS.undent
    If you want to use custom blocks, create this file:

    ~/.gnuradio/config.conf
      [grc]
      local_blocks_path=/usr/local/share/gnuradio/grc/blocks
    EOS
  end

  def which_python
    "python" + `python -c "import sys;print(sys.version[:3])"`.strip
  end
end

__END__
