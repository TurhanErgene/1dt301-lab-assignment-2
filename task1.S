@
@ R0 - first parameter to printf
@ R1 - second parameter to printer
@ R7 - index counter
@

.thumb_func                 @ Necessary because sdk uses BLX
.global main                @ Provide program starting address to linker
.syntax unified
.thumb
.extern printf
.extern stdio_init_all

main:
   MOVS    R7, #100        @ initialize counter to 100
   BL  stdio_init_all      @ initialize uart or usb

loop:
   LDR R0, =helloworld     @ load address of helloworld string
   MOVS    R1, R7          @ Move the counter to second parameter = counter
   BL  printf              @ Call pico_printf
      
   SUBS    R7, R7, #1      @ decrement counter
   BNE loop
  
   MOVS R7, #100          /* reset back to 100 */
   B   loop                @ loop forever~~~
      
.data
          .align  4        @ necessary alignment
helloworld: .asciz   "Hello World %d\n"

