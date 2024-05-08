cmake_minimum_required(VERSION 3.12.0)

set(PROJECT_NAME "project_name")
set(LIBNAME "${PROJECT_NAME}lib")

project(${PROJECT_NAME} VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# --------------------------------------------------------------------------------------------------
# ---- The executable ------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

add_executable(${PROJECT_NAME}
    src/main.cpp
)

target_include_directories(
    ${PROJECT_NAME} PUBLIC
    "${PROJECT_BINARY_DIR}"
    "${PROJECT_SOURCE_DIR}/include"
    )

target_link_libraries(${PROJECT_NAME}
    ${LIBNAME}
    )

# --------------------------------------------------------------------------------------------------
# ---- The library ---------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

include_directories(include)


add_library(${LIBNAME}
    src/lib.cpp
)

set_target_properties(
    ${LIBNAME} PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
    PUBLIC_HEADER fmttools.h
    )

target_include_directories(
    ${LIBNAME} PUBLIC
    "${PROJECT_BINARY_DIR}"
    "${PROJECT_SOURCE_DIR}/include"
    )

# --------------------------------------------------------------------------------------------------
# ---- Testing -------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

include(CTest)
enable_testing()

include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)

set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

add_executable(
    tests
    tests/tests.cpp
    )

target_link_libraries(
    tests
    ${LIBNAME}
    GTest::gtest_main
    )

if (MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE /W4 /WX)
else()
    target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -Wpedantic -Werror)
endif()

include(GoogleTest)
gtest_discover_tests(tests)

# --------------------------------------------------------------------------------------------------
# ---- CPack ---------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------
set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
