all: clean OILCAP.83p

OILCAP.83p: main.bin
	bin8x main.bin -o OILCAP.83p -n OILCAP -q
	
	
main.bin: main.asm
	spasm main.asm
	
clean:
	rm -f *.bin
	rm -f *.83p

.PHONY: all clean

