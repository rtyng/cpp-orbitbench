cmake_minimum_required(VERSION 3.20)

project(
    OrbitBench
    VERSION 0.1.0
    DESCRIPTION "A command-line tool for benchmarking numerical integration methods"
    LANGUAGES CXX
)

add_executable(orbitbench
    src/main.cpp
)

target_compile_features(orbitbench PRIVATE cxx_std_20)

set_target_properties(
    orbitbench
    PROPERTIES
        CXX_EXTENSIONS OFF
)