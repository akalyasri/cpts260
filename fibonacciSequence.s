#+---------------+--------------+-----------------------+---------------------------------------------------+---------------------------------------+
#| Syscall Number| Syscall Name | Input Argument Number| Description                                       | Output                                |
#+---------------+--------------+-----------------------+---------------------------------------------------+---------------------------------------+
#| 1             | print_int    | $a0 (4)               | Print the integer value stored in $a0.           | Integer value in $a0 is printed.     |
#| 4             | print_str    | $a0 (4)               | Print the null-terminated string at $a0 address. | The string in memory at $a0 is printed. |
#| 5             | read_int     | $v0 (2)               | Read an integer from standard input to $v0.      | The read integer is stored in $v0.    |
#| 8             | read_str     | $a0 (4)               | Read a null-terminated string from input to $a0. | The read string is stored in $a0.    |
#| 10            | exit         | $v0 (2)               | Terminate the program with exit code in $v0.     | Program execution ends with the specified exit code. |
#+---------------+--------------+-----------------------+---------------------------------------------------+---------------------------------------+

#   steps:
#   display prompt 
#   get user input n
#   check if n is non negative
#   compute fib sequence up to n
#   calculate fib num for n
#   display result

.data

    prompt_msg: .asciiz "Enter a non-negative integer: "
    final_msg: .asciiz "Fibonacci number for input: "


.text
#.global main

    main: 

        # printing the prompt_msg to screen
        li $v0, 4               # syscall 4 for print string
        la $a0, prompt_msg      # load argument for the syscall la -> load address 
        syscall
    
        # read integer from user
        li $v0, 5               # syscall 5 used for read int
        syscall
        move $t0, $v0
        

        # check if n is non negative
        bgez $t0, correctInput
        j exit

    correctInput:

        beq $t0, $zero, exit
        beq $t0, 1, exit 

        # t0 is the result
        # t1 is n
        # t2 is PprevFbn
        # t3 is prevFbn
        # t4 is counter (i)

        # 0, 1 , 0+1, 1+1, 1+2, 2+3, 3+5, 5+8
        # PprevFbn(previous previous fib num) + prevFbn
        # PprevFbn = 0;
        # prevFbn = 1;
        # for(int i = 2; i<n; i++){
        #   tempFbn = prevFbn;
        #   prevFbn = PprevFbn + prevFbn;
        #   PprevFbn = tempFbn;
        # }

    loop: 


    exit: 

        #print message
        li $v0, 4
        la $a0, final_msg 
        syscall
        
        #print result
        li $v0, 1
        move $a0, $t0
        syscall

        #exit
        li $v0, 10
        syscall

        
