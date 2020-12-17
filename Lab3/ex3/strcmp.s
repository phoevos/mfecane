.text
.align 4
.global strcmp
.type strcmp, %function

@ r0: str1, r1: str2
strcmp:
    mov r4, #0x0    @ if str1 == str2 return 0
loop:
    ldrb r2, [r0], #1   @ load str1 character
    ldrb r3, [r1], #1   @ load str2 character
    cmp r2, r3
    bne notEqual    @ if they are not equal we should determine which one comes first
    cmp r2, #0      @ was this the end of the strings?
    beq exit
    b loop     
notEqual:
    movlt r4, #0xffffffff   @ if str1 < str2 return -1
    movgt r4, #0x1      @ if str1 > str2 return 1
exit:
    mov r0, r4  @ result in r0
    bx lr
