#!/usr/bin/env bash

set -x
gcc -c first.c fourth.c second.c third.c
ar rcs libmystaticlib.a first.o fourth.o second.o third.o 
gcc -shared libmystaticlib.a -o libmydynamiclib.so

