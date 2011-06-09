.nolist
#define EQU .equ 
#include "ti83asm.inc"
#include "tokens.inc"
#define xcoord	8270h
#define ycoord	8272h
#define oldxcoord	8274h
#define oldycoord	8276h
#define select_flag	8278h
#define tub_index	827Ah

.list

.org 9327h

START:
        ; Turn the indicator to off and clear screen
	call    RINDOFF         ; Turn off runindicator
	call	BUFCLR
	ld	hl, select_flag
	ld	(hl), 0
	
	; On met l'index sur le premier tube
	ld	hl, tub_index
	ld	(hl), 1
	
	call	FOCUS_INIT
	call	MAP_LOAD
	;call	TUBE_LOAD
	;call	TUBE_PREVIEW_PRINT
	call	BUFCOPY
	call	PRINT_HEADER
	call	UPDATE_TIMER
	
loop:	
	call	MOVE_SCAN_KEY
	call	SELECT_SCAN_KEY

	; Verifier que le temps n'est pas ecoule...
	ld	hl, (timeup)
	ld	a, l
	or	a
	jp 	z, fin
	
	
	call	UPDATE_TIMER
	jp	loop

; Si le temps est ecoule
fin:
	ld	b, 6

finboucle:
	call	WAITKEY
	;call	GET_TUBE
	;call	PRINT_SQUELETTE
	;call	OIL_LOAD
	;call	OIL_PRINT
	;ld	hl, oilxcoord
	;ld	a, 16 
	;ld	(hl), a
	;djnz	finboucle
	;call	FILL_ALL_MAP
	
	ld	b, 32
	ld	c, 32
	call	PARSE_TUBE

	call	WAITKEY
	ret
	.end
end


; Warning, these include MUST be at the end !!!!
#include "map.asm"
#include "move.asm"
#include "timer.asm"
#include "score.asm"
#include "oil.asm"
#include "sprites.asm"
#include "drawspr.asm"
