.include "macros.asm"

.globl play

play:
    save_context
    move $s0, $a0  # $s0 = endereço base da matriz (board)
    move $s1, $a1  # $s1 = row
    move $s2, $a2  # $s2 = column
    
    sll $t0, $s1, 5  # Deslocamento da linha 
    sll $t1, $s2, 2  # Deslocamento da coluna 
    add $t2, $t0, $t1  # Combina os deslocamentos para obter o índice na matriz
    add $s4, $t2, $s0  # Calcula o endereço da célula (board[row][column])
    
    lw $s3, 0($s4)  # Carrega o valor da célula
    
    bne $s3, -1, fim_primeiro_if  # Se a célula contém uma bomba, encerra o jogo
    li $v0, 0  # Retorna 0 para indicar que o jogador acertou uma bomba
    restore_context
    jr $ra
    fim_primeiro_if:
    
    bne $s3, -2, fim_segundo_if  # Se a célula já foi revelada, continua o jogo
    jal countAdjacentBombs  # Chama a função para contar bombas adjacentes
    sw $v0, 0($s4)  # Atualiza a célula com o resultado
    
    
    bnez $v0,fim_segundo_if  # Se não há bombas adjacentes, revela células vizinhas
    jal revealNeighboringCells  # Chama a função para revelar células vizinhas
    
    fim_segundo_if:
    li $v0, 1  # Retorna 1 para indicar que o jogo continua
    restore_context
    jr $ra
        
