FILL_ALL_MAP:
	push	hl
	push	de
	push	af

	; Initialiser le depart a 0	
	ld	hl, oilxcoord
	ld	(hl), 0
	ld	hl, oilycoord
	ld	(hl), 8
	
	ld	a, 0
	ld	e, 8

	ld	b, 7
	
fam_loop_y:
	push	bc

	ld	b, 10
fam_loop_x:

	push	hl
	push	de
	push	bc
	push	af
	
        call    GET_TUBE
        ;call    PRINT_SQUELETTE
        call    OIL_LOAD
        call    OIL_PRINT
        ld      hl, oilxcoord
        ld      a, (hl)
	add	a, 8
	ld	d, h
	ld	e, l
        ld      hl, oilxcoord
        ld      (hl), a
	

	pop	af
	pop	bc
	pop	de
	pop	hl

	djnz	fam_loop_x

fam_end_line:

	; Remettre x a 0
	ld      hl, oilxcoord
	ld	a, 0
        ld      (hl), a

	; Incrementer la ligne
	ld      hl, oilycoord
        ld      a, (hl)
	add	a, 8
	ld	d, h
	ld	e, l
        ld      hl, oilycoord
        ld      (hl), a
	
	pop	bc
	djnz	fam_loop_y	

fam_fin:

	pop	af
	pop	de
	pop	hl
	
	ret




; Recuperer le tube sous le curseur (b,c)
; Et mettre le squelette dans tube_squelette
GET_TUBE:

	push	hl
	push	de
	push	bc
	push	af

	ld	hl, oilxcoord
	ld	a, (hl)
	ld	b, a
		
	ld	hl, oilycoord
	ld	a, (hl)
	ld	c, a

	ld	a, b
        srl     a   
        srl     a   
        srl     a   
	ld	b, a
	push	bc
	
	ld	a, c
	srl	a
	srl	a
	srl	a
	sub	1
	
	pop	bc
	ld	c, a

lecturematrice4:
	ld a,c   ;\
	add a,a  ; |
	add a,a  ; |a=c*16
	add a,a  ; |
	add a,a  ;/
	sub c
	sub c
	sub c
	sub c
	sub c
	sub c
	add a,b	; ajouter le x
	ld e,a
	ld d,0
	ld  hl, map
	add hl,de
	ld a,(hl)
	
	ld	hl, tube_squelette
	ld	(hl), a

	pop	af
	pop	bc
	pop	de
	pop	hl

	ret

; Afficher la valeur de tube_squelette
PRINT_SQUELETTE:
	push	hl
	push	de
	push	bc
	push	af

	ld	hl, tube_squelette
	ld	a, (hl)

	ld     hl, 0
	ld     (CURROW),hl
	ld     hl, 0
	ld     (CURCOL),hl
	ld  	h, 0
	ld	l, a
	call	_dispHL
	call	WAITKEY
	call	WAITKEY
	call	WAITKEY

	
	pop	af
	pop	bc
	pop	de
	pop	hl

	ret


; A partir du tube_squelette, creer le sprite de remplissage
OIL_LOAD:
	push	hl
	push	bc
	push	de
	push	af
	
	
	; On efface le contenu du sprite 
        ld      hl, blank
        ld      de, oil
        call    COPYSPR

	ld	ix, tube_squelette

	ld	a, 00000001b
	and	(ix)
	jp	z, no_top2	
	ld	hl, oil_top
	ld	de, oil
	call	COPYSPR_OR

no_top2:
	ld	a, 00000010b
	and	(ix)
	jp	z, no_bot2
	ld	hl, oil_bot
	ld	de, oil
	call	COPYSPR_OR

no_bot2:
	ld	a, 00000100b
	and	(ix)
	jp	z, no_left2	
	ld	hl, oil_left
	ld	de, oil
	call	COPYSPR_OR

no_left2:
	ld	a, 00001000b
	and	(ix)
	jp	z, no_right2	
	ld	hl, oil_right
	ld	de, oil
	call	COPYSPR_OR

no_right2:

	pop	af
	pop	de
	pop	bc
	pop	hl
	
	ret


OIL_PRINT:
	push	hl
	push	bc
	push	de
	push	af

	; Superposer l'huile	
	ld	a, (oilycoord)
	ld	e, a
	ld	a, (oilxcoord)
	ld	hl, oil
	call	DRWSPR
	call	BUFCOPY
	
	pop	af
	pop	de
	pop	bc
	pop	hl

	ret

oilxcoord:
	.db 8
oilycoord:
	.db 16

tube_squelette:
	.db 0
