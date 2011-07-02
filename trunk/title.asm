COORD_RESET:
	ld	a, 0
	ld	(xcoord), a
        ld 	a, 0
        ld 	(ycoord), a
	ret

COORD_DEPLACE_A_DROITE:
	ld	a, (xcoord)
	add	a, 8
        ld 	(xcoord), a
	ret	

COORD_RETOUR_A_LA_LIGNE:
	ld	a, 0
        ld 	(xcoord), a
	ld	a, (ycoord)
	add	a, 8
	ld	(ycoord), a
	ret	
	

	

; hl = map adress
TITLE_LOAD:
	push	hl
	push	de
	push	bc
	push	af

	; On commence en haut a gauche
	call	COORD_RESET
	

	; coordonnee de depart
	ld	a, 0
	ld	e, 8

	ld	b, 8
	
tl_loop_y:
	push	bc
	ld	b, 12

tl_loop_x:

	push	bc
	ld	ix, liste_title
	call	TUBE_LOAD
	call	TUBE_PRINT	

	; incrementer le x
	call	COORD_DEPLACE_A_DROITE

	pop	bc
	djnz	tl_loop_x

tl_end_line:
	
	; remettre x a 0 et y + 8
	call	COORD_RETOUR_A_LA_LIGNE

	pop	bc
	djnz	tl_loop_y	

tl_fin:

	call	BUFCOPY

	; afficher "press a key"
	ld       hl,24
        ld       (pencol),hl   ;charge la valeur de la ligne de texte sur l'écran
        ld       hl,45
        ld       (penrow),hl   ;charge la valeur de la colone de texte.
        ld       hl,press_a_key;charge l'adresse du texte dans hl
        call    _vputs        ;appelle la rom call puts
	
	call	WAITKEY
	
	ld	a, 1
	ld	(tub_index), a

	pop	af
	pop	bc
	pop	de
	pop	hl
	
	ret

press_a_key:
	.db $05, " press a key...", 0
