.include "macros.asm"

.globl checkVictory

checkVictory:
    save_context
    move $s0, $a0  # $s0 = endereço base da matriz (board)
    
    li $s1, 0  # contador
    li $s2, 0  # i = 0
    
    inicio_for_i:
    li $t0, SIZE
    bge $s2, $t0, fim_for_i
        
    li $s3, 0  # j = 0
        
    inicio_for_j:
    bge $s3, $t0, fim_for_j
            
    sll $t1, $s2, 5  # Deslocamento da linha 
    sll $t2, $s3, 2  # Deslocamento da coluna
    add $t1, $t1, $t2  # Combina os deslocamentos para obter o índice na matriz
    add $t1, $t1, $s0  # Calcula o endereço da célula (board[i][j])
            
    lw $s4, 0($t1)  # Carrega o valor da célula
            
    # Verifica se a célula foi revelada (não contém bomba)
    blt $s4, $zero, fim_if
            
    addi $s1, $s1, 1  # contador++
            
    fim_if:
    
    addi $s3, $s3, 1  # j++
    j inicio_for_j
    fim_for_j:
    
    addi $s2, $s2, 1  # i++
    j inicio_for_i
    fim_for_i:
    
    li $t3, BOMB_COUNT
    mul $t0, $t0, $t0
    sub $t0, $t0, $t3
    
    bge $s1, $t0, fim
    li $v0, 0  # Retorna 0 para indicar que o jogador não venceu ainda
    restore_context
    jr $ra
    
    fim:
    li $v0, 1  # Retorna 1 para indicar que o jogador venceu
    restore_context
    jr $ra
    
   