.text
.align 4
.global strcpy
.type strcpy, %function

@ r0: dest, r1: src
strcpy:
    mov r3, r0  @ store the dest address
loop:
    ldrb r2, [r1], #1   @ read character from string and move on to the next
    strb r2, [r0], #1   @ store the above read character
    cmp r2, #0      @ was this the end of the string?
    bne loop
exit:
    mov r0, r3  @ restore the initial address of the destination
    bx lr
