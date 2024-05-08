$env:CC="clang"
$env:CXX="clang++"

cmake -S . -B build/debug -G "Ninja" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1
cp build/debug/compile_commands.json .

cmake --build build/debug

./build/debug/project_name.exe
