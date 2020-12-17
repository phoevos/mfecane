.text
.align 4 /* code alignment */
.global main
.extern tcsetattr

main:

open:
    ldr r0, =path           /* device to open */
    ldr r1, =#258           /* 0x102 to decimal */
    mov r7, #5              /* open system call */
    swi 0

    /* now r0 has the fd */
    mov r6, r0              /* save for later */

set_device:
    mov r0, r6              /* call tcsetattr to set the settings for our port */
    ldr r2, =options
    mov r1, #0
    bl tcsetattr

read:
    mov r0, r6              /* read from serial port */
    ldr r1, =string
    mov r2, #64
    mov r7, #3
    swi 0

    ldr r0, =string


    str_manip:
        ldr r3, =arr
        mov r1, #0

    str_manip_loop:
        ldrb r2, [r0], #1   /* load character and move on to the next address */
        cmp r2, #10         /* since we have canonical input, the last useful char will be EOL */
        beq str_manip_end
        ldrb r4, [r3, r2]   /* loads the value in the array with offset r2 (character that we read) */
        add r4, r4, #1      /* increment the number of times we 've seen the character */
        strb r4, [r3, r2]   /* save the value */
        b str_manip_loop

    str_manip_end:
        mov r1, #0          /* offset pointer*/
        mov r0, #0          /* max freq in r0 */
        ldr r3, =arr        /* load array of frequencies to r3 */
	    strb r0, [r3, #32]  /* we don't care about spaces */

    str_manip_end_loop:
        ldrb r2, [r3, r1]   /* load value of array with offset r1 */
        cmp r0, r2          /* maximum freq in r0 */
        movlt r4, r1        /* if r2>r0 save the char */
        movlt r0, r2        /* change max */
        add r1, r1, #1      /* increase offset for next iteration */
        cmp r1, #256        /* if end of the array exit */
        beq str_manip_exit
        b str_manip_end_loop

    str_manip_exit:

    /* Now r0 holds the number of times char showed up  */
    /* r1 holds the character */
        ldr r3, =res
        strb r4, [r3]
        strb r0, [r3, #2]

write:
    mov r0, r6
    ldr r1, =res
    ldr r2, =len_res
    mov r7, #4          /* write system call */
    swi 0

close:
    mov r0, r6          
    mov r7, #6          /* close system call */
    swi 0

exit:
    mov r0, #0
    mov r7, #1          /* exit system call */
    swi 0

.data
    options: .word 0x00000000 /* c_iflag */
             .word 0x00000000 /* c_oflag */
             .word 0x000008bd /* c_cflag */
             .word 0x00000002 /* c_lflag */
             .byte 0x00       /* c_line */
             .word 0x00000000 /* c_cc[0-3] */
             .word 0x00010000 /* c_cc[4-7] */
             .word 0x00000000 /* c_cc[8-11] */
             .word 0x00000000 /* c_cc[12-15] */
             .word 0x00000000 /* c_cc[16-19] */
             .word 0x00000000 /* c_cc[20-23] */
             .word 0x00000000 /* c_cc[24-27] */
             .word 0x00000000 /* c_cc[28-31] */
             .byte 0x00       /* padding */
             .hword 0x0000    /* padding */
             .word 0x0000000d /* c_ispeed */
             .word 0x0000000d /* c_ospeed */

    path: .asciz "/dev/ttyAMA0"

    string: .asciz "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
    len = . - string

    arr: .ascii "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"

    res: .asciz "cccc\n"

    len_res = . - res
