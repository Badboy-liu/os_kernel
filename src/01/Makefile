BUILD:=E:\project\c++\os_kernel/src/01

all:$(BUILD)/build/boot.img

$(BUILD)/build/boot.img:$(BUILD)/add.asm
	mkdir "$(BUILD)/build"
	nasm $(BUILD)/add.asm -o $(BUILD)/build/add.bin
	dd if=$(BUILD)/build/add.bin of=$(BUILD)/build/boot.img seek=0 bs=512 count=1

#$(BUILD)/build/boot.img:$(BUILD)/boot.asm
#	mkdir "$(BUILD)/build"
#	nasm $(BUILD)/boot.asm -o $(BUILD)/build/boot.bin
#	dd if=$(BUILD)/build/boot.bin of=$(BUILD)/build/boot.img seek=0 bs=512 count=1







clean:
	rd /s /q "$(BUILD)/build"


bochs:
	bochsdbg  -q -f bochsrc.bxrc


qemug:
	qemu-system-x86_64 -m 32M -fda a.img -S -s

qemu:
	qemu-system-x86_64 -m 32M -fda a.img
