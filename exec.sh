#!/bin/bash

make
cd /home/tib/Code/tilem530/trunk/gui
./tilem2 -r $rom -f /home/tib/Code/z80/oilcapgc/OILCAP.83p -m /home/tib/Code/z80/oilcapgc/macro/play.txt
