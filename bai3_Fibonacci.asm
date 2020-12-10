.data
nap: .asciiz "\nNhap n: "
ketqua: .asciiz "\nKetQua: "
.text
main:
#---------------Nap du lieu
	li $v0, 4
	la $a0, nap
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0
	jal Fibonacci
	jal xuat
xuat:
	move $s0, $v0
	
	li $v0, 4
	la $a0, ketqua
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 11
	la $a0, 0x20
	syscall
	j exit
Fibonacci:
        addiu   $sp,$sp,-40	# mo rong stack
        sw      $ra,36($sp)	# luu $ra
        
        sw      $s0,32($sp)	# luu gia tri
        
        sw      $a0,40($sp)	# luu gia tri vua nhap
        lw      $v1,40($sp)	# lay gia tri ra xu li
        li      $v0,1                        # 0x1
        beq     $v1,$v0,$L2
        nop

        lw      $v1,40($sp)
        li      $v0,2                        # 0x2
        bne     $v1,$v0,$L3
        nop

$L2:
        li      $v0,1                        # 0x1
        b       $L4
        nop

$L3:	# luu gia tri vao stack
        lw      $v0,40($sp)
        nop
        addiu   $v0,$v0,-1
        move    $a0,$v0
        jal     Fibonacci
        nop

        move    $s0,$v0
        lw      $v0,40($sp)
        nop
        addiu   $v0,$v0,-2
        move    $a0,$v0
        jal     Fibonacci
        nop

        addu    $v0,$s0,$v0
       
$L4:
      
        lw      $ra,36($sp)
      
        lw      $s0,32($sp)
        addiu   $sp, $sp, 40
        jr       $ra

exit: