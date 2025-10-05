.syntax unified
.thumb
.text

.global main
.type   main, %function
.thumb_func

.EQU LED_PIN_1, 0
.EQU LED_PIN_2, 1
.EQU LED_PIN_3, 2
.EQU GPIO_OUT, 1
.EQU sleep_time, 1000

main:
  movs r0, #LED_PIN_1
  bl  gpio_init
  movs r0, #LED_PIN_1
  movs r1, #GPIO_OUT
  bl  link_gpio_set_dir

  movs r0, #LED_PIN_2
  bl  gpio_init
  movs r0, #LED_PIN_2
  movs r1, #GPIO_OUT
  bl  link_gpio_set_dir

  movs r0, #LED_PIN_3
  bl  gpio_init
  movs r0, #LED_PIN_3
  movs r1, #GPIO_OUT
  bl  link_gpio_set_dir

  movs r4,  #0            @ counter
  movs r5,  #0            @ direction, 0 = up, 1 = down

loop:
  movs r0, #LED_PIN_1
  movs r1, r4             
  movs r2, #1
  ands r1, r1, r2           @ keep only the lowest bit, 001 & 101 = 001
  bl  link_gpio_put

  movs r0, #LED_PIN_2
  movs r1, r4
  lsrs r1, r1, #1
  movs r2, #1
  ands r1, r1, r2           @ shift right 1 → check bit1, then mask with 1
  bl  link_gpio_put

  movs r0, #LED_PIN_3
  movs r1, r4
  lsrs r1, r1, #2
  movs r2, #1
  ands r1, r1, r2           @ shift right 2 → check bit2, then mask with 1
  bl  link_gpio_put

  ldr r0, =sleep_time
  bl sleep_ms

  cmp r5, #0              @ check the direction
  bne down_path           @ if r5 != 0, branch to down_path. Branch if not equal

up_path:
  adds r4, r4, #1
  cmp r4, #7
  bne loop
   movs r5, #1             @ flip direction to down
  b loop

down_path:
  subs r4, r4, #1
  cmp r4, #0
  bne loop

  movs r5, #0             @ flip direction to up
  b loop



