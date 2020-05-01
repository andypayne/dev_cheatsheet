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
