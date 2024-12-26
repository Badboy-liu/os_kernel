BUILD:=E:/project/cpp/os_kernel/src/04


CFLAGS:= -m32 # 32 位的程序
CFLAGS+= -masm=intel
CFLAGS+= -fno-builtin	# 不需要 gcc 内置函数
CFLAGS+= -nostdinc		# 不需要标准头文件
CFLAGS+= -fno-pic		# 不需要位置无关的代码  position independent code
CFLAGS+= -fno-pie		# 不需要位置无关的可执行程序 position independent executable
CFLAGS+= -nostdlib		# 不需要标准库
CFLAGS+= -fno-stack-protector	# 不需要栈保护
CFLAGS+= -ffreestanding	# 不需要栈保护
CFLAGS:=$(strip ${CFLAGS})

DEBUG:= -g


all: $(BUILD)/build/boot.o $(BUILD)/build/setup.o $(BUILD)/build/head.o $(BUILD)/build/main.o $(BUILD)/build/kernel.bin  $(BUILD)/build/system.bin
	dd if=$(BUILD)/build/boot.o of=$(BUILD)/build/boot.img seek=0 bs=512 count=1
	dd if=$(BUILD)/build/setup.o of=$(BUILD)/build/boot.img seek=1 bs=512 count=2
	dd if=$(BUILD)/build/system.bin of=$(BUILD)/build/boot.img seek=3 bs=512 count=60





$(BUILD)/build/system.bin:$(BUILD)/build/kernel.bin
	objcopy -O binary $(BUILD)/build/kernel.bin $(BUILD)/build/system.bin



$(BUILD)/build/kernel.bin:$(BUILD)/build/head.o  $(BUILD)/build/main.o
	ld -m i386pep    $^ -o $@ -Ttext 0x1200

$(BUILD)/build/main.o:$(BUILD)/init/main.c
	gcc $(CFLAFS) ${DEBUG} -c $< -o $@

$(BUILD)/build/head.o:$(BUILD)/head.asm
	  nasm -f win64 -g $< -o $@

$(BUILD)/build/%.o:$(BUILD)/%.asm
	copy "$(BUILD)/boot.img" "$(BUILD)/build/boot.img"
	nasm $< -o $@




clean:
	rd /s /q "$(BUILD)/build"
	mkdir "$(BUILD)/build"


printf:
	$ $< $@






bochs:
	bochsdbg  -q -f bochsrc.bxrc


qemug:
	qemu-system-x86_64 -S -s -m 32M  -hda $(BUILD)/build/boot.img

qemu:
	qemu-system-x86_64 -m 32M -fda a.img
