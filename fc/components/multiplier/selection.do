add wave -position end  sim:/multiplier/index
add wave -position end  sim:/multiplier/values
add wave -position end  sim:/multiplier/weights
add wave -position end  sim:/multiplier/m
add wave -position end  sim:/multiplier/r
force -freeze sim:/multiplier/values 16#000C000B000A 0
force -freeze sim:/multiplier/weights 16#000300020001 0
force -freeze sim:/multiplier/index 0 0
run
force -freeze sim:/multiplier/index 10#1 0
run
force -freeze sim:/multiplier/index 10#2 0
run
force -freeze sim:/multiplier/index 10#3 0
run