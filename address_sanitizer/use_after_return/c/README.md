### AddressSanitizerExampleUseAfterReturn

```
// RUN: clang -O -g -fsanitize=address %t && ./a.out
// By default, AddressSanitizer does not try to detect
// stack-use-after-return bugs.
// It may still find such bugs occasionally
// and report them as a hard-to-explain stack-buffer-overflow.

// You need to run the test with ASAN_OPTIONS=detect_stack_use_after_return=1

int *ptr;
__attribute__((noinline))
void FunctionThatEscapesLocalObject() {
  int local[100];
  ptr = &local[0];
}

int main(int argc, char **argv) {
  FunctionThatEscapesLocalObject();
  return ptr[argc];
}
```

```
=================================================================
==6268== ERROR: AddressSanitizer: stack-use-after-return on address 0x7fa19a8fc024 at pc 0x4180d5 bp 0x7fff73c3fc50 sp 0x7fff73c3fc48
READ of size 4 at 0x7fa19a8fc024 thread T0
    #0 0x4180d4 in main example_UseAfterReturn.cc:17
    #1 0x7fa19b11d76c (/lib/x86_64-linux-gnu/libc.so.6+0x2176c)
    #2 0x417f34 (a.out+0x417f34)
Address 0x7fa19a8fc024 is located at offset 36 in frame <_Z30FunctionThatEscapesLocalObjectv> of T0's stack:
  This frame has 1 object(s):
    [32, 432) 'local'
HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
      (longjmp and C++ exceptions *are* supported)
Shadow bytes around the buggy address:
  0x1ff43351f7b0: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  0x1ff43351f7c0: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  0x1ff43351f7d0: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  0x1ff43351f7e0: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  0x1ff43351f7f0: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
=>0x1ff43351f800: f5 f5 f5 f5[f5]f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x1ff43351f810: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x1ff43351f820: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x1ff43351f830: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 00 00 00 00
  0x1ff43351f840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x1ff43351f850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==6268== ABORTING
``` 
