         .eqv      double_word 8
         .eqv      word        4
         .data
prompt:  .asciiz   "Enter a double precision number: "

         .text
# REGISTERS
# $fp - end of stack
# $s0 - address of doubles
# $s1 - length  of doubles
# STACK
# (8n - 1):0 - doubles
main:
         move      $sp, $fp              # store the initial stack ptr for deallocation
         li        $s1, 0                # initialize the length of the entered doubles
prompt_step:
         li        $v0, SysPrintString   # prompt the user for a double precision number
         la        $a0, prompt
         syscall

         li        $v0, SysReadDouble    # read in the entered double it's at $f0$f1
         syscall

         mtc1      $zero, $f2            # zero the f2 double
         mtc1      $zero, $f3
         c.eq.d    $f0, $f2              # check if the entered double is zero

         bc1t      sort                  # if it's zero go to sorting

         subi      $sp, $sp, double_word # allocate a double word on the stack
         sdc1      $f0, ($sp)            # store the double on the stack
         addi      $s1, $s1, 1           # increment number of doubles in array

         j         prompt_step           # continue prompting the user for doubles
sort:
         move      $s0, $sp              # store the address of the entered doubles

         move      $a0, $s0              # move the address of array to a0
         move      $a1, $s1              # move the length of the array to a0
         jal       selection_sort        # call selection_sort on the array of doubles

         move      $a0, $s0              # move the address of array to a0
         move      $a1, $s1              # move the length of the array to a0
         jal       print_doubles         # print out the sorted doubles

exit:
         move      $sp, $fp              # deallocate the stack
         li        $v0, SysExit          # exit the program
         syscall

# Subroutine to use selection sort on an array of doubles
# REGISTERS
# a0 - address of doubles
# a1 - length of  array
# fp - initail stack ptr for estoration
# t0 - mutable ptr to double array for outer loop
# t1 - mutable prt to double array for inner loop
# t4 - current ptr to minimum double for iteration
# t2 - current index for outer loop
# t3 - current index for inner loop
# f0 - current outer double
# f2 - current inner loop float
# f4 - current minimum double
selection_sort:
         move      $t0, $a0                # move address of array into t0 for mutation
         li        $t2, 0                  # initialize the current index for outer loop
ss_outer:
         beq       $t2, $a1, ss_exit       # if current index is length of array we're done sorting

         ldc1      $f0, ($t0)              # load current outer double into $f0$f1

         move      $t4, $t0                # store current minimum ptr for iteration in t4
         mov.d     $f4, $f0                # store current minimum double

         addi      $t1, $t0, double_word   # set inner mutable array ptr to point to next double in array
         addi      $t3, $t2, 1             # set inner index to outer index + 1 (next double in array)
ss_inner:
         beq       $t3, $a1, ss_outer_end  # if the inner index is equal to length of array we're done with inner loop
         ldc1      $f2, ($t1)              # load current inner double into  $f2$f3

         c.lt.d    $f2, $f4                # compare the two floats to see if f2 is less than f0
         bc1f      ss_inner_end            # if f2 is not less than f0 move to next double

         mov.d     $f4, $f2                # set the minimum double to the new smallest double
         move      $t4, $t1                # set minimum ptr to the new smallest number
ss_inner_end:
         addi      $t1, $t1, double_word   # increment innder ptr to next double
         addi      $t3, $t3, 1             # increment inner index
         j         ss_inner                # keep on loopin
ss_outer_end:
         sdc1      $f4, ($t0)              # store minimum double in current array pos
         sdc1      $f0, ($t4)              # store old double in the old minimum pos

         addi      $t0, $t0, double_word   # increment the outer ptr by a double
         addi      $t2, $t2, 1             # increment the outer index

         j         ss_outer                # keep on loopin
ss_exit:
         jr        $ra                     # return to caller


# Subroutine to print an array of doubles
# REGISTERS
# a0 - address of doubles
# a1 - length of array
# t0 - current address in array
# f0 - sum of doubles
# STACK
         .eqv      return_ad  4
         .eqv      arr_len    0
         .eqv      stack_size 8
         .data
count:   .asciiz   "Count: "
sum:     .asciiz   "Sum: "
average: .asciiz   "Average: "
         .text
print_doubles:
         subi      $sp, $sp, stack_size  # allocate the stack
         sw        $ra, return_ad($sp)   # store the return address
         sw        $a1, arr_len($sp)     # store the array len

         move      $t0, $a0              # initialize t0 at start of array
         move      $t1, $a1              # initialize t1 as length of array

         mtc1      $zero, $f0            # initialize $f0$f1 to hold double sum of array
         mtc1      $zero, $f1

pd_loop:
         beqz      $t1, pd_exit          # if t1 tells us there are no more values go to exit
         ldc1      $f12, ($t0)           # load current double into printing reg

         add.d     $f0, $f0, $f12        # add double to sum

         li        $v0, SysPrintDouble   # print out the double
         syscall

         li        $v0, SysPrintChar     # print a newline
         li        $a0, '\n'
         syscall

         addi      $t0, $t0, double_word # move double ptr to next double
         subi      $t1, $t1, 1           # decrement length
         j         pd_loop               # repeat
pd_exit:
         lwc1      $f2, arr_len($sp)     # move length of array to 12
         cvt.d.w   $f2, $f2              # convert length of array to double

         mov.d     $f12, $f2             # put count in double arg register
         la        $a0, count            # print out the count
         jal       print_statistic       # print the statistic

         mov.d     $f12, $f0             # put sum in double arg register
         la        $a0, sum              # print out the sum
         jal       print_statistic       # print the statistic

         div.d     $f12, $f0, $f2        # divide the sum by the count to get the average
         la        $a0, average          # print average
         jal       print_statistic       # print the statistic

         lw        $ra, return_ad($sp)   # restore the return address
         subi      $sp, $sp, stack_size  # deallocate the stack
         jr        $ra                   # return to caller

# REGISTERS
# a0 - address of label
# f12 - statistic
print_statistic:
         li        $v0, SysPrintString # print out the label
         syscall

         li        $v0, SysPrintDouble # print out the statistic
         syscall

         li        $v0, SysPrintChar   # print a newline
         li        $a0, '\n'
         syscall

         jr $ra
