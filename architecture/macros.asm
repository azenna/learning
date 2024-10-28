.text
         .macro   print_newline
         li       $v0, SysPrintChar
         li       $a0, '\n'
         .end_macro

         .macro    store %reg
         subi      $sp, $sp, 4
         sw        %reg, ($sp)
         .end_macro

         .macro    store %reg1 %reg2
         store(%reg1)
         store(%reg2)
         .end_macro

         .macro   store %reg1 %reg2 %reg3
         store(%reg1, %reg2)
         store(%reg3)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4
         store(%reg1, %reg2, %reg3)
         store(%reg4)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4 %reg5
         store(%reg1, %reg2, %reg3, %reg4)
         store(%reg5)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4 %reg5 %reg6
         store(%reg1, %reg2, %reg3, %reg4, %reg5)
         store(%reg6)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4 %reg5 %reg6 %reg7
         store(%reg1, %reg2, %reg3, %reg4, %reg5, %reg6)
         store(%reg7)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4 %reg5 %reg6 %reg7 %reg8
         store(%reg1, %reg2, %reg3, %reg4, %reg5, %reg6, %reg7)
         store(%reg8)
         .end_macro

         .macro    load %reg
         lw        %reg, ($sp)
         addi      $sp, 4
         .end_macro

         .eqv  SysPrintInt     1
         .eqv  SysPrintFloat   2
         .eqv  SysPrintDouble  3
         .eqv  SysPrintString  4
         .eqv  SysReadInt      5
         .eqv  SysReadFloat    6
         .eqv  SysReadDouble    7
         .eqv  SysReadString    8
         .eqv  SysAlloc        9
         .eqv  SysExit          10
         .eqv  SysPrintChar    11
         .eqv  SysReadChar      12
         .eqv  SysOpenFile      13
         .eqv  SysReadFile      14
         .eqv  SysWriteFile    15
         .eqv  SysCloseFile    16
         .eqv  SysExitValue    17

         .eqv   Word 4
         .eqv   DoubleWord 8

         .data
assert_failure:    .asciiz "assert_failure "
non_match:         .asciiz " does not match "

.text
         .macro   print_newline
         store($v0, $a0)
         li       $v0, SysPrintChar
         li       $a0, '\n'
         load($v0, $a0)
         .end_macro

         .macro    store %reg
         subi      $sp, $sp, 4
         sw        %reg, ($sp)
         .end_macro

         .macro    store %reg1 %reg2
         store(%reg1)
         store(%reg2)
         .end_macro

         .macro   store %reg1 %reg2 %reg3
         store(%reg1, %reg2)
         store(%reg3)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4
         store(%reg1, %reg2, %reg3)
         store(%reg4)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4 %reg5
         store(%reg1, %reg2, %reg3, %reg4)
         store(%reg5)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4 %reg5 %reg6
         store(%reg1, %reg2, %reg3, %reg4, %reg5)
         store(%reg6)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4 %reg5 %reg6 %reg7
         store(%reg1, %reg2, %reg3, %reg4, %reg5, %reg6)
         store(%reg7)
         .end_macro

         .macro    store %reg1 %reg2 %reg3 %reg4 %reg5 %reg6 %reg7 %reg8
         store(%reg1, %reg2, %reg3, %reg4, %reg5, %reg6, %reg7)
         store(%reg8)
         .end_macro

         .macro    load %reg
         lw        %reg, ($sp)
         addi      $sp, $sp, 4
         .end_macro

         .macro    load %reg2 %reg1
         load(%reg1)
         load(%reg2)
         .end_macro

         .macro   load %reg3 %reg2 %reg1
         load(%reg1, %reg2)
         load(%reg3)
         .end_macro

         .macro    load %reg4 %reg3 %reg2 %reg1
         load(%reg1, %reg2, %reg3)
         load(%reg4)
         .end_macro

         .macro    load %reg5 %reg4 %reg3 %reg2 %reg1
         load(%reg1, %reg2, %reg3, %reg4)
         load(%reg5)
         .end_macro

         .macro    load %reg6 %reg5 %reg4 %reg3 %reg2 %reg1
         load(%reg1, %reg2, %reg3, %reg4, %reg5)
         load(%reg6)
         .end_macro

         .macro    load %reg7 %reg6 %reg5 %reg4 %reg3 %reg2 %reg1
         load(%reg1, %reg2, %reg3, %reg4, %reg5, %reg6)
         load(%reg7)
         .end_macro

         .macro    load %reg8 %reg7 %reg6 %reg5 %reg4 %reg3 %reg2 %reg1
         load(%reg1, %reg2, %reg3, %reg4, %reg5, %reg6, %reg7)
         load(%reg8)
         .end_macro


         .macro    print_string_ln %str
         .data
s:       .asciiz   %str
         .text
         store($v0, $a0)
         li        $v0, SysPrintString
         la        $a0, s
         syscall
         load($v0, $a0)
         .end_macro

         .macro    print_cstr %ptr
         store($v0, $a0)
         li        $v0, SysPrintString
         la        $a0, $ptr
         syscall
         load($v0, $a0)
         .end_macro

         # assert_eq_regs ensures that two registers have an equal value or exits the program
         .macro    assert_eq_regs %reg1 %reg2
         .data
         regs:    "%reg1 %reg2\n"
         .text
         store($v0, $a0)

         subi    $at, $sp, 8   # ok basically any register could be used in assert
         sw      %reg1, 4($at)  # so we store their values on the stack for comparison
         sw      %reg2, ($at)
         move    $sp,   $at   #  then set stack ptr to at

         beq      %reg1, %reg2, aer_end

         li       $v0, SysPrintString
         la       $a0, assert_failure
         syscall

         la       $a0, regs
         syscall

         li       $v0, SysPrintInt
         lw       $a0, 4($sp)
         syscall

         li       $v0, SysPrintString
         la       $a0, non_match
         syscall

         li       $v0, SysPrintInt
         lw       $a0, ($sp)
         syscall

         print_newline()

         li        $v0, SysExit
         syscall
aer_end:
         lw        %reg1, 4($sp)
         lw        %reg2, ($sp)
         addi      $sp, $sp, 8 # dealloc our stack
         load ($v0, $a0)

         .end_macro

li $t0, 1
li $t2, 1
la $a0, assert_failure
li $v0, SysPrintString
print_newline()
assert_eq_regs($t0, $t2)
syscall
