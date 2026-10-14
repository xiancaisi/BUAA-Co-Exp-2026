.text
main:
    li   $v0, 5              # Read year
    syscall
    move $t0, $v0

    li   $a0, 0              # Default: not a leap year

    li   $t1, 400
    div  $t0, $t1
    mfhi $t2
    beq  $t2, $zero, leap

    li   $t1, 100
    div  $t0, $t1
    mfhi $t2
    beq  $t2, $zero, print_result

    li   $t1, 4
    div  $t0, $t1
    mfhi $t2
    bne  $t2, $zero, print_result

leap:
    li   $a0, 1

print_result:
    li   $v0, 1              # Print 0 or 1
    syscall

    li   $v0, 10             # Exit
    syscall
