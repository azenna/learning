         .data
buffer:  .space    200
prompt:  .asciiz   "What string would you like to check for palindromeness? " # user prompt
not_palindrome_prompt:
         .asciiz   "Not a "
palindrome_prompt:
         .asciiz   "palindrome!\n"


         .text
         .globl main
main:
         la        $a0, prompt                 # load address of user prompt
         li        $v0, SysPrintString         # print out the prompt
         syscall

         la        $a0, buffer                 # load address of buffer to read into
         li        $a1, 200                    # max 200 bytes allowed to user
         li        $v0, SysReadString          # read the string
         syscall

         li        $t1, '\n'                   # newline holder for comparsion
         lb        $t0, ($a0)                  # first byte from buffer
         beq       $t1, $t0, exit              # exit if first byte is newline

         la        $a0, buffer                 # load address of buffer into a0
         jal       strlen                      # get the length of the string in the buffer

         add       $t0, $a0, $v0               # add the length of the string to the address of the buffer to get to the end
         sub       $t0, $t0, 1                 # subtract one so t0 is pointing at the newline characte
         sb        $zero, ($t0)                # zero it

         la        $a0, buffer
         jal       string_clean_and_palindrome # process the user input and output if it's a palindrome!

         bnez     $v0, palindrome              # if boolean v0 is a one skip to palindrome
         la       $a0, not_palindrome_prompt   # otherwise prefix palindrome output with "Not a!"
         li       $v0, SysPrintString
         syscall
palindrome:
         la       $a0, palindrome_prompt       # print out palindrome!!
         li       $v0, SysPrintString
         syscall
         j        main                         # repeat!
exit:
        li        $v0, SysExit                 # we're outta here
        syscall
