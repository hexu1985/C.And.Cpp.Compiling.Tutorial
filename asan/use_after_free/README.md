### (heap) use after free 释放后使用

下面的代码中，分配array数组并释放，然后返回它的一个元素。

```cpp
  1 #include <stdlib.h>
  2
  3 int main(int argc, char *argv[])
  4 {
  5     int* array = new int[100];
  6     delete []array;
  7     return array[1];
  8 }
```

运行use-after-fee。如果发现了错误，就会打印出类似下面的信息：
```
=================================================================
==13756==ERROR: AddressSanitizer: heap-use-after-free on address 0x614000000044 at pc 0x5628e9d28238 bp 0x7ffde80019f0 sp 0x7ffde80019e0
READ of size 4 at 0x614000000044 thread T0
    #0 0x5628e9d28237 in main /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/cxx/use_after_free.cpp:7
    #1 0x7f907cc140b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)
    #2 0x5628e9d2810d in _start (/home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/cxx/use_after_free+0x110d)

0x614000000044 is located 4 bytes inside of 400-byte region [0x614000000040,0x6140000001d0)
freed by thread T0 here:
    #0 0x7f907ceefaaf in operator delete[](void*) (/lib/x86_64-linux-gnu/libasan.so.5+0x110aaf)
    #1 0x5628e9d281fc in main /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/cxx/use_after_free.cpp:6
    #2 0x7f907cc140b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)

previously allocated by thread T0 here:
    #0 0x7f907ceeeb47 in operator new[](unsigned long) (/lib/x86_64-linux-gnu/libasan.so.5+0x10fb47)
    #1 0x5628e9d281e5 in main /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/cxx/use_after_free.cpp:5
    #2 0x7f907cc140b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)

SUMMARY: AddressSanitizer: heap-use-after-free /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/cxx/use_after_free.cpp:7 in main
Shadow bytes around the buggy address:
  0x0c287fff7fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff7fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff7fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff7fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff7ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x0c287fff8000: fa fa fa fa fa fa fa fa[fd]fd fd fd fd fd fd fd
  0x0c287fff8010: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c287fff8020: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c287fff8030: fd fd fd fd fd fd fd fd fd fd fa fa fa fa fa fa
  0x0c287fff8040: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fff8050: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==13756==ABORTING
```

- 第一部分（ERROR）指出错误类型是heap-use-after-free；
- 第二部分（READ）, 指出线程名thread T0，操作为READ，发生的位置是use-after-free.cpp:7。
    + 该heapk块之前已经在use-after-free.cpp:6被释放了；
    + 该heap块是在use-fater-free.cpp:5分配

- 第三部分 (SUMMARY) 前面输出的概要说明。


