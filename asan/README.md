### 简介

Address Sanitizer（ASan）是一个快速的内存错误检测工具。它非常快，只拖慢程序两倍左右（比起Valgrind快多了）。它包括一个编译器instrumentation模块和一个提供malloc()/free()替代项的运行时库。

从gcc 4.8开始，AddressSanitizer成为gcc的一部分。当然，要获得更好的体验，最好使用4.9及以上版本，因为gcc 4.8的AddressSanitizer还不完善，最大的缺点是没有符号信息。

### 使用步骤

- 用-fsanitize=address选项编译和链接你的程序。
- 用-fno-omit-frame-pointer编译，以得到更容易理解stack trace。
- 可选择-O1或者更高的优化级别编译

```
$ gcc -fsanitize=address -fno-omit-frame-pointer -O1 -g use-after-free.c -o use-after-free
```

运行use-after-fee。如果发现了错误，就会打印出类似下面的信息：
```
=================================================================
==13453==ERROR: AddressSanitizer: heap-use-after-free on address 0x614000000044 at pc 0x55b9dfe76231 bp 0x7fff3e52f4a0 sp 0x7fff3e52f490
READ of size 4 at 0x614000000044 thread T0
    #0 0x55b9dfe76230 in main /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free.c:7
    #1 0x7f2c3fce50b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)
    #2 0x55b9dfe7610d in _start (/home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free+0x110d)

0x614000000044 is located 4 bytes inside of 400-byte region [0x614000000040,0x6140000001d0)
freed by thread T0 here:
    #0 0x7f2c3ffbd7cf in __interceptor_free (/lib/x86_64-linux-gnu/libasan.so.5+0x10d7cf)
    #1 0x55b9dfe761f5 in main /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free.c:6
    #2 0x7f2c3fce50b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)

previously allocated by thread T0 here:
    #0 0x7f2c3ffbdbc8 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x10dbc8)
    #1 0x55b9dfe761e5 in main /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free.c:5
    #2 0x7f2c3fce50b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)

SUMMARY: AddressSanitizer: heap-use-after-free /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free.c:7 in main
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
==13453==ABORTING
```

- 第一部分（ERROR）指出错误类型是heap-use-after-free；
- 第二部分（READ）, 指出线程名thread T0，操作为READ，发生的位置是use-after-free.c:7。
    + 该heapk块之前已经在use-after-free.c:6被释放了；
    + 该heap块是在use-fater-free.c:5分配

- 第三部分 (SUMMARY) 前面输出的概要说明。

