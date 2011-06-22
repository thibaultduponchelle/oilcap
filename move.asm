; Init the start position of the focus
; By default, nothing is selected
FOCUS_INIT:
	; init the start position
	push hl
	push de
	
	ld hl, 16
	ld (xcoord), hl
	ld (oldxcoord), hl
	ld de, 8
	ld (ycoord), de
	ld (oldycoord), de
	
	call FOCUS_PRINT	

	pop de
	pop hl

	ret

;; Scan key using direct input
MOVE_SCAN_KEY:
	push hl
	push de
	push bc
	;ld     a,$FF            ; Before any action, reset the keyport
        ;out    (1),a            ; ...by sending to the port 1 the value 255 (FF
	ld     a,$FE            ; select the keyboard group to scan (here the arrow keys)
	out    (1),a            ; ...by sending to the keyboard port (1) the value FE.
	in     a,(1)            ; Get the port value, which says wich keys was pressed 
	cp     254              ;\
	jp     z,bot            ;|
	cp     253              ;| Look for the key which was pressed and jump to the correct label. 
	jp     z,left           ;|
	cp     251              ;|
	jp     z,right          ;|
	cp     247              ;|
	jp     z,top           ;/
	
	jp finloop
	
; Callback depending on key pressed	
top:
	ld hl,(ycoord)
	ld a, l
	sub 8
	ld l, a
	ld (ycoord),hl
	jp print
bot:
	ld hl,(ycoord)
	ld a, l
	add a,8
	ld l, a
	ld (ycoord),hl
	jp print
right:
	ld hl,(xcoord)
	ld a, l
	add a,8
	ld l, a
	ld (xcoord),hl
	jp print
left:
	ld hl,(xcoord)
	ld a, l
	sub 8
	ld l, a
	ld (xcoord),hl
	jp print

; Passe ici seulement si key press
print:
	ld	hl,(xcoord)
	ld 	de,(ycoord)
	ld	a,l
	call	PROTECT_ARENA

	call FOCUS_PRINT

finloop:
	pop 	bc
	pop 	de
	pop	hl
	
	ret


FOCUS_PRINT:
	push	hl
	push	de
	push	af

	ld	hl,(xcoord)
	ld 	de,(ycoord)
	ld	a,l
	;call	PROTECT_ARENA
	;call	PROTECT_BLOCK

	; effacer la tout le sprite (on l'affichera un pixel plus loin apres)	
	ld	hl,(oldxcoord)
	ld 	de,(oldycoord)
	ld	a,l
	ld	hl, focus
	call	CLRSPR
	call 	BUFCOPY
	call	PRINT_MILLISEC
	CALL	PRINT_SEC

	
	; afficher nouveau sprite
	ld 	hl,(xcoord)
	ld 	de,(ycoord)
	ld 	(oldxcoord),hl
	ld 	(oldycoord),de
	ld 	a,l
	ld 	hl, focus
	call 	DRWSPR
	call 	BUFCOPY
	CALL	PRINT_MILLISEC
	CALL	PRINT_SEC


	pop	af
	pop	de
	pop	hl

	ret



; Test if the player selects a block  
SELECT_SCAN_KEY:
	push 	hl
	push 	de
	push 	bc
	push 	af
	ld     a,$FF          
        out    (1),a           
	ld     a,$FD       	; scanner le groupe
	out    (1),a         
	in     a,(1)        
	;bit	0,a
	cp	191
	jp	z, select
	cp	254
	jp	select_end

	
select:
	
	; Verifier qu'on ne pose pas 10 tubes a la suite
	ld	hl, kflag
	ld	a, (hl)	
	cp	0
	jp	z, ok
	jp	select_end

ok:
	; Si c'est bon activer le flag	
	ld	hl, kflag
	ld	a, 10
	ld	(hl), a 	
	
	ld	ix, liste_level_one
	call	TUBE_LOAD
	;call	MATRIX_READ
	call	UPDATE_SCORE
	call	PRINT_SCORE
	call	MATRIX_SAVE_BLOCK
	;call	MATRIX_READ
	;call	GET_TUBE
	;call	PRINT_SQUELETTE
	call	TUBE_PRINT
	ld	ix, liste_level_one
	call	TUBE_LOAD
	call	TUBE_PREVIEW_PRINT
	call	BUFCOPY
	CALL	PRINT_MILLISEC
	CALL	PRINT_SEC
	

select_end:
	pop	af
	pop	bc
	pop	de
	pop	hl

	ret

kflag:
	.db 0
