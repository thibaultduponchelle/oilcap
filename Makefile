all: clean OILCAP.83p

OILCAP.83p: main.bin
	bin8x main.bin -o OILCAP.83p -n OILCAP -q
	
	
main.bin: main.asm
	spasm main.asm
	
clean:
	rm -f *.bin
	rm -f *.83p

.PHONY: all clean

exec: 
	cd /home/tib/Code/tilem203/trunk/gui
	./testemu2 -r $(rom) -f /home/tib/Code/z80/OILCAP.83p -m play.txt
