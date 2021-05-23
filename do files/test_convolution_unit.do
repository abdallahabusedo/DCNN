
vsim -gui work.convolut_image(conv_image_arch)
# vsim -gui work.convolut_image(conv_image_arch) 
# Start time: 04:36:37 on May 23,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.c_pkg
# Loading work.convolut_image(conv_image_arch)
# Loading work.extract_window(extract_window_arch)
# Loading work.conv_wimdow_1(conv_window_arch)
# Loading work.mul_win_flt(mul_win_flt_arch)
# Loading work.flop(archi)
# WARNING: No extended dataflow license exists
add wave -position end  sim:/convolut_image/FILTER_SIZE
add wave -position end  sim:/convolut_image/IMG_SIZE
add wave -position end  sim:/convolut_image/IMG
add wave -position end  sim:/convolut_image/FILTER1
add wave -position end  sim:/convolut_image/convoluted_img
add wave -position end  sim:/convolut_image/clk
add wave -position end  sim:/convolut_image/item_out
add wave -position end  sim:/convolut_image/OUT_LAYER
add wave -position end  sim:/convolut_image/WINDOW
add wave -position end  sim:/convolut_image/OFFSSET
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: Aya  Hostname: AYA-PC  ProcessID: 13216
#           Attempting to use alternate WLF file "./wlftc13crs".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftc13crs
force -freeze sim:/convolut_image/clk 0 0, 1 {50 ps} -r 100

force -freeze sim:/convolut_image/IMG(24) 10#24 0
force -freeze sim:/convolut_image/IMG(23) 10#23 0
force -freeze sim:/convolut_image/IMG(22) 10#22 0
force -freeze sim:/convolut_image/IMG(21) 10#21 0
force -freeze sim:/convolut_image/IMG(20) 10#20 0
force -freeze sim:/convolut_image/IMG(19) 10#19 0
force -freeze sim:/convolut_image/IMG(18) 10#18 0
force -freeze sim:/convolut_image/IMG(17) 10#17 0
force -freeze sim:/convolut_image/IMG(16) 10#16 0
force -freeze sim:/convolut_image/IMG(15) 10#15 0
force -freeze sim:/convolut_image/IMG(14) 10#14 0
force -freeze sim:/convolut_image/IMG(13) 10#13 0
force -freeze sim:/convolut_image/IMG(12) 10#12 0
force -freeze sim:/convolut_image/IMG(11) 10#11 0
force -freeze sim:/convolut_image/IMG(10) 10#10 0
force -freeze sim:/convolut_image/IMG(9) 10#9 0
force -freeze sim:/convolut_image/IMG(8) 10#8 0
force -freeze sim:/convolut_image/IMG(7) 10#7 0
force -freeze sim:/convolut_image/IMG(6) 10#6 0
force -freeze sim:/convolut_image/IMG(5) 10#5 0
force -freeze sim:/convolut_image/IMG(4) 10#4 0
force -freeze sim:/convolut_image/IMG(3) 10#3 0
force -freeze sim:/convolut_image/IMG(2) 10#2 0
force -freeze sim:/convolut_image/IMG(1) 10#1 0
force -freeze sim:/convolut_image/IMG(0) 10#0 0
force -freeze sim:/convolut_image/FILTER1(8) 10#1 0
force -freeze sim:/convolut_image/FILTER1(7) 10#0 0
force -freeze sim:/convolut_image/FILTER1(6) 10#0 0
force -freeze sim:/convolut_image/FILTER1(5) 10#0 0
force -freeze sim:/convolut_image/FILTER1(4) 10#1 0
force -freeze sim:/convolut_image/FILTER1(3) 10#0 0
force -freeze sim:/convolut_image/FILTER1(2) 10#0 0
force -freeze sim:/convolut_image/FILTER1(1) 10#0 0
force -freeze sim:/convolut_image/FILTER1(0) 10#1 0
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