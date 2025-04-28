.data
board: .byte '0', '1', '2', '3', '4', '5', '6', '7', '8'
lines: .asciiz "\n --------- \n"
bars: .asciiz " | "
turn_1: .asciiz "\n\nPlayer's 1 turn: "
turn_2: .asciiz "\n\nPlayer's 2 turn: "
draw_txt: .asciiz "\n\nThe game ended on a draw!"
p1_win: .asciiz "\nPlayer 1 wins!"
p2_win: .asciiz "\nPlayer 2 wins!"
.text
	li $s0, 1 
	li $s1, 0 
disp_board:
	li $t0, 0
	la $t1, board
board_loop:
	li $a0, ' '
	li $v0, 11
	syscall
	lb $a0, ($t1)
	li $v0, 11
	syscall
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	la $a0, bars
	li $v0, 4
	syscall
	lb $a0, ($t1)
	li $v0, 11
	syscall
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	la $a0, bars
	li $v0, 4
	syscall
 	lb $a0, ($t1)
 	li $v0, 11
 	syscall
 	addi $t0, $t0, 1
 	addi $t1, $t1, 1
 	beq $t0, 9, get_turn
 	la $a0, lines
 	li $v0, 4
 	syscall
 	j board_loop  	
get_turn:
 	beq $s0, 1, player_1
 	beq $s0, 2, player_2  
player_1:
 	la $a0, turn_1
 	li $t1, 'X'
  	li $s2, 1
  	j place_choice    
player_2:  
 	la $a0, turn_2
 	li $t1, 'O'
 	li $s2, -1
place_choice:
 	li $v0, 4
 	syscall
 	li $v0, 5
 	syscall
 	bgt $v0, 8, place_choice 
 	blt $v0, 0, place_choice
 	la $t0, board
 	add $t0, $t0, $v0
 	lb $t0, ($t0)
 	beq $t0, 'X', place_choice
 	beq $t0, 'O', place_choice
 	add $s0, $s0, $s2
 	la $t0, board
 	add $t0, $t0, $v0
 	sb $t1, ($t0)
 	addi $s1, $s1, 1 
 	li $a0, '\n'
 	li $v0, 11
 	syscall	
	la $t1, board
	la $t2, board
	li $t3, 0	
check_result: 
	li $a1, 0
	li $a2, 0
 	lb $t0, ($t1)
 	add $a1, $a1, $t0
 	lb $t0, 1($t1)
 	add $a1, $a1, $t0
 	lb $t0, 2($t1)
 	add $a1, $a1, $t0	
	li $t0, 0
 	lb $t0, ($t2)
 	add $a2, $a2, $t0
 	lb $t0, 3($t2)
 	add $a2, $a2, $t0
 	lb $t0, 6($t2)
 	add $a2, $a2, $t0	 
 	beq $a1, 264, win_1
 	beq $a1, 237, win_2
 	beq $a2, 264, win_1
 	beq $a2, 237, win_2
 	addi $t1, $t1, 3
 	addi $t2, $t2, 1 
 	addi $t3, $t3, 1 
 	blt $t3, 3, check_result
	la $t1, board
	li $a1, 0
 	lb $t0, ($t1)
 	add $a1, $a1, $t0
 	lb $t0, 4($t1)
 	add $a1, $a1, $t0
 	lb $t0, 8($t1)
 	add $a1, $a1, $t0	
 	beq $a1, 264, win_1
 	beq $a1, 237, win_2		
 	li $a1, 0	
 	lb $t0, 2($t1)
 	add $a1, $a1, $t0
 	lb $t0, 4($t1)
 	add $a1, $a1, $t0
 	lb $t0, 6($t1)
 	add $a1, $a1, $t0	
 	beq $a1, 264, win_1
 	beq $a1, 237, win_2
	beq $s1, 9, draw
	j disp_board
draw:
	la $a0, draw_txt
 	j display_result
win_1:
 	la $a0, p1_win
 	j display_result
win_2:
 	la $a0, p2_win	
display_result:
	li $v0, 4
	syscall
 	j end
end: 
