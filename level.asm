
; Charger le niveau en cours
; Recuperer l'adresse du debut de la liste de tubes et la mettre dans ix
LOAD_LEVEL:
	ld	a, (level)
	cp	1
	jp	nz, pas_lvl_un
	ld	ix, liste_level_one
	jp	load_level_fin

pas_lvl_un:
	cp	2
	jp	nz, pas_lvl_deux
	ld	ix, liste_level_two
	jp	load_level_fin

pas_lvl_deux:
	cp	3
	jp	nz, pas_lvl_trois
	ld	ix, liste_level_three
	jp	load_level_fin
pas_lvl_trois:
	NOP

load_level_fin:
	
	ret


; Passer au niveau superieur
NEXT_LEVEL:
	ld	a, (score)
	ld	hl, (pointeur_sur_score_a_battre)
	ld	h, 0
	ld	l, (hl)
	call	_dispHL
	call	waitkey
	cp	(hl)
	jp	m, nl_fin
	ld	hl, pointeur_sur_score_a_battre ; Se deplacer dans la liste des scores a battre
	inc	(hl)
	ld	hl, level
	inc	(hl)
	call	PRINT_LEVEL_TRANSITION
	call	LOAD_LEVEL
	call	INIT
	call	MATRIX_RESET
	jp	game

nl_fin:
	; afficher un truc du genre "game over"
	
	ret

PRINT_LEVEL_TRANSITION:
	call	BUFCLR
	call	BUFCOPY
	ld      a,20
        ld      (pencol),a   ;charge la valeur de la ligne de texte sur l'écran
        ld      a,30
        ld      (penrow),a   ;charge la valeur de la colone de texte.
        ld      hl,next_level_string	;charge l'adresse du texte dans hl
        call    _vputs          ;appelle la rom call puts
	call	WAITKEY 
	
	ret


	
next_level_string:
	.db "next level", 0

level:
	.db 1


