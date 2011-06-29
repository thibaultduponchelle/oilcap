
; Mettre a jour le timer c'est a dire :
; Charger les milli secondes, decrementer
; Si milli seconde == 0, charger secondes et decrementer
; Si seconde = 0, mettre timeup a 0
UPDATE_TIMER:
	push	hl
	push	af

	ld	hl, timeup
	ld	a, l
	and	a
	jp 	z, fin_timer
	
	ld	hl, microsec
	ld	a,(hl)
	dec	a
	jp	z, moins_une_milliseconde
	ld	(hl), a
	jp	fin_timer

moins_une_milliseconde:
	ld	hl, millisec
	ld	a, (hl)
	dec	a
	jp	z, moins_une_seconde  ; Tiens on viens de finir une seconde
	ld	(hl), a
	ld	hl, microsec
	ld	(hl), 100
	call	PRINT_MILLISEC
	call	PRINT_SEC
	call	UNLOCK_KFLAG
	jp	fin_timer

moins_une_seconde:
	ld	hl, sec
	ld	a, (hl)
	dec	a
	jp	z, temps_ecoule
	ld	(hl), a
	ld	hl, millisec
	ld	(hl), 100
	call	PRINT_SEC
	jp	fin_timer

temps_ecoule:
	ld	hl, timeup
	ld	(hl), 0

fin_timer:
	pop	af
	pop	hl

	ret	
	

PRINT_MILLISEC:
	push	hl
	push	de
	push	af
	push	bc	

	ld     hl, 0
	ld     (CURROW),hl
	ld     hl, 11
	ld     (CURCOL),hl
	ld     hl, (millisec)
	ld	h, 0
	call	_dispHL	
	;call	WAITKEY



	pop	bc
	pop	af
	pop	de
	pop	hl

	ret	


PRINT_SEC:
	push	hl
	push	de
	push	af
	push	bc	

	ld     hl, 0
	ld     (CURROW),hl
	ld     hl, 6
	ld     (CURCOL),hl
	ld     hl, (sec)
	ld	h, 0
	call	_dispHL	
	;call	WAITKEY
	

	pop	bc
	pop	af
	pop	de
	pop	hl

	ret	

UNLOCK_KFLAG:
	push	hl
	push	de
	push	af
	push	bc	

	ld	hl, kflag
	ld	a, (hl)
	cp	0
	jp	z, ne_rien_faire
	dec	a
	ld	(hl), a

ne_rien_faire:
	call	PRINT_SCORE
	pop	bc
	pop	af
	pop	de
	pop	hl

	ret	





PRINT_HEADER:
	push	hl
	push	de
	push	af
	push	bc	

	ld	a, 8
	ld	e, a
	ld	a, 88
	ld	hl, oclock
	call	DRWSPR	
	

	pop	bc
	pop	af
	pop	de
	pop	hl

	ret

	
timeup:
	.db 1

sec:
	.db 15
millisec:
	.db 100
	
microsec:	
	.db 100
