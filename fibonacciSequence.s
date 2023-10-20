#+---------------+--------------+-----------------------+---------------------------------------------------+---------------------------------------+
#| Syscall Number| Syscall Name | Input Argument Number| Description                                       | Output                                |
#+---------------+--------------+-----------------------+---------------------------------------------------+---------------------------------------+
#| 1             | print_int    | $a0 (4)               | Print the integer value stored in $a0.           | Integer value in $a0 is printed.     |
#| 4             | print_str    | $a0 (4)               | Print the null-terminated string at $a0 address. | The string in memory at $a0 is printed. |
#| 5             | read_int     | $v0 (2)               | Read an integer from standard input to $v0.      | The read integer is stored in $v0.                   |
#| 8             | read_str     | $a0 (4)               | Read a null-terminated string from input to $a0. | The read string is stored in $a0.                    |
#| 10            | exit         | $v0 (2)               | Terminate the program with exit code in $v0.     | Program execution ends with the specified exit code. |
#+---------------+--------------+-----------------------+---------------------------------------------------+---------------------------------------+

#   steps:
#   display prompt 
#   get user input n
#   check if n is non negative
#   compute fib sequence up to n
#   calculate fib num for n
#   display result

# the simulator doesnt support this //gnu assembler does
#.equ result, $t0
#.equ syscall, $v0

.data

    prompt_msg: .asciiz "Enter a non-negative integer: "
    final_msg: .asciiz "Fibonacci number for input: "
    error_msg: .asciiz "Error. Only enter non negative number. \n\n"


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
        j crashExit

    correctInput:

        beq $t0, $zero, exit
        beq $t0, 1, exit 

        # t0 is n -> then the result
        # t1 is used as a conditional
        # t2 is PprevFbn
        # t3 is prevFbn
        # t4 is counter (i)
        # t5 is tempFBn

        # 0, 1 , 0+1, 1+1, 1+2, 2+3, 3+5, 5+8
        # PprevFbn(previous previous fib num) + prevFbn
        # PprevFbn = 0;
        # prevFbn = 1;
        # for(int i = 2; i<n; i++){
        #   tempFbn = prevFbn;
        #   prevFbn = PprevFbn + prevFbn;
        #   PprevFbn = tempFbn;
        # }

        addi $t2, $zero, 0      # set PprevFbn to 0
        addi $t3, $t3, 1        # set prevFbn to 1
        addi $t4, $zero, 0      # set counter to 0
        


    loop: 

        add $t5, $t3, $zero     #tempFbn = prevFbn;
        add $t3, $t2, $t3       #prevFbn = PprevFbn + prevFbn;
        add $t2, $t5, $zero     #PprevFbn = tempFbn;
        addi $t4, $t4, 1        #increment counter

        slt $t1, $t4, $t0       # checking if conter is less than n - if yes t1 will be set to 1, o.w set to 0
        bne $t1, $zero, loop    # start the loop again



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


    crashExit:

        #print error msg
        li $v0, 4
        la $a0, error_msg
        syscall

        j main

        #exit
        #li $v0, 10
        #syscall




        
