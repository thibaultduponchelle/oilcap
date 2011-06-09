; hl = map adress
MAP_LOAD:
	push	hl
	push	de
	push	af

	ld	a, 0
	ld	e, 8

	ld	b, 7
	
lm_loop_y:
	push	bc

	ld	b, 10
lm_loop_x:
	ld	hl, block

	push	hl
	push	de
	push	bc
	push	af
	
	call	DRWSPR	

	pop	af
	pop	bc
	pop	de
	pop	hl

	add	a, 8
	djnz	lm_loop_x

end_line:
	ld	a, e
	add	a, 8	
	ld	e, a
	ld	a, 0
	pop	bc
	djnz	lm_loop_y	

lm_fin:

	; Afficher le robinet (depart)
	ld      a, 32
        ld      e, a
        ld      a, 80
        ld      hl, robinet 
        call    DRWSPR

	pop	af
	pop	de
	pop	hl
	
	ret



; Lire le contenu de l'emplacement sous le curseur
MATRIX_READ:

	push	hl
	push	de
	push	bc
	push	af

	ld	a, (xcoord)
        srl     a   
        srl     a   
        srl     a   
	ld	b, a
	push	bc
	
	ld	a, (ycoord)
	srl	a
	srl	a
	srl	a
	sub	1
	
	pop	bc
	ld	c, a

lecturematrice:
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


; Sauver un block dans la matrice 
MATRIX_SAVE_BLOCK:

	push	hl
	push	de
	push	bc
	push	af

	ld	a, (xcoord)
        srl     a   
        srl     a   
        srl     a   
	ld	b, a
	push	bc
	
	ld	a, (ycoord)
	srl	a
	srl	a
	srl	a
	sub	1
	
	pop	bc
	ld	c, a

lecturematrice2:
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
	push	hl

	ld	hl, tub_index
	ld	a, (hl)
	ld	b, a
	ld	ix, liste
	dec	ix

inc_ix2:
	inc	ix
	djnz	inc_ix2
	
	ld	a, (ix) 
	
	pop	hl
	ld	(hl), a
	
	pop	af
	pop	bc
	pop	de
	pop	hl

	ret
