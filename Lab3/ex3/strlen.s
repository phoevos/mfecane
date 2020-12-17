.text
.align 4
.global strlen
.type strlen, %function

@ r0: string address
strlen:
    mov r2, #0      @ initialise counter
loop:
    ldrb r1, [r0], #1   @ load string character and move on to the next address
    cmp r1, #0      @ was this the end of the string?
    beq exit
    add r2, #1      @ if not, increase counter and continue
    b loop
exit:
    mov r0, r2      @ return length in r0
    bx lr
