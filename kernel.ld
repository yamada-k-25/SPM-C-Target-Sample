ENTRY(boot)

SECTIONS {
    . = 0x80200000;

    .text.boot : {
        KEEP(*(.text.boot));
    }

    .text :{
        *(.text .text.*);
    }

    .rodata : ALIGN(4) {
        *(.rodata .rodata.*);
    }

    .data : ALIGN(4) {
        *(.data .data.*);
    }

    .bss : ALIGN(4) {
        __bss = .;
        *(.bss .bss.* .sbss .sbss.*);
        __bss_end = .;
    }

    . = ALIGN(4);
    . += 128 * 1024; /* 128KB */
    __stack_top = .;

    .riscv.attributes : {
        KEEP(*(.riscv.attributes))
    }
}