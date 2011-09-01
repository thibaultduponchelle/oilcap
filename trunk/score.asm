
; On passe ici lorsqu'on pose un tuyau
; Il s'agit de tester si l'emplacement est deja pris et de perdre des points si c'est le cas

UPDATE_SCORE:

	push	hl
	push	de
	push	bc
	push	af

	ld	a, (xcoord)
        ld      d,0             ; Do x/8
        ld      e,a 
        srl     e   
        srl     e   
        srl     e   
	ld	b, e
	push	bc
	
	ld	a, (ycoord)
	ld	d, 0
	ld	e, a
	srl	e
	srl	e
	srl	e
	ld	b, a
	ld	a, e
	sub	1
	
	pop	bc
	ld	c, a

lecturematrice3:
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

	; Tester si la case est libre
	cp	0
	jp	z, inc_score
	jp	dec_score
	

inc_score:
	;call	INCREASE_SCORE
	jp	fin_update_score
	
dec_score:
	call	DECREASE_SCORE

fin_update_score:
	;ld     hl, 0
	;ld     (CURROW),hl
	;ld     hl, 0
	;ld     (CURCOL),hl
	;ld  	h, 0
	;ld	l, a
	;call	_dispHL
	;call	WAITKEY
	;call	WAITKEY
	;call	WAITKEY

	
	pop	af
	pop	bc
	pop	de
	pop	hl

	ret

; Incrementer le score du joueur
INCREASE_SCORE:
	push	hl
	push	de
	push	af
	push	bc	
	
	ld	hl, score
	ld	a, (hl)
	cp	255
	jp	z, ne_pas_augmenter
	inc	a
	inc	a
	ld	(hl), a

ne_pas_augmenter:
	pop	bc
	pop	af
	pop	de
	pop	hl

	ret	

; decrementer le score de 2 si on pose un tuyau sur un case prise
DECREASE_SCORE:
	push	hl
	push	de
	push	af
	push	bc	

	ld	hl, score
	ld	a, (hl)
	cp	3
	jp	m, ne_pas_decrementer
	dec	a
	ld	(hl), a

ne_pas_decrementer:
	pop	bc
	pop	af
	pop	de
	pop	hl

	ret	


PRINT_SCORE:
	push	hl
	push	de
	push	af
	push	bc	

	ld     hl, 0
	ld     (CURROW),hl
	ld     hl, 0
	ld     (CURCOL),hl
	ld     hl, (score)
	ld	h, 0
	call	_dispHL	

	pop	bc
	pop	af
	pop	de
	pop	hl

	ret	


score:	
	.db 100
