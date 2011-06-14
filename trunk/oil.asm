; Tester l'entree du premier tube
CHECK_FIRST_TUBE:
	push	hl
	push	de
	push	bc
	push	af

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 000001000b    ; On cherche a savoir si le premier tuyau est relie au robinet
	and	(ix)		
	jp	z, fin_du_jeu 
	
	pop	af
	pop	bc
	pop	de
	pop	hl
	
	ret


; Parser les tubes en partant de l'emplacement (b,c)
PARSE_TUBE:
	push	hl
	push	de
	push	bc
	push	af

	push	bc
	;call	WAITKEY
	; Recuperer le tube, charger le sprite et afficher
	call	GET_TUBE
	call	OIL_LOAD
	call	OIL_PRINT	

	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000001b
	and	(ix)
	jp	z, pas_de_haut	
	
	; Tester haut et call avec c - 8
	ld	a, c
	sub	8
	ld	c, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000010b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_EN_HAUT
	
		
pas_de_haut:
	pop	bc
	push	bc
	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000010b
	and	(ix)
	jp	z, pas_de_bas

	; Tester haut et call avec c + 8
	ld	a, c
	add	a, 8
	ld	c, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000001b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_EN_BAS


pas_de_bas:
	pop	bc
	push	bc
	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000100b
	and	(ix)
	jp	z, pas_de_gauche
	
	; Tester bas puis call avec b - 8
	ld	a, b
	sub	8
	ld	b, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00001000b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_A_GAUCHE

pas_de_gauche:
	pop	bc
	push	bc

	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00001000b
	and	(ix)
	jp	z, pas_de_droite	

	; Tester bas puis call avec b + 8
	ld	a, b
	add	a, 8
	ld	b, a
	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000100b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_A_DROITE


pas_de_droite:
	pop	bc
	
	jp	pt_fin

perdu:
	ld	hl, leak
	ld	(hl), 0
	call	_dispHL
	call	WAITKEY
	call	WAITKEY
	

pt_fin:	
	pop	af
	pop	bc
	pop	de
	pop	hl

	ret


; Parser les tubes en partant de l'emplacement (b,c)
PARSE_TUBE_EN_HAUT:
	push	hl
	push	de
	push	bc
	push	af

	push	bc
	call	WAITKEY
	; Recuperer le tube, charger le sprite et afficher
	call	GET_TUBE
	call	OIL_LOAD
	call	OIL_PRINT	

	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000001b
	and	(ix)
	jp	z, pas_de_haut1	
	
	; Tester haut et call avec c - 8
	ld	a, c
	sub	8
	ld	c, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000010b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_EN_HAUT
	
		
pas_de_haut1:
y_a_un_bas:
	pop	bc
	push	bc
	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000100b
	and	(ix)
	jp	z, pas_de_gauche1
	
	; Tester bas puis call avec b - 8
	ld	a, b
	sub	8
	ld	b, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00001000b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_A_GAUCHE

pas_de_gauche1:
	pop	bc
	push	bc

	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00001000b
	and	(ix)
	jp	z, pas_de_droite1	

	; Tester bas puis call avec b + 8
	ld	a, b
	add	a, 8
	ld	b, a
	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000100b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_A_DROITE


pas_de_droite1:
	pop	bc
	
	jp	pt_fin1

perdu1:
	ld	hl, leak
	ld	(hl), 0
	call	_dispHL
	call	WAITKEY
	call	WAITKEY
	

pt_fin1:	
	pop	af
	pop	bc
	pop	de
	pop	hl

	ret


; Parser les tubes en partant de l'emplacement (b,c)
PARSE_TUBE_A_DROITE:
	push	hl
	push	de
	push	bc
	push	af

	push	bc
	call	WAITKEY
	; Recuperer le tube, charger le sprite et afficher
	call	GET_TUBE
	call	OIL_LOAD
	call	OIL_PRINT	

	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000001b
	and	(ix)
	jp	z, pas_de_haut2
	
	; Tester haut et call avec c - 8
	ld	a, c
	sub	8
	ld	c, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000010b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_EN_HAUT
	
		
pas_de_haut2:
	pop	bc
	push	bc
	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000010b
	and	(ix)
	jp	z, pas_de_bas2

	; Tester haut et call avec c + 8
	ld	a, c
	add	a, 8
	ld	c, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000001b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_EN_BAS


pas_de_bas2:
y_a_un_gauche:
	pop	bc
	push	bc

	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00001000b
	and	(ix)
	jp	z, pas_de_droite2	

	; Tester bas puis call avec b + 8
	ld	a, b
	add	a, 8
	ld	b, a
	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000100b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_A_DROITE


pas_de_droite2:
	pop	bc
	
	jp	pt_fin2

perdu2:
	ld	hl, leak
	ld	(hl), 0
	call	_dispHL
	call	WAITKEY
	call	WAITKEY
	

pt_fin2:	
	pop	af
	pop	bc
	pop	de
	pop	hl

	ret


; Parser les tubes en partant de l'emplacement (b,c)
PARSE_TUBE_EN_BAS:
	push	hl
	push	de
	push	bc
	push	af

	push	bc
	call	WAITKEY
	; Recuperer le tube, charger le sprite et afficher
	call	GET_TUBE
	call	OIL_LOAD
	call	OIL_PRINT	

y_a_un_haut:
	pop	bc
	push	bc
	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000010b
	and	(ix)
	jp	z, pas_de_bas3

	; Tester haut et call avec c + 8
	ld	a, c
	add	a, 8
	ld	c, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000001b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_EN_BAS


pas_de_bas3:
	pop	bc
	push	bc
	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000100b
	and	(ix)
	jp	z, pas_de_gauche3
	
	; Tester bas puis call avec b - 8
	ld	a, b
	sub	8
	ld	b, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00001000b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_A_GAUCHE

pas_de_gauche3:
	pop	bc
	push	bc

	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00001000b
	and	(ix)
	jp	z, pas_de_droite3

	; Tester bas puis call avec b + 8
	ld	a, b
	add	a, 8
	ld	b, a
	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000100b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_A_DROITE


pas_de_droite3:
	pop	bc
	
	jp	pt_fin3

perdu3:
	ld	hl, leak
	ld	(hl), 0
	call	_dispHL
	call	WAITKEY
	call	WAITKEY
	

pt_fin3:	
	pop	af
	pop	bc
	pop	de
	pop	hl

	ret

; Parser les tubes en partant de l'emplacement (b,c)
PARSE_TUBE_A_GAUCHE:
	push	hl
	push	de
	push	bc
	push	af

	push	bc
	call	WAITKEY
	; Recuperer le tube, charger le sprite et afficher
	call	GET_TUBE
	call	OIL_LOAD
	call	OIL_PRINT	

	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000001b
	and	(ix)
	jp	z, pas_de_haut4	
	
	; Tester haut et call avec c - 8
	ld	a, c
	sub	8
	ld	c, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000010b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_EN_HAUT
	
		
pas_de_haut4:
	pop	bc
	push	bc
	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000010b
	and	(ix)
	jp	z, pas_de_bas4

	; Tester haut et call avec c + 8
	ld	a, c
	add	a, 8
	ld	c, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00000001b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_EN_BAS


pas_de_bas4:
	pop	bc
	push	bc
	; Tester la morphologie du tube courant	
	call	GET_TUBE
	ld	ix, tube_squelette
	ld	a, 00000100b
	and	(ix)
	jp	z, pas_de_gauche4
	
	; Tester bas puis call avec b - 8
	ld	a, b
	sub	8
	ld	b, a

	call	GET_TUBE_TEST
	ld	ix, tube_a_tester
	ld	a, 00001000b
	and	(ix)		
	jp	z, fin_du_jeu

	call	PARSE_TUBE_A_GAUCHE

pas_de_gauche4:
y_a_un_droite:
	pop	bc
	
	jp	pt_fin4

perdu4:
	ld	hl, leak
	ld	(hl), 0
	call	_dispHL
	call	WAITKEY
	call	WAITKEY
	

pt_fin4:	
	pop	af
	pop	bc
	pop	de
	pop	hl

	ret







; Remplir tout la map avec l'huile
; On commence a (0, 8) puis on parcours tou le tableau
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

	ld	hl, oilxcoord
	ld	a, (hl)
	ld	b, a
		
	ld	hl, oilycoord
	ld	a, (hl)
	ld	c, a

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

; Recuperer le tube sous le curseur (b,c)
; Et mettre le squelette dans tube_squelette
GET_TUBE_TEST:

	push	hl
	push	de
	push	bc
	push	af

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

lecturematrice5:
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
	
	ld	hl, tube_a_tester
	ld	(hl), a

	pop	af
	pop	bc
	pop	de
	pop	hl

	ret

	
; Afficher la valeur de tube_squelette
; Il faut recuperer le tube avec GET_TUBE avant
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
; Attention, il faut utiliser GET_TUBE avant
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

; Afficher l'huile a l'emplacement (b,c)
OIL_PRINT:
	push	hl
	push	bc
	push	de
	push	af

	; Superposer l'huile	
	ld	e, c
	ld	a, b
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

tube_a_tester:
	.db 0

; Passer perdu a 0 signifie la mort
leak:
	.db 1
