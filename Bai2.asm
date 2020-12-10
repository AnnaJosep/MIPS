.data
nap: .asciiz "\nThe factorial of 10 is %d\n"
.text
main:	
	#----Nap du lieu
	addi $a0, $zero, 10
	addi $s0, $zero, 0
	#addi $s1, $zero, 7
	jal fact
	
	j exit
fact:
	# Mo rong stack
        addiu   $sp,$sp,-32	
        # dieu kien dung mo rong stack
       # addiu $s0, $s0, 1
      #  beq  $s0, $s1, exit
       # --------------------
	sw      $ra,28($sp) # luu $ra
        
        sw      $a0,32($sp)
        #-------------------
        lw      $v0,32($sp)
       	nop
        bgtz    $v0,L2	# dieu kien dung de quy
        nop

        li      $v0,1       # khoi tao gia tri ban dau cua tich = 1            
        b       L3
        nop

L2:
#---------------- dua cac so tu 1 -> n vao stack
        lw      $v0,32($sp)
        nop
        addiu   $v0,$v0,-1
        move    $a0,$v0
        jal     fact
        nop
#---------------- Nhan lay ket qua vao $v0
        move    $v1,$v0
        lw      $v0,32($sp)
        nop
        mult    $v1,$v0
        mflo    $v0
L3:
#------------Lay cac so tu 1 -> n ra stack
        lw      $ra,28($sp)
        
        addiu   $sp,$sp,32
        jr       $ra
        nop
exit: #----------xuat du lieu
	move $s0, $v0
	li $v0, 4
	la $a0, nap
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
