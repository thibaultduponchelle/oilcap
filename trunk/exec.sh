#!/bin/bash

make
cd /home/tib/Code/tilem431/trunk/gui
./tilem2 -r $rom -f /home/tib/Code/z80/oilcap/OILCAP.83p -m /home/tib/Code/z80/oilcap/macro/play.txt
