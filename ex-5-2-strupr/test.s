  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:

  LDR   R4, =strA
  LDR   R5, =RamData

  @ Set R1 to the start address of the test string in RAM
  MOV   R1, R5

  @ Copy the test string from ROM to RAM
Loop:
  LDRB  R6, [R4], #1
  STRB  R6, [R5], #1
  CMP   R6, #0
  BNE   Loop
  BX    LR


  .section  .rodata

strA:
  .asciz  "Hello World!"


  .section  .data

RamData:
  .space  256

.end