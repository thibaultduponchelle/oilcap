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
	; Il s'agit d'un curseur sur la liste
	ld	a, 1
	ld	(tub_index), a
	call	TITLE_LOAD
	call	WAITKEY
	call	BUFCLR
	call	FIRST_LEVEL_INIT

game:	
	; On Remet l'index sur le premier tube (title_load utilise l'index)
	ld	a, 1
	ld	(tub_index), a
	call	FOCUS_INIT
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

fin:
	ld	b, 72
	ld	c, 32
	
	call	WAITKEY

	ld	a, 1
	ld	(leak), a

	; Verifier le premier tube
	call	CHECK_FIRST_TUBE
	ld	a, (leak)
	cp	0
	call	nz, PARSE_TUBE_A_GAUCHE ; verifier les suivants
	call	PARSE_TUBE_A_GAUCHE ; verifier les suivants

	; Ici on verifie si le circuit n'a pas de fuite
	ld	a, (leak)
	cp	1
	call	z, NEXT_LEVEL

fin_du_jeu:
	call	WAITKEY
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
