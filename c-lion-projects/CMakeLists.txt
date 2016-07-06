cmake_minimum_required(VERSION 3.5)
project(c_lion_projects)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES  test.c)
add_executable(c_lion_projects ${SOURCE_FILES})