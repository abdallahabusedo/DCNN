vsim -gui work.pool_window
add wave -position insertpoint  \
sim:/pool_window/FILTER_SIZE \
sim:/pool_window/IMG_SIZE \
sim:/pool_window/IMG \
sim:/pool_window/clk \
sim:/pool_window/Done \
sim:/pool_window/REST \
sim:/pool_window/pool_img \
sim:/pool_window/item_out \
sim:/pool_window/OUT_LAYER \
sim:/pool_window/WINDOW \
sim:/pool_window/OFFSSET \
sim:/pool_window/MiniPoolDone \
sim:/pool_window/temp1
force -freeze sim:/pool_window/clk 0 0, 1 {50 ps} -r 100
# mem load -i D:/V_Project_new/VLSI/window.mem -startaddress 0 -endaddress 24 /pool_window/IMG
force -freeze sim:/pool_window/IMG 0000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000 0
run                                                                                                        
run
run
run
run
run
run
run
run