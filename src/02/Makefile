BUILD:=E:/project/c++/os_kernel/src/02

all:$(BUILD)/boot.bin

$(BUILD)/boot.bin:$(BUILD)/boot.asm
	mkdir "$(BUILD)/build"
	copy "$(BUILD)/boot.img" "$(BUILD)/build/boot.img"
	nasm $(BUILD)/boot.asm -o $(BUILD)/build/boot.bin
	nasm $(BUILD)/setup.asm -o $(BUILD)/build/setup.bin
	dd if=$(BUILD)/build/boot.bin of=$(BUILD)/build/boot.img seek=0 bs=512 count=1
	dd if=$(BUILD)/build/setup.bin of=$(BUILD)/build/boot.img seek=1 bs=512 count=1




clean:
	rd /s /q "$(BUILD)/build"


bochs:
	bochsdbg  -q -f bochsrc.bxrc


qemug:
	qemu-system-x86_64 -m 32M -fda a.img -S -s

qemu:
	qemu-system-x86_64 -m 32M -fda a.img
