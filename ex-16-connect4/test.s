  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Main
  .global Init_Test
  .global board

  .section  .text


Main:
  STMFD   SP!, {LR}

  LDR     R0, =board
  LDR     R1, =2
  LDR     R2, =2
  BL      isWinning

End_Main:
  LDMFD   SP!, {PC}


  .type     Init_Test, %function
Init_Test:
  PUSH    {LR}
  BL      InitRam
  POP     {PC}


@
@ Utility subroutine to initialise RAM from ROM
@
InitRam:

  STMFD   SP!, {R4-R7,LR}
  
  LDR   R4, =init_start    @ start address of initialisation data
  LDR   R5, =init_end      @ end address of initialisation data
  LDR   R6, =data_start    @ start oddress of RAM data

whInit:
  CMP   R4, R5            @ copy word-by-word from init_start
  BHS   ewhInit           @   to init_end in ROM, storing in RAM
  LDR   R7, [R4], #4      @   starting at data_start
  STR   R7, [R6], #4      @
  B     whInit            @
ewhInit:                  @

  LDMFD SP!, {R4-R7,PC}   @ return


  .section  .rodata

init_start:
init_board:
  .byte  1, 2, 2, 1, 1, 0, 0
  .byte  0, 1, 2, 2, 2, 0, 0
  .byte  0, 0, 1, 2, 0, 0, 0
  .byte  0, 0, 0, 1, 0, 0, 0
  .byte  0, 0, 0, 0, 0, 0, 0
  .byte  0, 0, 0, 0, 0, 0, 0
  .equ   size_board, .-init_board
init_end:


  .section  .data
data_start:

board:
  .space  size_board    @ enough space for the initial board contents above

.end
