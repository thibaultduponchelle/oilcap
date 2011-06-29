
TUBE_LOAD:
	push	hl
	push	bc
	push	de
	push	af

	; Effacer le sprite
	ld	hl, blank
	ld	de, tub
	call	COPYSPR


	; tub_index est une variable globale qui pointe sur le prochain tube a afficher
	;call	WAITKEY
	ld	hl, tub_index
	ld	a, (hl)
	ld	b, a
	;ld	ix, liste
	dec	ix

inc_ix:
	inc	ix
	djnz	inc_ix
	
	ld	a, 00000001b
	and	(ix)
	jp	z, no_top	
	ld	hl, tub_top
	ld	de, tub
	call	COPYSPR_OR

no_top:
	ld	a, 00000010b
	and	(ix)
	jp	z, no_bot	
	ld	hl, tub_bot
	ld	de, tub
	call	COPYSPR_OR

no_bot:
	ld	a, 00000100b
	and	(ix)
	jp	z, no_left	
	ld	hl, tub_left
	ld	de, tub
	call	COPYSPR_OR

no_left:
	ld	a, 00001000b
	and	(ix)
	jp	z, no_right	
	ld	hl, tub_right
	ld	de, tub
	call	COPYSPR_OR

no_right:

	ld	a, (ix) 
	ld	a, 00010000b
	and	(ix)
	jp	z, no_topc	
	ld	hl, tub_topc
	ld	de, tub
	call	COPYSPR_OR


no_topc:
	ld	a, (ix) 
	ld	a, 00100000b
	and	(ix)
	jp	z, no_botc	
	ld	hl, tub_botc
	ld	de, tub
	call	COPYSPR_OR

no_botc:

	ld	a, (ix) 
	ld	a, 01000000b
	and	(ix)
	jp	z, no_leftc	
	ld	hl, tub_leftc
	ld	de, tub
	call	COPYSPR_OR


no_leftc:
	ld	a, (ix) 
	ld	a, 10000000b
	and	(ix)
	jp	z, no_rightc	
	ld	hl, tub_rightc
	ld	de, tub
	call	COPYSPR_OR

no_rightc:

	pop	af
	pop	de
	pop	bc
	pop	hl
	
	ret

; Afficher le tube sur l'ecran
TUBE_PRINT:
	push	hl
	push	bc
	push	de
	push	af

	; Effacer l'ancien sprite
	ld	a, (ycoord)
	ld	e, a
	ld	a, (xcoord)
	ld	hl, black
	call	CLRSPR
	
	; Afficher le nouveau tube	
	ld	a, (ycoord)
	ld	e, a
	ld	a, (xcoord)
	ld	hl, tub
	call	DRWSPR
	
		
	; Tube is loaded, so increment the index
	ld	hl, tub_index
	ld	a, (hl)
	inc	a
	ld	(hl), a

	pop	af
	pop	de
	pop	bc
	pop	hl
	ret

; Afficher le prochain tube a poser
TUBE_PREVIEW_PRINT:
	push	hl
	push	de
	push	af

	; Effacer l'ancien tube	
	ld	a, 54
	ld	e, a
	ld	a, 84
	ld	hl, black
	call	CLRSPR
	

	; Afficher le nouveau tube	
	ld	a, 54
	ld	e, a
	ld	a, 84
	ld	hl, tub
	call	DRWSPR
	
	ld	hl, blank
	ld	de, tub
	call	COPYSPR
	
	pop	af
	pop	de
	pop	hl

	ret



; copier une sprite dans une autre avec un masque OR
; hl = src
; de = dest
COPYSPR_OR:
	push	hl
	push	de
	push	bc
	push	af

	ld	b, 8

cpyloop_or:
	ld	a,(hl)
	push	hl
	ld	h, d
	ld	l, e
	or	(hl)	
	ld 	(de), a
	pop	hl
	inc 	de
	inc	hl
	djnz	cpyloop_or

	pop	af
	pop	bc
	pop	de
	pop	hl
	
	ret
	
; Copier un sprite dans un autre en ecrasant la destination
; hl = src
; de = dest
COPYSPR:
	ld	b, 8
cpyloop:
	ld	a,(hl)
	ld 	(de), a
	inc 	de
	inc	hl
	djnz	cpyloop
	
	ret
	

;ÃœÃ›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›ÃŸ DRWSPR ÃŸÃ›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›
;ÃšÃ„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Â¿
;Â³ Draw 8x8 sprite Ã¾ a=x, e=y, hl=sprite address                              Â³
;Ã€Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã™
DRWSPR:

        push    hl              ; Save sprite address

;Ã›Ã›Ã›Ã›   Calculate the address in graphbuf   Ã›Ã›Ã›Ã›

        ld      hl,0            ; Do y*12
        ld      d,0
        add     hl,de
        add     hl,de
        add     hl,de
        add     hl,hl
        add     hl,hl

        ld      d,0             ; Do x/8
        ld      e,a
        srl     e
        srl     e
        srl     e
        add     hl,de

        ld      de,8e29h
        add     hl,de           ; Add address to graphbuf

        ld      b,00000111b     ; Get the remainder of x/8
        and     b
        cp      0               ; Is this sprite aligned to 8*n,y?
        jp      z,ALIGN


;Ã›Ã›Ã›Ã›   Non aligned sprite blit starts here   Ã›Ã›Ã›Ã›

        pop     ix              ; ix->sprite
        ld      d,a             ; d=how many bits to shift each line

        ld      e,8             ; Line loop
LILOP:  ld      b,(ix+0)        ; Get sprite data

        ld      c,0             ; Shift loop
        push    de
SHLOP:  srl     b
        rr      c
        dec     d
        jp      nz,SHLOP
        pop     de

        ld      a,b             ; Write line to graphbuf
        or      (hl)
        ld      (hl),a
        inc     hl
        ld      a,c
        or      (hl)
        ld      (hl),a

        ld      bc,11           ; Calculate next line address
        add     hl,bc
        inc     ix              ; Inc spritepointer

        dec     e
        jp      nz,LILOP        ; Next line

        jp      DONE1


;Ã›Ã›Ã›Ã›   Aligned sprite blit starts here   Ã›Ã›Ã›Ã›

ALIGN:                          ; Blit an aligned sprite to graphbuf
        pop     de              ; de->sprite
        ld      b,8
ALOP1:  ld      a,(de)
        or      (hl)            ; xor=erase/blit
        ld      (hl),a
        inc     de
        push    bc
        ld      bc,12
        add     hl,bc
        pop     bc
        djnz    ALOP1

DONE1:
        ret




;ÜÛÛÛÛÛÛÛÛÛÛÛÛß CLRSPR ßÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ Clear 8x8 sprite þ a=x, e=y, hl=sprite address                             ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CLRSPR:
        push    hl              ; Save sprite address

;ÛÛÛÛ   Calculate the address in graphbuf   ÛÛÛÛ

        ld      hl,0            ; Do y*12
        ld      d,0
        add     hl,de
        add     hl,de
        add     hl,de
        add     hl,hl
        add     hl,hl

        ld      d,0             ; Do x/8
        ld      e,a
        srl     e
        srl     e
        srl     e
        add     hl,de

        ld      de,8e29h
        add     hl,de           ; Add address to graphbuf

        ld      b,00000111b     ; Get the remainder of x/8
        and     b
        cp      0               ; Is this sprite aligned to 8*n,y?
        jp      z,ALIGN2


;ÛÛÛÛ   Non aligned sprite erase starts here   ÛÛÛÛ

        pop     ix              ; ix->sprite
        ld      d,a             ; d=how many bits to shift each line

        ld      e,8             ; Line loop
LILOP2: ld      b,(ix+0)        ; Get sprite data

        ld      c,0             ; Shift loop
        push    de
SHLOP2: srl     b
        rr      c
        dec     d
        jp      nz,SHLOP2
        pop     de

        ld      a,b             ; Write line to graphbuf
        cpl
        and     (hl)
        ld      (hl),a
        inc     hl
        ld      a,c
        cpl
        and     (hl)
        ld      (hl),a

        ld      bc,11           ; Calculate next line address
        add     hl,bc
        inc     ix              ; Inc spritepointer

        dec     e
        jp      nz,LILOP2       ; Next line

        jp      DONE5


;ÛÛÛÛ   Aligned sprite erase starts here   ÛÛÛÛ

ALIGN2:                         ; Erase an aligned sprite in graphbuf
        pop     de              ; de->sprite
        ld      b,8
ALOP2:  ld      a,(de)
        cpl
        and     (hl)
        ld      (hl),a
        inc     de
        push    bc
        ld      bc,12
        add     hl,bc
        pop     bc
        djnz    ALOP2

DONE5:
        ret










	
;ÃšÃ„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã‚Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã‚Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã‚Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã‚Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Â¿
;Â³Ã›Ã›Ã›Ã›Ã› Z80 Ã›Ã›Ã›Ã›Ã›Ã›Â³     EQUALS     Â³Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Â³ movax Â³Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Ã›Â³
;Ã€Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„ÃÃ„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„ÃÃ„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„ÃÃ„Ã„Ã„Ã„Ã„Ã„Ã„ÃÃ„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã™

WAITKEY .equ     4CFEh  ; Wait for a key and read
BUFCLR	.equ	 515Bh	; Clear the graph backup
BUFCOPY .equ	 5164h	; Copy the graph backup to the screen
RINDOFF .equ	 4795h	; Turn off runindicator
PRINTHL .equ	 4709h	; Print HL in dec. on the screen
OP2TOP1 .equ	 41C2h	; Move OP2 to OP1
CONVOP1 .equ	 4EFCh	; Convert fp value in OP1 to a 2 byte hex
READKEY .equ	 4A18h	; Read key and place it in OP2 as a fp value
GOHOME	.equ	 47A1h	; Go to home screen (finish gfx program)
CLRTSHD .equ	 4765h	; Clear text shadow
HOMEUP	.equ	 4775h	; Place cursor at home
STRING	.equ	 470Dh	; Print 0 terminated string to screen (hl->string)



; ### unused ###
; Only put  repeat sprite on the screen
DRWBG:
	ld	hl, 8e29h
	;ld	c, (sprite_to_repeat) ; le sprite a repeter sur tout l'ecran	
	
	ld	b, 12
boucle1:
	ld 	a, 64
boucle2:	
	inc	hl
	ld	(hl), c
	dec	a
	cp 	0
	jp  	nz,boucle2
	
	djnz	boucle1

	ret

; Cette routine permet d'eviter qu'on sorte de l'arene
PROTECT_ARENA:

	ld	a,(xcoord)
	cp 	0
	jp	m, hors_arene
	cp	80
	jp	p, hors_arene
	ld	a,(ycoord)
	cp 	8
	jp	m, hors_arene
	cp	64
	jp	p, hors_arene

	jp	place_valide

hors_arene:
	ld	a, (oldxcoord)
	ld	(xcoord), a
	ld	a, (oldycoord)
	ld	(ycoord), a

place_valide:
	
	ret


