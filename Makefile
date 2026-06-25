NAME = kfs.iso

ASM = nasm
CC = gcc
LD = ld

ASMFLAGS = -f elf32
CFLAGS = -m32 -ffreestanding -Wall -Wextra -Werror
LDFLAGS = -m elf_i386 -T linker.ld

all: $(NAME)

boot.o: boot.asm
	$(ASM) $(ASMFLAGS) $< -o $@

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

kernel.bin: boot.o kernel.o
	$(LD) $(LDFLAGS) $^ -o $@

$(NAME): kernel.bin grub.cfg
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot/kernel.bin
	cp grub.cfg iso/boot/grub/grub.cfg
	grub-mkrescue -o $(NAME) iso

run: $(NAME)
	qemu-system-i386 -cdrom $(NAME)

clean:
	rm -f boot.o kernel.o

fclean: clean
	rm -f kernel.bin $(NAME)
	rm -rf iso

re: fclean all

.PHONY: all run clean fclean re
