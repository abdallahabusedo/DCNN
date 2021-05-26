vsim work.pool
add wave -position insertpoint  \
sim:/pool/AVR \
sim:/pool/Done \
sim:/pool/rst \
sim:/pool/Temp \
sim:/pool/WINDOW \
sim:/pool/START \
sim:/pool/WINDOW_SIZE \
sim:/pool/WINDOW_SIZE2 \
sim:/pool/clk \
sim:/pool/division \
sim:/pool/sumD \
sim:/pool/sumQ
force -freeze sim:/pool/WINDOW 1111010000000000111101000000000011110100000000001111010000000000 0
force -freeze sim:/pool/clk 0 0, 1 {25 ps} -r 50
force -freeze sim:/pool/rst 1 0
run
force -freeze sim:/pool/rst 0 0
force -freeze sim:/pool/START 1 0
run
run
run
run
run
