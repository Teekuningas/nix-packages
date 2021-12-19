source $stdenv/setup

cp -fr $src/* .

mkdir build
cd build
cmake -DUSE_CPU_ONLY=1 ..
cmake --build .

mkdir -p $out/bin
cp leelaz $out/bin/leelaz
