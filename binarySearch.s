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
    error_msg: .asciiz "Error. Need to enter integers in ascending order. \n\n"

.text
#.global main

    main:

        #display prompt
        li $v0, 4
        la $a0, prompt_msg
        syscall


