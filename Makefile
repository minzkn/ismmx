# Copyright (C) MINZKN.COM
# All rights reserved.
# Code by JaeHyuk Cho <mailto:minzkn@minzkn.com>

TARGET_ARCH                  ?= $(shell uname -m | sed \
                                  -e s/i.86/i386/ -e s/sun4u/sparc64/ \
                                  -e s/arm.*/arm/ -e s/sa110/arm/ \
                                  -e s/s390x/s390/ -e s/parisc64/parisc/ )# auto detected architecture

CC := gcc
RM := rm -f

.PHONY: all clean

all: ismmx
clean: ; $(RM) *.o ismmx
ismmx: ismmx.o ; $(CC) -s -o $@ $^
ifeq ($(findstring i386,$(TARGET_ARCH)),i386)
%.o: %.c ; $(CC) -O2 -Wall -Werror -fomit-frame-pointer -ansi -D__USE_ASM_i386__ -c -o $@ $<
else
ifeq ($(findstring x86_64,$(TARGET_ARCH)),x86_64)
%.o: %.c ; $(CC) -O2 -Wall -Werror -fomit-frame-pointer -ansi -D__USE_ASM_i386__ -c -o $@ $<
else
%.o: %.c ; $(CC) -O2 -Wall -Werror -fomit-frame-pointer -ansi -c -o $@ $<
endif
endif

# End of Makefile
