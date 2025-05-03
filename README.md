# SPM-C-Target-Sample

## Directory Structure

```
.
├── LICENSE
├── Package.swift
├── README.md
├── Sources
│   └── CMyLibrary
│       ├── add.S
│       └── include
│           └── mylib.h
├── Tests
│   └── CMyLibraryTests
│       └── CMyLibraryTests.swift
└── asm
    ├── add_arm64.S
    └── add_x86_64.S
```

## Linker Script

```ld
ENTRY(boot)

SECTIONS {
    . = 0x80200000;

    .text :{
        KEEP(*(.text.boot));
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
}
```

## Run

```shell
$ env TOOLCHAINS=<your swift tool chains version> make
```


## Test

```shell
$ swift test
Building for debugging...
[11/11] Linking MyPackagePackageTests
Build complete! (3.90s)
Test Suite 'All tests' started at 2025-04-04 22:31:10.092.
Test Suite 'All tests' passed at 2025-04-04 22:31:10.099.
         Executed 0 tests, with 0 failures (0 unexpected) in 0.000 (0.007) seconds
􀟈  Test run started.
􀄵  Testing Library Version: 94 (arm64e-apple-macos13.0)
􀟈  Test testAdd() started.
􁁛  Test testAdd() passed after 0.001 seconds.
􁁛  Test run with 1 test passed after 0.001 seconds.
```
