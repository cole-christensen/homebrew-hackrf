require 'formula'

class Bladerf < Formula
  homepage 'http://wiki.spench.net/wiki/Gr-baz'
  url 'https://github.com/Nuand/bladeRF.git',
    :tag => 'libbladeRF_v1.4.3',
    :revision => '60714d7f61f5783bb82d3b14d1b9d742334d4769'
  revision 3

  depends_on 'cmake' => :build

  def install
    mkdir 'build' do
      system 'cmake', '..', '-DTAGGED_RELEASE=On -DENABLE_FX3_BUILD=Off -DENABLE_HOST_BUILD=On', *std_cmake_args
      system 'make'
      system 'make install'
    end
  end
end
