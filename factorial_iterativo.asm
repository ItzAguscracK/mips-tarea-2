.data
prompt: .asciiz "Ingrese el numero del factorial a calcular: " # String
space:  .asciiz "\n"        # Salto de linea

.text
.globl main
main:

## Se ingresa y se lee el numero
li		   $v0, 4		        # syscall read string code
la		   $a0, prompt		    # cargar prompt en a0
syscall                             # se lee prompt
li         $v0, 5                  
syscall                             r
move       $t0, $v0                # Se mueve v0 a t0
li		   $v0, 4		        
la		   $a0, space		    # printf (salto de linea)
syscall                             

## CASO 1 | 0
beq        $t0, 1, casof            # if number == 1 goto bye
beq        $t0, 0, casof           # if number == 1 goto bye

## Le resto 1 al numero elegido
addi	   $t1, $t0, -1        # $t1 = $t0-- (number - 1)

## Salto a la funcion que calcula el factorial
jal        loop              

## Termina el programa
li		    $v0, 10		        
syscall                      

## FLoop que calcula el factorial
loop:
beq		    $t1, $zero, exit      #if $t1 == 0 go to exit
mul         $t0, $t0, $t1           # number *=  number-1
addi		$t1, $t1, -1        # $t1 = $t0-- (number - 1)
j           loop                    # jump to loop

#Se imprime el resultado del factorial
exit:
li          $v0, 1            
move        $a0, $t0          # Se mueve $t0 a $a0
syscall

## Se vuelve a la instruccion JAL
jr    $ra

## CASO 1 | 0 => Se imprime el resultado y finaliza el prgorama
casof:
li          $v0, 1                 
move        $a0, $t0               # Se mueve $t0 a $a0
syscall
li		      $v0, 10		       
syscall
