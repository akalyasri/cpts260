#+---------------+--------------+-----------------------+---------------------------------------------------+-----------------------------------------------------+
#| Syscall Number| Syscall Name | Input Argument Number| Description                                       | Output                                               |
#+---------------+--------------+-----------------------+---------------------------------------------------+-----------------------------------------------------+
#| 1             | print_int    | $a0 (4)               | Print the integer value stored in $a0.           | Integer value in $a0 is printed.                     |
#| 4             | print_str    | $a0 (4)               | Print the null-terminated string at $a0 address. | The string in memory at $a0 is printed.              |
#| 5             | read_int     | $v0 (2)               | Read an integer from standard input to $v0.      | The read integer is stored in $v0.                   |
#| 8             | read_str     | $a0 (4)               | Read a null-terminated string from input to $a0. | The read string is stored in $a0.                    |
#| 10            | exit         | $v0 (2)               | Terminate the program with exit code in $v0.     | Program execution ends with the specified exit code. |
#+---------------+--------------+-----------------------+---------------------------------------------------+-----------------------------------------------------+

#   steps:
#   display prompt 
#   get user to input 10 ascending numbers
#   check the inputed numbers are in ascending order
#   ask user to input 
#   check if number is in list
#   display result(and the index of the array)



.data
    prompt_msg: .asciiz "Enter 10 integers in ascending order: \n\n"
    input_msg: .asciiz "Enter an integer: " 
    target_msg: .asciiz "Enter your target integer: "
    error_msg: .asciiz "Error. Need to enter integers in ascending order. \n\n"
    found_msg: .asciiz "Found at index: "

    #array: .space 40    #each integer is 4 bytes
    array: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 

.text
    .globl main

        main:

            # display prompt
            li $v0, 4
            la $a0, prompt_msg
            syscall

            # t0 is counter (i)
            # t1 points to start of array 
            # t2 is the length
            # t3 is mid
            # t4 is high
            # t5 is low
            # t6 is target
            # t7 is temp 


          
            li $t0, 0           #t0 is the counter
            la $t1, array       #initializes starting address of array
            
        getUserInput:

            li $v0, 4
            la $a0, input_msg
            syscall             #display input prompt

            li $v0, 5
            syscall             #read integer

            sw $v0, 0($t1)      #storing integer in array
            
            addi $t0, $t0, 1    #icrement counter
            addi $t1, $t1, 4    #increment array pointer

            li $t2, 10          #set t2 as length 10

            beq $t0, $t2, getTarget
            j getUserInput

        getTarget:


            # get target value from user
            li $v0, 4
            la $a0, target_msg
            syscall

            li $v0, 5
            syscall
            move $t6, $v0   # t6 is the target

            li $t5, 0
            li $t4, 9
            li $t7, 0

        binarySearchLoop:

            # t0 is counter (i)
            # t1 points to start of array 
            # t2 is the length
            # t3 is mid
            # t4 is high
            # t5 is low
            # t6 is target
            # t7 is temp 

            

            add $t3, $t5, $t4       # mid = low + high
            srl $t3, $t3, 1         # mid = mid / 2

            
            sll $t7, $t3, 2         #getting offset
            lw $t7, array($t7)      #load mid element

            beq $t7, $t6, found        #if target = array[mid] , found 
            bge $t5, $t4, exit         #if low >= high, exit

            bgt $t7, $t6, searchHigh    #if array[mid] > target, search high
            j searchLow                 #else array[mid] < target, searchlow

        
        searchHigh:

            addi $t4, $t3, -1
            j binarySearchLoop

        searchLow: 
            
            addi $t5, $t3, 1
            j binarySearchLoop 

            
        found:

            li $v0, 4
            la $a0, found_msg
            syscall

            li $v0, 1
            #addi $t3, $t3, -3
            move $a0, $t3
            syscall



        exit:

            #exit
            li $v0, 10
            syscall
            

