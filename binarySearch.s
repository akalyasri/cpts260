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
    prompt_msg: .asciiz "Enter 10 integers in ascending order: "
    target_msg: .asciiz "Enter your target integer: "
    error_msg: .asciiz "Error. Need to enter integers in ascending order. \n\n"

    array: .space 40 # 40 each integer is 4 bits

.text
    .globl main

        main:

            #display prompt
            li $v0, 4
            la $a0, prompt_msg
            syscall

            # t0 is counter (i)
            # t1 is length 10
            # t2 is the current index
            # t3 is mid
            # t4 is high
            # t5 is low
            # t6 is the target


            # get 10 integers from user


            # check if the 10 given integers are in ascending order


            # get target value from user
            li $v0, 4
            la $a0, target_msg
            syscall

            li $v0, 5
            syscall
            move $t6, $v0   # t6 is the target

            # perform binary search for given target

            


            # display if target was hit and if so, what index it was found at



        getArrayInput:
            li $v0, 5



        exit:

            #exit
            li $v0, 10
            syscall
            


