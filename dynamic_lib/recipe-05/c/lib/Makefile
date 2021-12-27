
RM = rm -f
AR = ar rcs
CREATE_SO = gcc -shared
CC = gcc
CFLAGS = -fPIC -Wall -g -DNDEBUG 
INCLUDES = 
VPATH = 

SOURCES = $(shell ls *.c)
OBJECTS = $(SOURCES:%.c=%.o)
STATICLIB = libmystaticlib.a
DYNAMICLIB = libmydynamiclib.so

all: $(DYNAMICLIB) $(STATICLIB)
	@echo "DYNAMICLIB = $(DYNAMICLIB)" 
	@echo "STATICLIB = $(STATICLIB)" 

.PHONY: clean
clean:
	$(RM) $(DYNAMICLIB) $(STATICLIB) $(OBJECTS)

$(OBJECTS): %.o: %.c
	$(CC) -o $@ -c $(CFLAGS) $(INCLUDES) $<

$(STATICLIB): $(OBJECTS)
	$(AR) $(STATICLIB) $(OBJECTS)

$(DYNAMICLIB): $(STATICLIB)
	$(CREATE_SO) -o $(DYNAMICLIB) $(STATICLIB) $(LDPATH) $(LDFLAGS)
