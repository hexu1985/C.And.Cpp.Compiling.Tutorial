### AddressSanitizerExampleHeapOutOfBounds

```
// RUN: clang -O -g -fsanitize=address %t && ./a.out
int main(int argc, char **argv) {
  int *array = new int[100];
  array[0] = 0;
  int res = array[argc + 100];  // BOOM
  delete [] array;
  return res;
}
```

```
=================================================================
==6226== ERROR: AddressSanitizer: heap-buffer-overflow on address 0x603e0001fdf4 at pc 0x417f8c bp 0x7fff64c0c010 sp 0x7fff64c0c008
READ of size 4 at 0x603e0001fdf4 thread T0
    #0 0x417f8b in main example_HeapOutOfBounds.cc:5
    #1 0x7fa97c09376c (/lib/x86_64-linux-gnu/libc.so.6+0x2176c)
    #2 0x417e54 (a.out+0x417e54)
0x603e0001fdf4 is located 4 bytes to the right of 400-byte region [0x603e0001fc60,0x603e0001fdf0)
allocated by thread T0 here:
    #0 0x40d312 in operator new[](unsigned long) /home/kcc/llvm/projects/compiler-rt/lib/asan/asan_new_delete.cc:46
    #1 0x417f1c in main example_HeapOutOfBounds.cc:3
Shadow bytes around the buggy address:
  0x1c07c0003f60: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c07c0003f70: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c07c0003f80: fa fa fa fa fa fa fa fa fa fa fa fa 00 00 00 00
  0x1c07c0003f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1c07c0003fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x1c07c0003fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00[fa]fa
  0x1c07c0003fc0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c07c0003fd0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c07c0003fe0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c07c0003ff0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x1c07c0004000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==6226== ABORTING
```
