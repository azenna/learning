.eqv SysPrintInt 1
.eqv SysPrintString 4
.eqv SysReadInt 5
.eqv SysExit 10

.data
prompt:
  .asciiz "Enter an Integer: " # Prompt to get integer from user
sum:
  .asciiz "The sum is: " # Output prefix for sum once user is finished entering numbers
count:
  .asciiz "\nThe number of integers entered was: " # Ouptut prefix for number of integers
                                                   # entered. needs a newline as it
                                                   # directly follows other program output

.text
main:  # start of program
  li $s0, 0 # initialize $s0 register to 0 for running total
  li $s1, -1 # intialize $s1 register to -1 for count of integers entered
             # we don't want the terminating zero to be in count so we're subtracting
             # early to simplify logic
prompt_loop:
  li $v0, SysPrintString # Load print string syscall
  la $a0, prompt # Load the address of the prompt into $a0.
  syscall # Print prompt for user integer

  li $v0, SysReadInt # Load read int syscall
  syscall # Read int is in $v0 register

  add $s0, $s0, $v0 # Add the read int to the running total
  addi $s1, $s1, 1 # Add 1 to count of integers entered

  bnez $v0, prompt_loop # If the user entered a non zero number loop
                        # otherwise fall through

  li $v0, SysPrintString # Load print string syscall
  la $a0, sum # Load address of sum string
  syscall # Output sum string

  li $v0, SysPrintInt # Load print int syscall
  move $a0, $s0 # Move sum into argument register $a0
  syscall # Output sum

  li $v0, SysPrintString # Load print string syscall
  la $a0, count # Load address of count string
  syscall # Output count string

  li $v0, SysPrintInt # Load print int syscall
  move $a0, $s1 # Move count into argument register $a0
  syscall # Output count

  li $v0, SysExit  # Load sys exit instruction
  syscall # Exit gracefully
