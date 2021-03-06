# Notes on C/C++

## C++14 in CMakeLists.txt

Add after the project definition:
```
# C++14
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
```


## AddressSanitizer for memory leak detection

Add these flags after the project definition:
```
# -fsanitize=address for AddressSanitizer memory leak reporting
# -g for debugging info
# -O1 for basic optimizations -- can help with more complicated asan reporting
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address -g -O1")
```

Then when you run an app with a memory leak:

```shell
./myapp

Hello, world!

=================================================================
==22602==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f59e8282608 in operator new[](unsigned long) (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xe0608)
    #1 0x55b5db085595 in SimpleContainer::SimpleContainer(int) /path/to/src/hw/hw.h:14
    #2 0x55b5db085595 in main /path/to/src/hw/main.cpp:17
    #3 0x55b5db0858a3 in _IO_stdin_used (/path/to/src/hw/build/hw+0x18a3)

SUMMARY: AddressSanitizer: 40 byte(s) leaked in 1 allocation(s).
```


## Testing with Googletest

References:
- [Googletest Primer](https://github.com/google/googletest/blob/master/googletest/docs/primer.md)
- [Intro to Google Test and CMake](https://www.youtube.com/watch?v=Lp1ifh9TuFI)


### Assertions

A subset:
- `EXPECT_TRUE(<expr>)` - Test `<expr>` and report pass/fail.
- `ASSERT_TRUE(<expr>)` - Test `<expr>` and report pass/fail, stopping the tests if it fails.
- `EXPECT_EQ(<expr1>, <expr2>)` - Test whether `<expr1>` and `<expr2>` are equal.
- `EXPECT_NE(<expr1>, <expr2>)` - Test whether `<expr1>` and `<expr2>` differ.
- `EXPECT_STREQ(s1, s2)` - Test whether two C strings have the same content.
- `EXPECT_FLOAT_EQ(<expr1>, <expr2>)` - Test whether `<expr1>` and `<expr2>` are equal using floating point comparison.
...

To provide a custom failure message, stream it into the macro:
```cpp
EXPECT_EQ(x, y) << "x and y should be the same";
```

To use the comparison expects/assertions (`EXPECT_EQ`, `ASSERT_EQ`, etc) with a custom type, define the necessary comparison operator(s) (`==` or `<`).


### Test Fixtures

A fixture class to test class `Foo` should be named `FooTest` and should inherit
from `::testing::Test`, with protected access. Use `SetUp` to initialize (use
`override` to be sure it's not misspelled):
```cpp
class FooTest : public ::testing::Test {
  protected:
    void SetUp() override {
      x = 123;
      y = 456;
    }

    int x;
    int y;
};
```


### Setup the project:

```shell
mkdir example
cd example
git clone https://github.com/google/googletest.git
```

Edit `CMakeLists.txt`, example:
```
cmake_minimum_required (VERSION 3.10)
set(This example)
project ($(This) C CXX)
set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 14)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wpedantic")
# Library
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

enable_testing()
add_subdirectory(googletest)

set(Headers
  example.hpp
)

set(Sources
  example.cpp
)

add_library(${This} STATIC ${Sources} ${Headers})
add_subdirectory(test)
```


### Add a test skeleton

Add a test dir and a blank test:
```shell
mkdir test
touch example_tests.cpp
```

Add a `test/CMakeLists.txt` file:
```
cmake_minimum_required (VERSION 3.10)
set(This example_tests)
project ($(This) C CXX)

set(Sources
  example_tests.cpp
)

add_executable(${This} ${Sources})
target_link_libraries(${This} PUBLIC
  gtest_main
  example
)

add_test(
  NAME ${This}
  COMMAND ${This}
)
```


### Build

Build:
```shell
mkdir build
cd build
cmake ..
```

This may remove a warning -- edit `CMakeCache.txt` and set `gtest_force_shared_crt` to `ON`:
```
gtest_force_shared_crt:BOOL=ON
```

Then do a clean build:
```shell
make clean
make
```


### Run tests

Run an empty test (from the `build/` dir):
```shell
./test/example_tests

Running main() from /home/andy/src/example/googletest/googletest/src/gtest_main.cc
[==========] Running 0 tests from 0 test suites.
[==========] 0 tests from 0 test suites ran. (0 ms total)
[  PASSED  ] 0 tests.
```


### Dummy test

Add a dummy test to `test/example_tests.cpp`:
```cpp
#include <gtest/gtest.h>

TEST(example_tests, dummy_test) {
  EXPECT_TRUE(true);
}
```


### Run tests

Run the tests again:
```shell
./test/example_tests

Running main() from /home/andy/src/example/googletest/googletest/src/gtest_main.cc
[==========] Running 1 test from 1 test suite.
[----------] Global test environment set-up.
[----------] 1 test from example_tests
[ RUN      ] example_tests.dummy_test
[       OK ] example_tests.dummy_test (0 ms)
[----------] 1 test from example_tests (0 ms total)

[----------] Global test environment tear-down
[==========] 1 test from 1 test suite ran. (0 ms total)
[  PASSED  ] 1 test.
```

Or:
```shell
make test

Running tests...
Test project /home/andy/src/example/build
    Start 1: example_tests
1/1 Test #1: example_tests ....................   Passed    0.00 sec

100% tests passed, 0 tests failed out of 1

Total Test time (real) =   0.00 sec
```


### Run a specific test case

```shell
./tests/example_tests --gtest_filter=Example.SomeTest
```


## String processing

### Building up strings

`std::to_string` ([reference](http://www.cplusplus.com/reference/string/to_string/) is useful for building up strings from other data types:

```cpp
int x = 4;
std::string s = "This is a string " + "made from " + std::to_string(x) + " parts.";
```


