### AddressSanitizerExampleStackOutOfBounds

```
// RUN: clang -O -g -fsanitize=address %t && ./a.out
int main(int argc, char **argv) {
  int stack_array[100];
  stack_array[1] = 0;
  return stack_array[argc + 100];  // BOOM
}
```

```
=================================================================
==6240== ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fff8098b2b4 at pc 0x417fe1 bp 0x7fff8098b0f0 sp 0x7fff8098b0e8
READ of size 4 at 0x7fff8098b2b4 thread T0
    #0 0x417fe0 in main example_StackOutOfBounds.cc:5
    #1 0x7fa3667c976c (/lib/x86_64-linux-gnu/libc.so.6+0x2176c)
    #2 0x417e54 (a.out+0x417e54)
Address 0x7fff8098b2b4 is located at offset 436 in frame <main> of T0's stack:
  This frame has 1 object(s):
    [32, 432) 'stack_array'
HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
      (longjmp and C++ exceptions *are* supported)
Shadow bytes around the buggy address:
  0x1ffff0131600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1ffff0131610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1ffff0131620: f1 f1 f1 f1 00 00 00 00 00 00 00 00 00 00 00 00
  0x1ffff0131630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1ffff0131640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x1ffff0131650: 00 00 00 00 00 00[f4]f4 f3 f3 f3 f3 00 00 00 00
  0x1ffff0131660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1ffff0131670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1ffff0131680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1ffff0131690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1ffff01316a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==6240== ABORTING
```
