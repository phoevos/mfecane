.text
.align 4
.global strcat
.type strcat, %function

@ r0: dest, r1: src
strcat:
    mov r4, r0    @ store destination address
loop:
    ldrb r2, [r0], #1   @ load str character and move on to the next address
    cmp r2, #0      @ was this the end of the string?
    bne loop        @ read characters until you reach the end of the string
    sub r0, #1
concat:
    ldrb r3, [r1], #1   @ load str character from source and move on to the next address
    strb r3, [r0], #1   @ store character at the end of the destination string
    cmp r3, #0      @ was this the end of the string?
    bne concat
exit:
    mov r0, r4  @ restore dest address
    bx lr
