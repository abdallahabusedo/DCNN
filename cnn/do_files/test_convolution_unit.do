
vsim -gui work.convolut_image(conv_image_arch)
add wave -position END  sim:/convolut_image/FILTER_SIZE
add wave -position END  sim:/convolut_image/IMG_SIZE
add wave -position END  sim:/convolut_image/IMG
add wave -position END  sim:/convolut_image/FILTER1
add wave -position END  sim:/convolut_image/convoluted_img
add wave -position END  sim:/convolut_image/clk
add wave -position END  sim:/convolut_image/item_out
add wave -position END  sim:/convolut_image/OUT_LAYER
add wave -position END  sim:/convolut_image/WINDOW
add wave -position END  sim:/convolut_image/OFFSSET
force -freeze sim:/convolut_image/clk 0 0, 1 {50 ps} -r 100

force -freeze sim:/convolut_image/IMG(24) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(23) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(22) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(21) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(20) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(19) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(18) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(17) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(16) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(15) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(14) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(13) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(12) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(11) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(10) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(9) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(8) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(7) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(6) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(5) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(4) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(3) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(2) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(1) 0000110000000000 0
force -freeze sim:/convolut_image/IMG(0) 0000110000000000 0
force -freeze sim:/convolut_image/FILTER1(8) 1111110000000000 0
force -freeze sim:/convolut_image/FILTER1(7) 10#0 0
force -freeze sim:/convolut_image/FILTER1(6) 10#0 0
force -freeze sim:/convolut_image/FILTER1(5) 10#0 0
force -freeze sim:/convolut_image/FILTER1(4) 1111110000000000 0
force -freeze sim:/convolut_image/FILTER1(3) 10#0 0
force -freeze sim:/convolut_image/FILTER1(2) 10#0 0
force -freeze sim:/convolut_image/FILTER1(1) 10#0 0
force -freeze sim:/convolut_image/FILTER1(0) 1111110000000000 0
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