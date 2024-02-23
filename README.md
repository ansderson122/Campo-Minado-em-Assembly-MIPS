# Projeto Campo Minado em Assembly MIPS

## Visão Geral

Este projeto visa implementar uma versão do jogo Campo Minado em linguagem Assembly MIPS. Os arquivos do projeto estão organizados da seguinte maneira:

- **`main.asm`**: Contém a função principal (`main`) responsável por controlar o fluxo do jogo em Assembly MIPS.

- **`printboard.asm`**: Implementa a função para imprimir o estado atual do tabuleiro.

- **`initializeboard.asm`**: Contém a lógica para inicializar o tabuleiro no início do jogo.

- **`plantbombs.asm`**: Implementa a função para posicionar as bombas aleatoriamente no tabuleiro.

- **`macros.asm`**: Fornece macros úteis para facilitar o desenvolvimento em MIPS.

- **`Mars.jar`**: Arquivo executável do Mars MIPS, necessário para rodar os arquivos `.asm`.

- **`minesweeper.c`**: Contém a implementação em C do jogo Minesweeper. Este arquivo serve como referência para a lógica do jogo e pode ser utilizado para comparação com as implementações em Assembly MIPS.

- **`play.asm`**, **`checkvictory.asm`**, **`revealcells.asm`**: São arquivos em branco. Os alunos devem completar a implementação dessas funções em Assembly MIPS.

## Detalhes da implementação 

### Implementação do "for"

``` assembly
   # Configuração dos limites para a iteração
   subi $s4, $s1, 1  # i = row - 1
   addi $s5, $s1, 1  # row + 1

   inicio_for_i:
   bgt $s4, $s5, fim_for_i  # Se i > row + 1, encerra o loop

   # Corpo do loop ...

   # Atualiza o contador i
   addi $s4, $s4, 1  
   j inicio_for_i  # Salta para o início do loop
   fim_for_i:
```

### Para carrega dados da menoria 

``` assembly
   sll $t1, $s3, 5  # Deslocamento da linha 
   sll $t2, $s5, 2  # Deslocamento da coluna 
   add $t1, $t1, $t2  # Combina os deslocamentos
   add $s7, $t1, $s0  # Calcula o endereço da célula (board[i][j])
   lw $t2, 0($s7)  # Carrega o valor da célula
```

### Otimização
Em alguma partes do codigo as seguintes codição.
```c
   if (i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == algumNumero) {
     #codigo ...
   }
```
O que foi implementa da seguinte forma abaixo. Isso se as codições do 'i' for atendida então ele vai para o fim_for_j para chama o proximo 'i', mas as as codições do 'j' ele vai chama o proximo 'j'.
```assembly
   blt $s4, $zero, fim_for_j # se i < 0
   bge $s4, SIZE, fim_for_j  # Se i >= size
   blt $s6, $zero, fim_if
   bge $s6, SIZE, fim_if  # Se j >= size 
```

## Instruções de Compilação e Execução

Para compilar e executar o projeto, siga as instruções abaixo:

1. **Configuração do Ambiente**: Certifique-se de ter o ambiente de desenvolvimento Assembly MIPS configurado. Você pode usar o Mars MIPS para isso.

2. **Compilação e Execução**:
   - Abra o Mars4_5.jar que já esta nessa pasta.
   - Abra os arquivos `main.asm`.
   - Compile e execute os arquivos conforme necessário para testar diferentes partes do jogo.


## Autor 
Julyanderson Alves Cavalcanti de lima
* ansderson84001@gmail.com
* [Github](https://github.com/ansderson122)