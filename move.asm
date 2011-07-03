; Init the start position of the focus
; By default, nothing is selected
FOCUS_INIT:
	; init the start position
	
	ld a, 16
	ld (xcoord), a
	ld (oldxcoord), a
	ld a, 16
	ld (ycoord), a
	ld (oldycoord), a
	
	call FOCUS_PRINT	

	ret

;; Scan key using direct input
MOVE_SCAN_KEY:
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
	ld a,(ycoord)
	sub 8
	ld (ycoord),a
	jp print
bot:
	ld a,(ycoord)
	add a,8
	ld (ycoord),a
	jp print
right:
	ld a,(xcoord)
	add a,8
	ld (xcoord),a
	jp print
left:
	ld a,(xcoord)
	sub 8
	ld (xcoord),a
	jp print

; Passe ici seulement si key press
print:
	ld	a,(xcoord)
	ld 	e,(ycoord)
	call	PROTECT_ARENA

	call FOCUS_PRINT

finloop:
	
	ret

; On affiche le curseur
FOCUS_PRINT:

	; effacer la tout le sprite (on l'affichera un pixel plus loin apres)	
	ld	a,(oldxcoord)
	ld 	de,(oldycoord)
	ld	d,0
	ld	hl, focus
	call	CLRSPR

	; afficher nouveau sprite
	ld 	hl,(xcoord)
	ld 	de,(ycoord)
	ld 	(oldxcoord),hl
	ld 	(oldycoord),de
	ld 	a,l
	ld 	hl, focus
	call 	DRWSPR
	;call 	BUFCOPY
	call	FASTCOPY
	CALL	PRINT_MILLISEC
	CALL	PRINT_SEC

	ret



; Test if the player selects a block  
SELECT_SCAN_KEY:
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
	
	;ld	ix, liste_level_one
	call	LOAD_LEVEL
	call	TUBE_LOAD
	call	UPDATE_SCORE
	call	PRINT_SCORE
	call	MATRIX_SAVE_BLOCK
	call	TUBE_PRINT
	;ld	ix, liste_level_one   ;FIXME
	call	LOAD_LEVEL
	call	TUBE_LOAD
	call	TUBE_PREVIEW_PRINT
	call	FASTCOPY
	CALL	PRINT_MILLISEC
	CALL	PRINT_SEC
	
select_end:

	ret

kflag:
	.db 0
