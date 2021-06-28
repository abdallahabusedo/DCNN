
vsim -gui work.conv_wimdow_1(conv_window_arch)
add wave -position insertpoint  \
sim:/conv_wimdow_1/FILTER_SIZE \
sim:/conv_wimdow_1/WINDOW \
sim:/conv_wimdow_1/FILTER \
sim:/conv_wimdow_1/PIXEL_OUT \
sim:/conv_wimdow_1/end_conv \
sim:/conv_wimdow_1/clk \
sim:/conv_wimdow_1/strat_signal \
sim:/conv_wimdow_1/MUL_PIX_FIT \
sim:/conv_wimdow_1/D \
sim:/conv_wimdow_1/Q

force -freeze sim:/conv_wimdow_1/WINDOW 000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000 0
force -freeze sim:/conv_wimdow_1/FILTER 000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000 0
force -freeze sim:/conv_wimdow_1/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/conv_wimdow_1/strat_signal 1 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/conv_wimdow_1/strat_signal 0 0
run
run
run
force -freeze sim:/conv_wimdow_1/WINDOW 000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000 0
run
run
run
force -freeze sim:/conv_wimdow_1/strat_signal 1 0
run
run
run
run
run
run
run
