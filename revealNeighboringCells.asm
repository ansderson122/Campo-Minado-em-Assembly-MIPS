.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
    save_context
    move $s0, $a0     # $s0 = endereço base da matriz (board)
    move $s1, $a1     # $s1 = row
    move $s2, $a2     # $s2 = column
    
    subi $s3, $s1, 1   # i = row - 1
    addi $s4, $s1, 1   # row + 1
    
    inicio_for_i:
    bgt $s3, $s4, fim_for_i  # Se i > row + 1, encerra o loop
        
    subi $s5, $s2, 1   # j = column - 1
    addi $s6, $s2, 1   # column + 1
        
    inicio_for_j:
    bgt $s5, $s6, fim_for_j  # Se j > column + 1, encerra o loop
        
    # Verifica as condições para não ultrapassar os limites do tabuleiro
    blt $s3, $zero, fim_for_j
    bge $s3, SIZE, fim_for_j
    blt $s5, $zero, fim_if
    bge $s5, SIZE, fim_if
            
    sll $t1, $s3, 5  # Deslocamento da linha 
    sll $t2, $s5, 2  # Deslocamento da coluna 
    add $t1, $t1, $t2  # Combina os deslocamentos
    add $s7, $t1, $s0  # Calcula o endereço da célula (board[i][j])
    lw $t2, 0($s7)  # Carrega o valor da célula
            
    bne $t2, -2, fim_if # Se a célula não estiver oculta, continua
            
    move $a1, $s3  # Argumento para a função countAdjacentBombs
    move $a2, $s5  # Argumento para a função countAdjacentBombs
    jal countAdjacentBombs  # Chama a função para contar bombas adjacentes
    sw $v0, 0($s7)  # Atualiza o valor da célula (board[i][j]) com o resultado
            
    bnez $v0, fim_if  # Se x != 0, continua
            
    jal revealNeighboringCells  # Chama recursivamente a função para a célula vazia
            
    fim_if:
    addi $s5, $s5, 1  # Incrementa j
    j inicio_for_j  # Salta para o início do loop
    fim_for_j:

    addi $s3, $s3, 1  # Incrementa i
    j inicio_for_i  # Salta para o início do loop
    fim_for_i:
    
    restore_context
    jr $ra  # Retorna da chamada de função
