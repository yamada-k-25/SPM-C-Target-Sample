.globl _add_asm
.text
_add_asm:
    movl %edi, %eax
    addl %esi, %eax
    ret
