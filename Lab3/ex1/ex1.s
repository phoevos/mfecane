.text
.syntax unified
.align 4
.global main
.type main, %function

main:
    push {ip,lr}
loop:
    mov r4, #0      @ initialise counter
    mov r5, #10     @ newline character

    mov r0, #1      @ stdout
    ldr r1, =prompt @ location of prompt in memory
    mov r2, #len    @ length of prompt
    mov r7, #4      @ write system call
    swi 0

    mov r0, #0      @ stdin
    ldr r1, =inp_str @ location of inp_str in memory
    mov r2, #33     @ read 32 characters + \n from input
    mov r7, #3      @ read system call
    swi 0

    @ Exit?
    cmp r0, #2      @ Could it be 'q\n' or 'Q\n'?
    bne converter
    ldrb r3, [r1]
    cmp r3, #81     @ Is it Q?
    beq exit
    cmp r3, #113    @ Is it q?
    beq exit

converter:
    ldrb r3, [r1]
    add r4, #1      @ increase counter
    cmp r3, #10     @ Is the character '\n'?
    beq print
    cmp r3, #97     @ Is it >= a?
    blt next1
    cmp r3, #122    @ Is it <= z?
    ble to_capital
next1:
    cmp r3, #65     @ Is it >= A?
    blt next2
    cmp r3, #90     @ Is it <= Z?
    ble to_lower
next2:
    cmp r3, #48     @ Is it >= 0?
    blt next3
    cmp r3, #57     @ Is it <= 9?
    ble conv_number
next3:
    strb r3, [r1], #1
final:
    cmp r4, #33
    beq print
    b converter

to_capital:
    sub r3, r3, #32
    strb r3, [r1], #1
    b final

to_lower:
    add r3, r3, #32
    strb r3, [r1], #1
    b final

conv_number:
    cmp r3, #53
    addlt r3, #5
    subge r3, #5
    strb r3, [r1], #1
    b final

print:
    cmp r4, #33
    strbeq r5, [r1, #-1]    @if 33rd character != '\n' make it '\n'
    mov r0, #1      @ stdout
    ldr r1, =inp_str    @ location of string in memory
    mov r2, r4      @ length string
    mov r7, #4      @ write system call
    swi 0
    cmp r4, #33
    beq flush
    b loop

@ flush buffer
flush:
    mov r7, #3      @ read system call
    mov r0, #2      
    ldr r1,=inp_str
    mov r2, #(1 << 30) @ flush
    swi 0
	b loop

exit:
    pop {ip,pc}
    mov r7, #1      @ exit system call
    swi 0

.data
	prompt: .ascii "Please input a string 32 character long: "
    len = . - prompt @ length of prompt is the current memory indicated by (.) minus the memory location of the first element of string

	inp_str: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0" @ pre-allocate 32 bytes for input string, initialize them with null character '/0'
    inplen = . - inp_str
    
    