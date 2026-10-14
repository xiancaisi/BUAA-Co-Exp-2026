.data
input_buf: .space 1002
stack_buf: .space 1001
empty_msg: .asciiz "EMPTY"
newline:   .asciiz "\n"

.text
main:
    li    $v0, 8
    la    $a0, input_buf
    li    $a1, 1002
    syscall

    la    $t0, input_buf
    la    $t1, stack_buf
    li    $t2, 0

scan_loop:
    lbu   $t3, 0($t0)
    beq   $t3, $zero, finish
    li    $t6, 10
    beq   $t3, $t6, finish
    li    $t6, 13
    beq   $t3, $t6, finish

    beq   $t2, $zero, push_char
    addu  $t4, $t1, $t2
    lbu   $t5, -1($t4)
    bne   $t3, $t5, push_char

    addiu $t2, $t2, -1
    j     next_char

push_char:
    addu  $t4, $t1, $t2
    sb    $t3, 0($t4)
    addiu $t2, $t2, 1

next_char:
    addiu $t0, $t0, 1
    j     scan_loop

finish:
    beq   $t2, $zero, print_empty

    addu  $t4, $t1, $t2
    sb    $zero, 0($t4)
    la    $a0, stack_buf
    li    $v0, 4
    syscall
    j     print_newline

print_empty:
    la    $a0, empty_msg
    li    $v0, 4
    syscall

print_newline:
    la    $a0, newline
    li    $v0, 4
    syscall

    li    $v0, 10
    syscall
