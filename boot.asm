; boot/boot.asm

section .multiboot
align 4

; Multiboot constants required by GRUB
MB_MAGIC    equ 0x1BADB002
MB_FLAGS    equ 0
MB_CHECKSUM equ -(MB_MAGIC + MB_FLAGS)

dd MB_MAGIC
dd MB_FLAGS
dd MB_CHECKSUM


section .bss
align 16

; Reserve 16 KB for the stack
stack_bottom:
    resb 16384
stack_top:


section .text
global _start
extern kernel_main

_start:
    ; Initialize the stack pointer
    mov esp, stack_top

    ; Transfer control to the C kernel
    call kernel_main

.hang:
    cli         ; Clear Interrupt Flag
    hlt         ; Halt CPU
    jmp .hang   ; Stay halted forever