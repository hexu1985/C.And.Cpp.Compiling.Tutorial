### stack buffer overflow 栈缓存访问溢出

如下代码中，访问的位置超出栈上数组array的边界。

```cpp
1 #include <stdlib.h>
2
3 int main(int argc, char *argv[])
4 {
5     int array[100];
6     return array[100];
7 }
```

下面的错误信息指出：

- 错误类型是stack-buffer-overflow
- 不合法操作READ发生在线程T0, stack_buf_overflow.c:6
- 栈块在线程T0的栈上432偏移位置上。

```
=================================================================
==13650==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffc487e0ba0 at pc 0x56035a61c9e7 bp 0x7ffc487e09d0 sp 0x7ffc487e09c0
READ of size 4 at 0x7ffc487e0ba0 thread T0
    #0 0x56035a61c9e6 in main /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/stack_buffer_overflow/c/stack_buffer_overflow.c:6
    #1 0x7f0527b37bf6 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21bf6)
    #2 0x56035a61c839 in _start (/home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/stack_buffer_overflow/c/stack_buffer_overflow+0x839)

Address 0x7ffc487e0ba0 is located in stack of thread T0 at offset 432 in frame
    #0 0x56035a61c929 in main /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/stack_buffer_overflow/c/stack_buffer_overflow.c:4

  This frame has 1 object(s):
    [32, 432) 'array' <== Memory access at offset 432 overflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/stack_buffer_overflow/c/stack_buffer_overflow.c:6 in main
Shadow bytes around the buggy address:
  0x1000090f4120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000090f4130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
  0x1000090f4140: f1 f1 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000090f4150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000090f4160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x1000090f4170: 00 00 00 00[f2]f2 00 00 00 00 00 00 00 00 00 00
  0x1000090f4180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000090f4190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000090f41a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000090f41b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000090f41c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==13650==ABORTING
```
