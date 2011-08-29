; Position x et y a 0 (depart)
COORD_RESET:
	ld	a, 0
	ld	(xcoord), a
        ld 	a, 0
        ld 	(ycoord), a
	ret

; Deplacer la position vers la droite
; (sprites 8x8)
COORD_DEPLACE_A_DROITE:
	ld	a, (xcoord)
	add	a, 8
        ld 	(xcoord), a
	ret	

; Remettre la position x a 0 
; Deplacer la position y de 8 vers le bas
; (Car il s'agit de sprite 8x8)
COORD_RETOUR_A_LA_LIGNE:
	ld	a, 0
        ld 	(xcoord), a
	ld	a, (ycoord)
	add	a, 8
	ld	(ycoord), a
	ret	
	

	
; Cette fonction sert a copier l'ecran de titre
; Il s'agit d'afficher des tubes et non de simplement copier
; des octets a l'ecran
; hl = map adress
TITLE_LOAD:

	; On commence en haut a gauche
	call	COORD_RESET
	

	; valeur de la boucle au depart
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
	ld       a,24
        ld       (pencol),a   ;charge la valeur de la ligne de texte sur l'écran
        ld       a,45
        ld       (penrow),a   ;charge la valeur de la colone de texte.
        ld       hl,press_a_key;charge l'adresse du texte dans hl
        call    _vputs        ;appelle la rom call puts
	
	ret


press_a_key:
	.db $05, " press a key...", 0
