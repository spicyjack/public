require 'formula'

class Perl <Formula
  url 'http://www.cpan.org/src/perl-5.12.2.tar.bz2'
  homepage 'http://www.perl.org'
  md5 '7b018fe9c2f434eff0c629b4c515a8fc'

  depends_on 'gdbm' => :optional

  def install
    system "./Configure", "-f config.sh", "-Dusethreads", "-Dprefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
