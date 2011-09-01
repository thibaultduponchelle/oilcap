
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
	cp	(score_a_battre)
	ld	hl, level
	inc	(hl)
	call	LOAD_LEVEL
	call	INIT
	call	MATRIX_RESET
	jp	game
	
	ret
	


level:
	.db 1

score_a_battre:
	.db 101

