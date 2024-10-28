         .eqv  SysPrintInt    1
         .eqv  SysPrintString 4
         .eqv  SysReadInt     5
         .eqv  SysAlloc       9
         .eqv  SysExit         10
         .eqv  SysPrintChar   11

         .data
prompt:  .asciiz "Enter a number between 3 and 160,000 to see if it is prime:"

         .text
# entry point for implementation
main:
         li        $v0, SysPrintString # prompt user for integer
         la        $a0, prompt         # load address for integer prompt
         syscall

# prompt the user for an integer and read as an Int
read_int_from_user:
         li        $v0, SysReadInt # read the integer
         syscall
         move      $s0, $v0        # store user number in s0

# ensure the users number is between 0, 160,000
validate_user_number:
         li        $t0, 3          # validate number
         blt       $s0, $t0, main  # if number is less than 3 restart program
         li        $t0, 160000
         bgt       $s0, $t0, main  # if number is greater than 160000 restart program

# round the users number to the nearest 8 so can be evenly divided by 8 to allocate n/8 bytes
round_user_number:
         addi      $s0, $s0, 7          # add number right before 8 to number
         andi      $s0, $s0, 0xFFFFFFF8 # clear small 3 bits 2^2 2^1 2^0 so is multiple of 8

# allocate n/8 bytes
allocate_n_div_8_bytes:
         sra       $s2, $s0, 3    # store n/8 # bytes to allocate in s2 and length of returned array
         move      $a0, $s2       # allocate n/8 bytes
         li        $v0, SysAlloc
         syscall
         move      $s1, $v0       # store the array ptr in s1

# take the newly allocated n/8 bytes and put 0xFF in each byte making an array of ones
ones_bytes:
         li        $t0, 0     # iteration counter
         li        $t1, 0xFF  # byte of ones
         move      $t2, $s1   # mutable array ptr

# loop over the bytes of the array
ones_bytes_loop:
         beq       $t0, $s2, sieve # if end of array has been reached terminate loop done onesing
         sb        $t1, ($t2)      # store ones byte at mutable array ptr
         addi      $t0, $t0, 1     # increment loop counter
         addi      $t2, $t2, 1     # increment mutable array ptr
         j         ones_bytes_loop # keep on looping

# start of the sieve
sieve:
         li        $t0, 2      # bit index we start at
         sra       $s0, $s0, 1 # divide s0 by 2 to get n/2 numbers to check before determined is prime

         move      $t4, $s1    # store s1 in t4 for mutabile array ptr

# find the next non zero bit at t0 or after
next_non_zero:
         sra       $t1, $t0, 3            # store number of bytes till index in t1 by dividing bit index by 8
         and       $t2, $t0, 7            # store remainder (last 3 bits) in t2

         add       $t4, $t4, $t1          # increment array ptr by t1 bytes
         lb        $t3, ($t4)             # load byte at array ptr
         srav      $t3, $t3, $t2          # shift loaded byte right by remainder bits
         andi      $t3, $t3, 1            # isolate the ones bit
         bnez      $t3, next_non_zero_end # if the bit is non_zero we've found our multiple
         add       $t0, $t0, 1            # increment bit index
         move      $t4, $s1               # reset the array ptr
         j         next_non_zero

# cleanup for non-zero make sure the next non-zero bit isn't out of scope
next_non_zero_end:
         bgt       $t0, $s0, sys_exit # if the next non_zero bit index is greater than n/2 we're done

# determine wheter a delimiter should be printed based on the value of current prime
maybe_print_comma:
         li        $t1, 2                # load two to test against
         beq       $t0, $t1, print_prime # if the found prime is equal to two skip the delimiter

         li        $v0, SysPrintChar     # load print char service to print ", "
         li        $a0, ','              # print ','
         syscall
         li        $a0, ' '              # print ' '
         syscall

# print out the found prime
print_prime:
         li        $v0, SysPrintInt  # print the found int
         move      $a0, $t0
         syscall

# pre loop setup to reset array ptr and setup mutable variables
setup_sieve_loop:
         move      $t1, $t0  # copy prime number into t1
         move      $t4, $s1  # restore the array ptr

# main sieve that determines what the next multiple of the prime is
# calculates it's byte and bit offset
# creates a bit mask based on the bit offset to apply to the byte
# and applys the bit mask to put a zero where the next multiple is
sieve_loop:
         add       $t1, $t1, $t0            # next bit index that needs to be updated

         sra       $t2, $t1, 3              # divide by 8 to get the byte offset and store in t2
         bge       $t2, $s2, sieve_loop_end # if the byte offset is out of bounds loop is done
         add       $t4, $t4, $t2            # increment the array ptr to that offset

         andi      $t2, $t1, 7              # use lower 3 bits as remainder and store bit offset in t2

                                            # calculate bit mask to use at byte offset
         li        $t3, 1                   # basis for bit mask
         sllv      $t2, $t3, $t2            # shift basis left by t2 remainder bits to get inverse bit mask
         nor       $t2, $t2, $zero          # invert the bit mask

         lb        $t3, ($t4)               # load the byte at the byte offset
         and       $t2, $t2, $t3            # apply the bit mask
         sb        $t2, ($t4)               # put the byte back into the array
         move      $t4, $s1                 # reset array prt
         j         sieve_loop

# cleanup from the sieve loop before moving to the next prime between the current and n/2
# increments the bit index to start looking for next non_zero bit and resets mutable array ptr
sieve_loop_end:
         addi      $t0, $t0 1     # increment bit index
         move      $t4, $s1       # reset array ptr
         j         next_non_zero  # repeat the sieve for the next non zero bit

# we're done!!!
sys_exit:
         li        $v0, SysExit # exit the program
         syscall
