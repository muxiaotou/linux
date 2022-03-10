mkdir gmp mpfr mpc gcc

1. cd gmp
   ../gmp-4.3.0/configure --prefix=/usr/local/gmp-4.3.0
   make -j8;make install

2. cd ../mpfr
   ../mpfr-2.4.2/configure --prefix=/usr/local/mpfr-2.4.2 --with-gmp=/usr/local/gmp-4.3.0
   make -j8;make install

3. cd ../mpc
   ../mpc-0.8.2/configure --prefix=/usr/local/mpc-0.8.2 --with-gmp=/usr/local/gmp-4.3.0 --with-mpfr=/usr/local/mpfr-2.4.2
   make -j8;make install

4. export LD_LIBRARY_PATH=$LD_LIBRARY_PATH/usr/local/mpc-0.8.2/lib:/usr/local/gmp-4.3.0/lib:/usr/local/mpfr-2.4.2/lib
   cd ../gcc
   ../gcc-8.5.0/configure --enable-threads=posix --disable-checking --disable-multilib --enable-languages=c,c++ --with-gmp=/usr/local/gmp-4.3.0 --with-mpfr=/usr/local/mpfr-2.4.2 --with-mpc=/usr/local/mpc-0.8.2
   make -j24;make install

5. rpm -qa |grep cmake
   没安装的忽略
   rpm -e cmake-2.8.12.2-2.el7.x86_64

cd ..
unzip cmake-3.20.3.zip
cd cmake-3.20.3
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64
./configure
make -j24;make install

6.设置环境变量后 可以编译工程
export PATH="$PATH:/usr/local/bin"
export CC=/usr/local/bin/gcc
export CXX=/usr/local/bin/g++
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64