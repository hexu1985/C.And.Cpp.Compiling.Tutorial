### AddressSanitizerExampleGlobalOutOfBounds

```
// RUN: clang -O -g -fsanitize=address %t && ./a.out
int global_array[100] = {-1};
int main(int argc, char **argv) {
  return global_array[argc + 100];  // BOOM
}
```

```
=================================================================
==6211== ERROR: AddressSanitizer: global-buffer-overflow on address 0x000000622314 at pc 0x417fee bp 0x7fff2e146300 sp 0x7fff2e1462f8
READ of size 4 at 0x000000622314 thread T0
    #0 0x417fed in main example_GlobalOutOfBounds.cc:4
    #1 0x7f1c10d2a76c (/lib/x86_64-linux-gnu/libc.so.6+0x2176c)
    #2 0x417ef4 (a.out+0x417ef4)
0x000000622314 is located 4 bytes to the right of global variable 'global_array (example_GlobalOutOfBounds.cc)' (0x622180) of size 400
Shadow bytes around the buggy address:
  0x1000000c4410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000000c4420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000000c4430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000000c4440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000000c4450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x1000000c4460: 00 00[f9]f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  0x1000000c4470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000000c4480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000000c4490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000000c44a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1000000c44b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:     fa
  Heap righ redzone:     fb
  Freed Heap region:     fd
  Stack left redzone:    f1
  Stack mid redzone:     f2
  Stack right redzone:   f3
  Stack partial redzone: f4
  Stack after return:    f5
  Stack use after scope: f8
  Global redzone:        f9
  Global init order:     f6
  Poisoned by user:      f7
  ASan internal:         fe
==6211== ABORTING
```
