
liste_title: 
	.db 01011010b, 00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b, 10010110b
	.db 01101001b, 00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b, 10100101b,
	
	;.db 01011010b, 10110100b, 01011010b, 10010110b, 01111000b, 00111100b, 00011110b, 10110100b, 01011010b, 10010110b, 01011010b, 10010110b
	;.db 01101001b, 00111100b, 10100101b, 01101001b, 00111100b, 00111100b, 00101101b, 00111100b, 00101101b, 00101101b, 10100101b, 11100001b 

	.db 01011010b, 10010110b, 11010010b, 11010010b, 00000000b, 00000000b, 01011010b, 10110100b, 01011010b, 10010110b, 01011010b, 10010110b, 
	.db 11000011b, 11000011b, 11000011b, 11000011b, 00000000b, 00000000b, 11000011b, 00000000b, 01001011b, 10000111b, 01001011b, 10100101b, 
	.db 01101001b, 10100101b, 11100001b, 01101001b, 10110100b, 00000000b, 01101001b, 10110100b, 11100001b, 11100001b, 11100001b, 00000000b, 

	.db 01011010b, 00111100b, 10010110b, 00000000b, 00000000b, 00000000b, 00000000b, 00000000b, 00000000b, 01011010b, 00111100b, 10010110b,
	.db 11000011b, 00000000b, 11000011b, 00000000b, 00000000b, 00000000b, 00000000b, 00000000b, 00000000b, 11000011b, 00000000b, 11000011b,
	.db 01101001b, 00111100b, 10100101b, 00000000b, 00000000b, 00000000b, 00000000b, 00000000b, 00000000b, 01101001b, 00111100b, 10100101b,

	;.db 01101001b, 00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b, 10010110b,
	;.db 01011010b, 00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b, 10100101b
	;.db 01101001b, 00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b,00111100b, 10110100b

	


liste_level_one:
	.db 11000011b,	; tube vertical
	.db 00111100b,  ; tube horizontal 
	.db 01101001b,  ; coude haut droite 
	.db 11100001b, 	; U ouvert en haut
	.db 11010010b,  ; coude haut droite 
	.db 11000011b,  ; tube vertical
	.db 01111000b,  ; ouvert a gauche 
	.db 01011010b   ; coude bas droite
 	.db 00101101b   ; T ouvert en haut
	.db 11000011b,  ; tube vertical
	.db 10110100b,  ; n ouvert en bas
	.db 11000011b,  ; tube vertical
	.db 10010110b,  ; coude gauche bas 
	.db 01111000b,  ; c ouvert a droite
	.db 10000111b,	; T ouvert a gauche 
	.db 01001011b,	; T ouvert en droite 
	.db 00101101b,  ; T ouvert en haut
	.db 00011110b,  ; T ouvert en bas
	.db 11000011b,  ; tube vertical
	.db 11000011b,  ; tube vertical
	.db 11000011b, 10010110b, 
	.db 00111100b, 00111100b, 00111100b, 00111100b, 00111100b     
	.db 11000011b, 11000011b, 
	.db 11000011b, 10010110b, 
	.db 11100001b, 11010010b, 10110100b, 01111000b, 00101101b
	.db 00001111b, 00111100b, 00001111b, 00101101b, 00101101b
	.db 00011110b, 00111100b, 01001011b, 00101101b, 00101101b
	.db 11100001b, 11010010b, 10110100b, 01111000b, 00101101b
	.db 11110000b, 10000111b, 01001011b, 00101101b, 00011110b,
	.db 00001111b, 00111100b, 00001111b, 00001101b, 00101101b
	.db 00011110b, 00111100b, 01001011b, 00101101b, 00101101b
	.db 00011110b, 00001100b, 11000011b, 00001101b, 00001101b
	.db 00011110b, 00001100b, 11000011b, 00001101b, 00001101b
	.db 00011110b, 00001100b, 11000011b, 00001101b, 00001101b
	.db 00011110b, 00001100b, 11000011b, 00001101b, 00001101b

oclock:
	.db 00111100b
	.db 01000010b
	.db 10010001b
	.db 10010001b
	.db 10011101b
	.db 10000001b
	.db 01000010b
	.db 00111100b



block2:
	.db 11100111b
	.db 10000001b
	.db 10000001b
	.db 00000000b
	.db 00000000b
	.db 10000001b
	.db 10000001b
	.db 11100111b

block:
	.db 11111111b
	.db 10000001b
	.db 10000001b
	.db 10000001b
	.db 10000001b
	.db 10000001b
	.db 10000001b
	.db 11111111b




focus2:
	.db 00000000b
	.db 01000010b
	.db 00100100b
	.db 00011000b
	.db 00011000b
	.db 00100100b
	.db 01000010b
	.db 00000000b
focus:
	.db 00000000b
	.db 01000010b
	.db 00000000b
	.db 00011000b
	.db 00011000b
	.db 00000000b
	.db 01000010b
	.db 00000000b


robinet:
	.db 01111100b
	.db 00010000b
	.db 11111100b
	.db 00000010b
	.db 00000010b
	.db 11111100b
	.db 00000000b
	.db 00000000b


oil:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
oil_top:
	.db 00011000b
	.db 00011000b
	.db 00011000b
	.db 00011000b
	.db 00011000b
	.db 00000000b
	.db 00000000b
	.db 00000000b

oil_bot:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00011000b
	.db 00011000b
	.db 00011000b
	.db 00011000b
	.db 00011000b


oil_left:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 11111000b
	.db 11111000b
	.db 00000000b
	.db 00000000b
	.db 00000000b


oil_right:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00011111b
	.db 00011111b
	.db 00000000b
	.db 00000000b
	.db 00000000b





tub:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b


blank:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
black:
	.db 11111111b
	.db 11111111b
	.db 11111111b
	.db 11111111b
	.db 11111111b
	.db 11111111b
	.db 11111111b
	.db 11111111b
blackk:
	.db 00000000b
	.db 01111110b
	.db 01111110b
	.db 01111110b
	.db 01111110b
	.db 01111110b
	.db 01111110b
	.db 01111110b
	.db 00000000b



tub_top:
	.db 00100100b
	.db 00100100b
	.db 00100100b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b

tub_bot:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00100100b
	.db 00100100b
	.db 00100100b


tub_left:
	.db 00000000b
	.db 00000000b
	.db 11100000b
	.db 00000000b
	.db 00000000b
	.db 11100000b
	.db 00000000b
	.db 00000000b


tub_right:
	.db 00000000b
	.db 00000000b
	.db 00000111b
	.db 00000000b
	.db 00000000b
	.db 00000111b
	.db 00000000b
	.db 00000000b


tub_topc:
	.db 00000000b
	.db 00000000b
	.db 00011000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b

tub_botc:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00011000b
	.db 00000000b
	.db 00000000b


tub_leftc:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00100000b
	.db 00100000b
	.db 00000000b
	.db 00000000b
	.db 00000000b


tub_rightc:
	.db 00000000b
	.db 00000000b
	.db 00000000b
	.db 00000100b
	.db 00000100b
	.db 00000000b
	.db 00000000b
	.db 00000000b
