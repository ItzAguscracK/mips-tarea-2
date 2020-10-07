.data
prompt: .asciiz "Ingrese un numero de factorial a calcular: " # String
space:  .asciiz "\n"        # Salto de linea

.text
.globl main
main:
## Se ingresa y lee el numero
li		      $v0, 4		        # syscall read string code
la		      $a0, prompt		    # Se carga prompt en a0
syscall                             # Se lee propmt
li          $v0, 5                  
syscall                             
move        $s0, $v0                # Se mueve $v0 a $s0
li		      $v0, 4		        
la		      $a0, space		    # Se lee el salto de linea
syscall                             # Se añade el salto de linea

# Caso 1 | 0
beq         $s0, 1, casof             # if number == 1 goto bye
beq         $s0, 0, casof            # if number == 1 goto bye

# Se le resta 1 al numero
addi		$a2, $s0, -1        # $a2 = $s0-- (number - 1)

# Salto a la funcion que calcula el factorial
jal         factorial              

## FTermina el programa
li		    $v0, 10		       
syscall

# Funcion que calcula el factorial y guarda datos en la PILA
factorial:
## Guardo $sp, $s0
addi        $sp, $sp, -8            # hago lugar en la pila
sw          $ra, 0($sp)             # push $ra
sw          $s0, 4($sp)             # push $s0 
j           loop                    # jump to loop

# Loop del factorial
loop:
beq		    $a2, $zero, exit       # if $a2 == 0 go to exit
mul         $s0, $s0, $a2          # number *=  number-1
addi		$a2, $a2, -1           # $a2 = $a2--
jal         loop                   # jump to loop again and save position to $ra

# Se imprime el resultado del factorial
exit:
li          $v0, 1               
move        $a0, $s0              
syscall

#Traigo y restauro datos de la PILA
lw          $ra, 0($sp)           # recupero el valor de $ra
lw          $s0, 4($sp)           # recupero el valor de $s0
addi        $sp, $sp, 8           # recupero el espacio utilizado en la pila

## Vuelvo a la instrccion despues del jail
jr          $ra

## Caso 1 | 0 - Se termina y finaliza el programa
casof:
li          $v0, 1            # syscall print int code
move        $a0, $s0          # move $s0 to $a0
syscall
li		      $v0, 10		        # syscall halt code
syscall
