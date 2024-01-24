.data
   .align 4
   M1: .word 2,6,8
       .word 5,6,3 # declaring the first matrix m1
   M2: .word 0,2,11
       .word 3,15,14# declaring the second matrix m2
   .align 4
   M2T: .space 64 # declaring the variable for the transpose of m2
   r1 : .word 2 # number of rows for matrix m1
   c1 : .word 3 # number of columns for matrix m1
   r2 : .word 2  # number of rows for matrix m1
   c2 : .word 3 # number of columns for matrix m1
   space: .asciiz "  "
   newLine : .asciiz "\n"	
    .align 4
   Mx: .space 64
   Error : .asciiz "Multiplication Not Possible"
   
   .eqv DATA_SIZE 4 #size of int

.text

   main:
   la $t4 ,Mx
   lw $t7, r1
   lw $t8,c1
   la $s0 , M1 
   la $a0 , M2 
   la $a3 , M2T 
   lw $a1 , r2 
   lw $a2 , c2
   
   
   jal MTranspose # Runs the MTranspose
   
   lw $s5 ,c1
   jal Mult
   la $a3,Mx
   lw $a1 ,c2
   lw $a2 ,r2
   jal printResult
 
   
   
   #for the end
   li $v0 ,10
   syscall
   
   Mult:
   	bne $t7, $a1 ,printError
   	addi $t0 , $zero , 0
   	addi $t1 , $zero , 0 
   	addi $t6 , $zero , 0 
   	
   	addi $sp , $sp , -4
   	sw $ra , 0($sp)
   	
   	
   	forloop1:
   		jal forloop2
   	  increaseLoop:
   	  add $t1,$zero,0
   	
   	  addi $t0,$t0,1
   	  blt  $t0 , $t7 , forloop1  
   	  
   	  
   	j exit
   	forloop2:
   	
   	mul $t5 , $t0 , $a2 
   	add $t5 , $t5 , $t1 
   	mul $t5 , $t5 , 4 
   	add $t5 , $t5 , $t4
        
        
     
   	jal forloop3
   	add $t6,$zero,0
   	add $t1,$t1,1
   	sw $s7,0($t5)
   	addi $s7,$zero , 0
   	blt  $t1 , $a1 , forloop2 
   	j increaseLoop
   	forloop3:
   	
   	mul $s3 , $t0, $t8 
   	add $s3 , $s3 , $t6
   	mul $s3 , $s3 , 4 
   	add $s3 , $s3 , $s0
        lw  $s3 , 0($s3) 
        
        
   	mul $s6 , $t6 , $a1 
   	add $s6 , $s6 , $t1 
   	mul $s6 , $s6 , 4 
   	add $s6 , $s6 , $a3 
   	lw  $s6 , 0($s6) 
   	 
   	
        
        
        
        mul $s3, $s3,$s6
       	add $s7,$s7,$s3
        
   	add $t6,$t6,1
   	blt  $t6 , $s5 , forloop3 
   	jr $ra
   	
   	
   	printError:
   	li $v0,4
   	la $a0 ,Error
   	syscall 
   	li $v0, 10
   	syscall
   	
   	
   	
   Print_Transpose:
   	addi $t0 , $zero , 0 
   	addi $t1 , $zero , 0
   	
   	addi $sp , $sp , -4
   	sw $ra , 0($sp)
   	
   	iiloop:
   		   		
   		jal jjloop 
   		addi $t1 , $zero , 0
   		addi $t0 , $t0 , 1 
   		
   		li $v0 , 4
  		la $a0 , newLine
  		syscall
   		
   		blt  $t0 , $a2 , iiloop 
   		
   		j exitt
   	jjloop : 
   		mul $t9 , $t0 , $a1 
  		add $t9 , $t9 , $t1 
   		mul $t9 , $t9 , 4 
   		add $t9 , $t9 , $a3 
   		lw  $t9 , 0($t9)
   
   		li $v0 , 1
   		move $a0 , $t9
  		syscall
  		
  		li $v0 , 4
  		la $a0 , space
  		syscall
  		
  		addi $t1 , $t1 , 1 
   		blt  $t1 , $a1 , jjloop  
   		
   		jr $ra
   		
   	exitt : 
   		lw $ra , 0($sp)
   		addi $sp , $sp , 4
   		jr $ra
   		
   	
   
   MTranspose:
   	addi $t0 , $zero , 0 
   	addi $t1 , $zero , 0 
   	
   	addi $sp , $sp , -4
   	sw $ra , 0($sp)
   	
   	iloop:
   		   		
   		jal jloop
   		addi $t1 , $zero , 0
   		addi $t0 , $t0 , 1 
   		blt  $t0 , $a1 , iloop 
   		
   		j exit
   		
   	
   		
   	jloop : 
   		mul $t2 , $t0 , $a2 
   		add $t2 , $t2 , $t1 
   		mul $t2 , $t2 , 4 
   		add $t2 , $t2 , $a0
   		lw  $t2 , 0($t2) 
   		
   		mul $t3 , $t1 , $a1 
   		add $t3 , $t3 , $t0 
   		mul $t3 , $t3 , 4 
   		add $t3 , $t3 , $a3
   		sw  $t2 , 0($t3) 
   		lw  $t5 , 0($t3)
   		
   		addi $t1 , $t1 , 1 
   		blt  $t1 , $a2 , jloop 
   		
   		jr $ra
   	
   	exit : 
   		lw $ra , 0($sp)
   		addi $sp , $sp , 4
   		jr $ra

 

  printResult:
  	addi $sp , $sp , -4
  	sw $ra , 0($sp)
  	addi $t0,$zero,0 
  	addi $t1,$zero,0 
  	j Nested
  While:
  	jal Nested
  	back :
  	addi $t0,$t0,1
  	addi $t1 ,$zero , 0
  	li $v0 , 4
  	la $a0 , newLine
  	
 	 syscall
 	 blt $t0,$a2,While
  j exit
  Nested:
  	mul $t9 , $t0 ,$a1  
  	add $t9 , $t9 , $t1 
  	mul $t9 , $t9 , 4 
  	add $t9 , $t9 , $a3 
  	lw  $t9 , 0($t9)
  	li $v0, 1
  	move $a0, $t9
  	
  syscall
  	li $v0, 4
  	la $a0, space
  syscall
  	addi, $t1, $t1, 1
  	  blt $t1,$a2,Nested
  	  j back
  	  


  
