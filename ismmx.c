/*
 Copyright (C) MINZKN.COM
 All rights reserved.
 Code by JaeHyuk Cho <mailto:minzkn@minzkn.com>
*/

#include <stdio.h>

static int (mz_ismmx)(void)
{
#if defined(__USE_ASM_i386__)
#if defined(__x86_64__)
 int s_edx;
 __asm__ volatile(
  "pushq %%rbx\n\t"
  "pushq %%rcx\n\t"
  "cpuid\n\t"
  "popq %%rcx\n\t"
  "popq %%rbx\n\t"
  : "=d"(s_edx)
  : "a"(1)
 );
 return((s_edx & 0x00800000) ? 1 : 0);
#else
 int s_edx;
 __asm__ volatile(
  "pushl %%ebx\n\t"
  "pushl %%ecx\n\t"
  "cpuid\n\t"
  "popl %%ecx\n\t"
  "popl %%ebx\n\t"
  : "=d"(s_edx)
  : "a"(1)
 );
 return((s_edx & 0x00800000) ? 1 : 0);
#endif
#else
 return(0);
#endif
}

int main(void)
{
 static const char *cg_message[] = {"not supported mmx !\n", "mmx supported.\n"};
 (void)fputs(cg_message[ mz_ismmx() ], stdout);
 return(0);
}

/* End of source */
