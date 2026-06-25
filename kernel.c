void kernel_main(void)
{
    volatile char *video = (volatile char *)0xB8000;
    video[0] = '4';
    video[1] = 0x0F;
    video[2] = '2';
    video[3] = 0x0F;
    while (1)
        __asm__("hlt");
}