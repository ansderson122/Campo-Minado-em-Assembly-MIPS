.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
    save_context
    move $s0, $a0  # $s0 = endereço base da matriz (board)
    move $s1, $a1  # $s1 = row
    move $s2, $a2  # $s2 = column

    li $s3, 0      # contador = 0

    subi $s4, $s1, 1  # i = row - 1
    addi $s5, $s1, 1  # row + 1

    inicio_for_i:
    bgt $s4, $s5, fim_for_i  # Se i > row + 1, encerra o loop

    subi $s6, $s2, 1  # j = column - 1
    addi $s7, $s2, 1  # column + 1

    inicio_for_j:
    bgt $s6, $s7, fim_for_j  # Se j > column + 1, encerra o loop

    # Verifica as condições para não ultrapassar os limites do tabuleiro
    blt $s4, $zero, fim_for_j
    bge $s4, SIZE, fim_for_j  # Se i >= size
    blt $s6, $zero, fim_if
    bge $s6, SIZE, fim_if  # Se j >= size 

    sll $t1, $s4, 5  # Deslocamento da linha 
    sll $t2, $s6, 2  # Deslocamento da coluna 
    add $t3, $t1, $t2  # Combina os deslocamentos
    add $t0, $t3, $s0  # Calcula o endereço da célula (board[i][j])

    lw $t1, 0($t0)  # Carrega o valor da célula

    bne $t1, -1 , fim_if  # Se a célula não contiver uma bomba, continua

    addi $s3, $s3, 1  # Incrementa o contador

    fim_if:
    addi $s6, $s6, 1  # Incrementa j
    j  inicio_for_j  # Salta para o início do loop
    fim_for_j:

   
    addi $s4, $s4, 1  # Incrementa i
    j inicio_for_i  # Salta para o início do loop
    fim_for_i:

    move $v0, $s3  # Retorna o resultado em $v0
    restore_context
    jr $ra  # Retorna da chamada de função
