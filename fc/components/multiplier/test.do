add wave -position end  sim:/multiplier/m
add wave -position end  sim:/multiplier/r
add wave -position end sim:/multiplier/res
force -freeze sim:/multiplier/m 16'b0000000001000100 0
force -freeze sim:/multiplier/r 16'b1111111111111111 0
run