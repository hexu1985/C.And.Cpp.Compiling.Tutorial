// RUN: clang -O -g -fsanitize=address %t && ./a.out
// By default, AddressSanitizer does not try to detect
// stack-use-after-return bugs.
// It may still find such bugs occasionally
// and report them as a hard-to-explain stack-buffer-overflow.

// You need to run the test with ASAN_OPTIONS=detect_stack_use_after_return=1

