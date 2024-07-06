cmake_minimum_required(VERSION 3.10)

project(googletest-external NONE)

include(ExternalProject)
ExternalProject_Add(googletest
  URL               "https://github.com/google/googletest/archive/main.zip"  # May be empty
  SOURCE_DIR        "/home/azure/abseil-cpp/build/googletest-src"
  BINARY_DIR        "/home/azure/abseil-cpp/build/googletest-build"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
)
