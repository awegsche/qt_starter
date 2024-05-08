$env:CC="clang"
$env:CXX="clang++"

cmake -S . -B build/debug -G "Ninja" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1

cmake --build build/debug

cd build/debug
ctest
