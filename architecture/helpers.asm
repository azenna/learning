         .data
# test string
test_string:
         .asciiz "3A4MAN aplan a canal panam4a3"
test_space: .space 30
         .text

# these are tests to make sure each of the components is working correctly
test:
         li        $a0, 'a'               # is alphanumeric tests
         jal       test_is_alpha_numeric

         li        $a0, '-'
         jal       test_is_alpha_numeric


         la        $a0, test_string       # load address of the test string
         jal       filter_alphanum        # run filter_alphanum

         la        $a0, test_string       # load address of filtered string
         li        $v0, SysPrintString    # print out the filtered string
         syscall
         jal       print_newline

         la        $a0, test_string       # load address of filtered string
         jal       to_upper               # run to_upper on the filtered string

         la        $a0, test_string       # load address of filtered to upper string
         li        $v0, SysPrintString    # print out to uppered filter string
         syscall
         jal       print_newline

         la        $a0, test_string       # test strlen subroutine, load the test_string
         jal       strlen                 # call the subroutine

         move      $a0, $v0               # print resulting strlen
         li        $v0, SysPrintInt
         syscall
         jal       print_newline

         la        $a0, test_string
         la        $a1, test_space
         jal       strcpy

         la        $a0, test_space
         li        $v0, SysPrintString
         syscall
         jal       print_newline

         la        $a0, test_string      # test is_palindrome subroutine with the test string
         jal       is_palindrome

         move      $a0, $v0              # print the resulting boolean
         li        $v0, SysPrintInt
         syscall
         jal       print_newline



         li        $v0, SysExit
         syscall

# helper subroutine to print a newline
print_newline:
         li        $a0, '\n'
         li        $v0, SysPrintChar
         syscall
         jr        $ra


# helper subroutine for boolean identification of characters
# REGISTERS
# a0 - char paramater
# a0 - ascii start of range
# a2 - ascii end of range
# t0 - flag to determine if char is after start of range
# v0 - boolean result
helper_char_id:
         addi      $a2, $a2, 1     # add one to end of range to make it inclusive
         slt       $v0, $a0, $a2   # set v0 to one if char is before end of range
         slt       $t0, $a0, $a1   # set t0 t0 one if char is before start of range
         nor       $t0, $t0, $zero # invert the t0 flag to now represent a0 >= a1
         andi      $t0, $t0, 1      # get just the low bit
         and       $v0, $v0, $t0   # determine that a0 >= start of range && a0 < end of range + 1
         jr        $ra             # back to the caller

# subroutine to determine if a charater is alphanumeric
# REGISTERS
# a0 - char paramater
# v0 - boolean result
# STACK
# 8 - return address
# 4 - char from a0
# 0 - boolean or aggregate
is_alpha_numeric:
         subi      $sp, $sp, 12   # allocate a three word stack frame
         sw        $ra, 8($sp)    # store the return address on the stack
         sw        $a0, 4($sp)    # store the character as is modified in helper_char_id

         li        $a1, 'a'       # lower bound for checking if char is lower alpha
         li        $a2, 'z'       # upper bound
         jal       helper_char_id # check if char is within 'a'-'z'
         sw        $v0, ($sp)     # store result on stack

         lw        $a0, 4($sp)     # restore char from stack
         li        $a1, 'A'       # lower bound for checking if char is upper alpha
         li        $a2, 'Z'       # upper bound
         jal       helper_char_id # check if char is within 'A'-'Z'

         lw        $t0, ($sp)     # load aggregate from stack
         or        $t0, $t0, $v0   # aggregate boolean is now is_char 'a'-'z' || is_char 'A'-'Z'
         sw        $t0, ($sp)      # store aggregate back on stack

         lw        $a0, 4($sp)    # restore char from stack
         li        $a1, '0'       # lower bound for checking if char is digit
         li        $a2, '9'       # upper bound
         jal       helper_char_id # check if char is within '0'-'9'

         lw        $t0, ($sp)     # load aggregate from stack
         or        $v0, $v0, $t0  # last step so or result with aggregate to get v0 = lower || upper || digit


         lw        $ra, 8($sp)    # load the return address from the stack
         addi      $sp, $sp, 12   # deallocate stack space
         jr        $ra            # back to the caller

# test for is_alpha_numeric prints out the result of is_alpha_numeric for set value of a0
# REGISTERS
# a0 - paramater char
test_is_alpha_numeric:
         subi      $sp, $sp, 4      # allocate space on the stack for $ra
         sw        $ra, ($sp)       # store $ra

         li         $v0, SysPrintChar # print out the passed char
         syscall

         jal       is_alpha_numeric # run the is_alpha_numeric routine

         move      $a0, $v0         # move result to argument register for SysPrintInt
         li        $v0, SysPrintInt # print the result of is_alpha_numeric for char
         syscall

         jal       print_newline

         lw        $ra, ($sp)       # restore return address
         addi      $sp, $sp, 4      # pop the stack
         jr        $ra              # return

# subroutine to filter a string to only have alphanumeric characters
# REGISTERS
# a0 - paramter: address of the string paramater
# t1 - traversal string byte ptr
# t2 - current byte in string
# t3 - write string byte ptr
# t4 - current byte at traversal ptr
# STACK
# 16 - ra
# 12 - t1
# 8 - t2
# 4 - t3
# 0 - t4
filter_alphanum:
         subi      $sp, $sp, 20            # allocate a one word stack frame
         sw        $ra, 16($sp)            # store the return in the second word

         move      $t1, $a0                # setup traversal string ptr
         move      $t3, $a0                # setup write string ptr
fa_loop:
         lb        $t4, ($t1)              # current byte in string
         beqz      $t4, fa_loop_end        # we're done once a nullbyte is encountered

         move      $a0, $t4                # move current byte into a0 for subroutine

         sw        $t1, 12($sp)            # store temporary registers on stack before subroutine call
         sw        $t2, 8($sp)
         sw        $t3, 4($sp)
         sw        $t4, ($sp)

         jal       is_alpha_numeric        # check if current byte is alpha numeric

         lw        $t1, 12($sp)            # restore temporary registers ffrom stack
         lw        $t2, 8($sp)
         lw        $t3, 4($sp)
         lw        $t4, ($sp)

         bnez      $v0, fa_is_alphanumeric # if current byte is alphanumeric continue to next loop iteration

         addi      $t1, $t1, 1             # increment the traversal ptr but leave write ptr a current non alpha byte
         j         fa_loop                 # continue to next iteration to ignore current byte
fa_is_alphanumeric:
         sb        $t4, ($t3)              # store current byte at write ptr
         addi      $t1, $t1, 1             # increment the traversal ptr
         addi      $t3, $t3, 1             # increment the write ptr
         j         fa_loop                 # continue the loop
fa_loop_end:
         sb        $t4, ($t3)              # write the nullbyte to the end of filtered string
         lw        $ra, 16($sp)            # get return address from stack
         addi      $sp, $sp, 20            # pop the stack frame
         jr        $ra                     # back to caller


# subroutine to turn a string of chars into uppercase chars
# REGISTERS
# a0 - paramater with address of string
# t0 - current byte
# Stack
# 8 - $ra
# 4 - $a0
# 0 - $t0
to_upper:
         sub       $sp, $sp, 12       # allocate three words on the stack
         sw        $ra, 8($sp)        # store return address on the stack
tu_loop:
         lb        $t0, ($a0)         # load current byte in array into t0
         beqz      $t0, tu_loop_end   # if it's a null byte done with subroutine

         sw        $a0, 4($sp)        # store local variables on the stack
         sw        $t0, ($sp)

         move      $a0, $t0           # setup arguments for subroutine, char to check
         li        $a1, 'a'           # lower bound for checking if char is lower alpha
         li        $a2, 'z'           # upper bound
         jal       helper_char_id     # check if char is within 'a'-'z'

         lw        $a0, 4($sp)        # re store local variables from the stack
         lw        $t0, ($sp)

         beqz      $v0, tu_isnt_lower # if the boolean result is 0 continue the loop

         subi      $t0, $t0, 'a'      # upper case the current byte
         addi      $t0, $t0, 'A'

         sb        $t0, ($a0)         # store the uppercased byte back into the array
tu_isnt_lower:
         addi      $a0, $a0, 1        # increment the array ptr
         j         tu_loop            # continue looping
tu_loop_end:
         lw        $ra, 8($sp)        # restore the return address
         addi      $sp, $sp, 12       # pop the stack frame
         jr        $ra                # back to caller

# subroutine to find the length of a string
# REGISTERS
# a0 - address of string
# t0 - current byte in string
# v0 - len of string
         .globl strlen
strlen:
         li        $v0, 0                # initialize accumulator variable at 0
strlen_loop:
         lb        $t0, ($a0)            # load current byte in string
         beqz      $t0, strlen_loop_end  # if it's null we're done
         addi      $v0, $v0, 1           # increment length counter
         addi      $a0, $a0, 1           # increment string ptr
         j         strlen_loop
strlen_loop_end:
         jr        $ra                   # back to caller


# subroutine to copy a string from a0 to a1
# REGISTERS
# a0 - src address
# a1 - dest address
strcpy:
         lb        $t0, ($a0)      # load current byte in a0
         sb        $t0, ($a1)      # store byte in a1
         beqz      $t0, strcpy_end # if it's a null byte we're done
         addi      $a0, $a0, 1     # increment a0 address
         addi      $a1, $a1, 1     # increment a1 address
         j         strcpy          # continue copy ing
strcpy_end:
         jr        $ra             # return to caller


# subroutine to determine if a string is a palindrome
# REGISTERS
# a0 - paramater: address of string
# t0 - word aligned length of str
# t1 - length of string
# t2 - pointer to beginning of string
# t3 - pointer to end of the string
# t4 - byte at beginning of string
# t5 - byte at end of string
# STACK
# t0 + 8  - $ra
# t0 + 4  - $a0
# t0:8    - copied string space
# 4       - t0
# 0       - t1
is_palindrome:

         subi      $sp, $sp, 8                   # allocate one word for the the return address
         sw        $ra, 4($sp)                   # store the return address
         sw        $a0, ($sp)                      # store the paramater string address on the stack

         jal       strlen                        # calculate the string length, v0 has strlen
         move      $t1, $v0                      # move string length into t1

         lw        $a0, ($sp)                      # restore the string ptr

         addi      $t0, $t1, 4                   # round v0 up to nearest word boundary store in t0 4 instead of 3 bc theres' one for the nullbyte
         andi      $t0, $t0, 0xFFFFFFFC          # drop the two low bits to finish rounding

         sub       $sp, $sp, $t0                 # allocate t0 bytes on stack

         subi      $sp, $sp, 8                   # allocate another two words on stack for
         sw        $t0, 4($sp)                   # t0, size of dynamic stack space
         sw        $t1, ($sp)                    # t1, length of string

         slti      $t1, $t1, 2                   # base case if strlen < 2 the string is a pallindrome
         bnez      $t1, is_palindrome_true       # return true

         move      $a1, $sp                      # call strcpy with a0 as src and beginning of t0 bytes as dest
         addi      $a1, $a1, 8                   # increment dest address by 4 so pointing to space allocated for string
         jal       strcpy

         lw        $t1, ($sp)                    # restore the length of the string from the stack

         addi      $t2, $sp, 8                   # pointer to the beginning of the string


         add       $t3, $t2, $t1                 # pointer to the end of the string
         subi      $t3, $t3, 1                   # pointer to the last byte in the string

         lb        $t4, ($t2)                    # get the byte at the beginning of the string
         lb        $t5, ($t3)                    # get the byte at the end of the string

         bne       $t4, $t5, is_palindrome_false # if they are not equal string is not a pallindrome

         addi      $t2, $t2, 1                   # increment t2 so it's pointing at the second byte
         sb        $zero, ($t3)                  # put a null byte at the end so the string is shortened by 1

         move      $a0, $t2                       # put the ptr to the shortened string on our stack into a0
         jal       is_palindrome                  # call is palindrome to figure out if the rest of the string is a pallindrome
is_palindrome_cleanup:
         lw        $t0, 4($sp)                    # get word aligned length of string from stack

         addi      $sp, $sp, 8                    # pop stlen and word aligned strlen from stack
         add       $sp, $sp, $t0                  # pop bytes allocated for string from stack

         lw        $ra, 4($sp)                     # get return address from stack
         addi      $sp, $sp, 8                     # pop return address and a0 paramater off stack

         jr        $ra                            # return to caller

is_palindrome_true:
         li        $v0, 1
         j         is_palindrome_cleanup
is_palindrome_false:
         li        $v0, 0
         j         is_palindrome_cleanup

# this is a helper subroutine that takes a string on a0 removes non alpanumeric characters
# determines if it is a palindrome
# REGISTERS
# a0 - address of string
# v0 - returned is_palindrome_boolean
         .globl    string_clean_and_palindrome
string_clean_and_palindrome:
         subi      $sp, $sp, 8           # allocate two word on the stack
         sw        $ra, 4($sp)      # store the return address in the first
         sw        $a0, ($sp)       # address paramater in the second

         jal       filter_alphanum   # call filter_alphanum on string

         lw        $a0, ($sp)        # restore the string address
         jal       to_upper          # call to_upper on the string

         lw        $a0, ($sp)        # restore the string address
         jal       is_palindrome     # call is_palindrome on the filtered to upper string

         lw        $ra, 4($sp)      # restore the return address
         addi      $sp, $sp, 8           # pop the stack frame
         jr        $ra              # return
