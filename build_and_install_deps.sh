#!/bin/sh
set -ex

sudo apt-get install tcl-dev tk-dev libreadline5 libboost-graph-dev exuberant-ctags pkg-config librsvg2-dev libdb-dev libdb++-dev libjson-spirit-dev libgsl0-dev libboost-system-dev libboost-regex-dev libboost-date-time-dev libboost-program-options-dev libboost-filesystem-dev libboost-thread-dev gcc-4.8 g++-4.8 cmake -y linkchecker latex2html libunittest++-dev 


git clone https://github.com/posix4e/ecolab.git 
(cd ecolab; make; make install)

git clone https://github.com/posix4e/tktable.git
(cd tktable; ./configure && make ; cp *.so ~/usr/ecolab/lib)

git clone https://github.com/SOCI/soci.git
(cd soci; cmake . && make && env DESTDIR=../soci_target make install)

cp soci_target/usr/local/lib64/* ~/usr/ecolab/lib/
cp -a soci_target/usr/local/include/soci/ ~/usr/ecolab/include/

git clone https://github.com/zaphoyd/websocketpp.git
(cd websocketpp; git checkout origin/0.2.x; make && env prefix=../websocketpp_t make install)
cp -a websocketpp_t/include/websocketpp/ ~/usr/ecolab/include/
cp -a websocketpp_t/lib/* ~/usr/ecolab/lib

git clone https://github.com/unittest-cpp/unittest-cpp.git
(cd unittest-cpp;git checkout v1.5.0; cmake .; make ; env DESTDIR=../unittest_target make install)
cp -a unittest_target/usr/local/include/UnitTest++ test
