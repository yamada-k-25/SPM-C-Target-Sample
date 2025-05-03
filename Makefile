TOOLCHAINS=org.swift.62202504031a
SWIFT_EXEC ?= $(shell if [ "$(shell uname)" = "Darwin" ]; then xcrun -f swift; else which swift; fi)
CLANG ?= $(shell if [ "$(shell uname)" = "Darwin" ]; then xcrun -f clang; else which clang; fi)
LLVM_OBJCOPY ?= $(shell if [ "$(shell uname)" = "Darwin" ]; then xcrun -f llvm-objcopy; else which llvm-objcopy; fi)

BUILDROOT := $(shell $(SWIFT_EXEC) build --triple riscv32-none-none-eabi -Xswiftc -Xfrontend -Xswiftc -disable-stack-protector --show-bin-path)

.PHONY: all clean

all: kernel.img

kernel.img: kernel.elf
	@echo "💾 Converting to binary kernel image with llvm-objcopy..."
	$(LLVM_OBJCOPY) -O binary kernel.elf kernel.img
	@echo ""
	@echo "🥳 Done! kernel.img was saved to this directory."

kernel.elf: $(BUILDROOT)/libCMyLibrary.a $(BUILDROOT)/Support.build/boot.S.o kernel.ld
	@echo "🔗 Linking with clang..."
	$(CLANG) --target=riscv32-unknown-eabi -o kernel.elf $< $^ -fuse-ld=lld -nostdlib -Wl,--unresolved-symbols=ignore-in-object-files -Wl,-T ./kernel.ld
	@echo ""

$(BUILDROOT)/libCMyLibrary.a $(BUILDROOT)/Support.build/boot.S.o:
	@echo "🛠️  Building with Swift Package Manager..."
	$(SWIFT_EXEC) build --triple riscv32-none-none-eabi -Xswiftc -Xfrontend -Xswiftc -disable-stack-protector
	@echo ""

clean:
	rm -rf kernel.elf kernel.img .build