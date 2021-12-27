#!/usr/bin/env bash

set -x
gcc -c first.c fourth.c second.c third.c
ar rcs libmydynamiclib.so first.o fourth.o second.o third.o 

