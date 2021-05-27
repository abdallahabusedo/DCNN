
vsim -gui work.conv_wimdow_1(conv_window_arch)
# vsim -gui work.conv_wimdow_1(conv_window_arch) 
# Start time: 19:52:27 on May 26,2021
# Loading std.standard
# Loading ieee.fixed_float_types
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading ieee.math_real(body)
# Loading ieee.fixed_generic_pkg(body)
# Loading ieee.fixed_pkg
# Loading work.conv_wimdow_1(conv_window_arch)
# Loading work.mul_win_flt(mul_win_flt_arch)
# Loading work.sflop(sarchi)
# WARNING: No extended dataflow license exists
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
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: Aya  Hostname: AYA-PC  ProcessID: 2816
#           Attempting to use alternate WLF file "./wlfta7r1x5".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlfta7r1x5

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
