.nolist
#define EQU .equ 
#include "ti83asm.inc"
#include "tokens.inc"
#define xcoord	8270h
#define ycoord	8271h
#define oldxcoord	8272h
#define oldycoord	8273h
#define tub_index	8275h

.list

.org 9327h

START:
        ; Turn the indicator to off and clear screen
	call    RINDOFF         ; Turn off runindicator
	call	BUFCLR
	
	; On met l'index sur le premier tube
	ld	hl, tub_index
	ld	(hl), 1
	call	TITLE_LOAD
	call	BUFCLR

game:	
	; On REmet l'index sur le premier tube (title_load utilise l'index)
	ld	hl, tub_index
	ld	(hl), 1
	call	FOCUS_INIT
	;call	INIT
	call	MAP_LOAD
	call	PRINT_OCLOCK
	call	UPDATE_TIMER
	call	BUFCOPY
	
	
loop:	
	call	MOVE_SCAN_KEY
	call	SELECT_SCAN_KEY

	; Verifier que le temps n'est pas ecoule...
	ld	a, (timeup)
	or	a
	jp 	z, fin
	
	
	call	UPDATE_TIMER
	jp	loop

; Si le temps est ecoule
fin:
	ld	b, 6

finboucle:
	ld	b, 72
	ld	c, 32

	; Verifier le premier tube
	call	CHECK_FIRST_TUBE
	ld	a, (leak)
	cp	0
	call	nz, PARSE_TUBE ; verifier les suivants
	
	ld	a, (leak)
	cp	0
	call	z, PERDU
	call	WAITKEY
	

fin_du_jeu:
	call	BUFCLR
	ret
	.end
end


; Warning, these include MUST be at the end !!!!
#include "title.asm"
#include "map.asm"
#include "move.asm"
#include "timer.asm"
#include "score.asm"
#include "oil.asm"
#include "level.asm"
#include "sprites.asm"
#include "drawspr.asm"
#include "init.asm"
