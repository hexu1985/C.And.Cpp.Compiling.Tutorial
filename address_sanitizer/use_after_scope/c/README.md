### AddressSanitizerExampleUseAfterScope

```
// RUN: clang -O -g -fsanitize=address -fsanitize-address-use-after-scope \
//    use-after-scope.cpp -o /tmp/use-after-scope
// RUN: /tmp/use-after-scope

// Check can be disabled in run-time:
// RUN: ASAN_OPTIONS=detect_stack_use_after_scope=0 /tmp/use-after-scope

volatile int *p = 0;

int main() {
  {
    int x = 0;
    p = &x;
  }
  *p = 5;
  return 0;
}
```

```
=================================================================
==58237==ERROR: AddressSanitizer: stack-use-after-scope on address 0x7ffc4d830880 at pc 0x0000005097ed bp 0x7ffc4d830850 sp 0x7ffc4d830848
WRITE of size 4 at 0x7ffc4d830880 thread T0
    #0 0x5097ec  (/tmp/use-after-scope+0x5097ec)
    #1 0x7ff85fa6bf44  (/lib/x86_64-linux-gnu/libc.so.6+0x21f44)
    #2 0x41a005  (/tmp/use-after-scope+0x41a005)

Address 0x7ffc4d830880 is located in stack of thread T0 at offset 32 in frame
    #0 0x5096ef  (/tmp/use-after-scope+0x5096ef)

  This frame has 1 object(s):
    [32, 36) 'x' <== Memory access at offset 32 is inside this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-use-after-scope (/tmp/use-after-scope+0x5097ec)
Shadow bytes around the buggy address:
  0x100009afe0c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100009afe0d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100009afe0e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100009afe0f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100009afe100: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
=>0x100009afe110:[f8]f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
  0x100009afe120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100009afe130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100009afe140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100009afe150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100009afe160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Heap right redzone:      fb
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack partial redzone:   f4
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
==58237==ABORTING
```
