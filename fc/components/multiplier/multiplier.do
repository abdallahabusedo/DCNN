add wave -position end  sim:/multiplier/index
add wave -position 0  sim:/multiplier/m
add wave -position 1  sim:/multiplier/r
force -freeze sim:/multiplier/values 16#000C000B000A 0
force -freeze sim:/multiplier/weights 16#000300020001 0
force -freeze sim:/multiplier/index 1 0
run

# Multiply -2 * 0.875
force -freeze sim:/multiplier/m 2#0000011100000000 0
force -freeze sim:/multiplier/r 2#1111000000000000 0
run

# Multiply max_value * max_weight
force -freeze sim:/multiplier/r 2#0111111111111111 0
force -freeze sim:/multiplier/m 2#0000011111111111 0
run

# Multiply max_value * -max_weight
force -freeze sim:/multiplier/r 2#0111111111111111 0
force -freeze sim:/multiplier/m 2#1111100000000001 0
run

# Multiply -max_value * max_weight
force -freeze sim:/multiplier/r 2#1000000000000001 0
force -freeze sim:/multiplier/m 2#0000011111111111 0
run

# Multiply -max_value * -max_weight
force -freeze sim:/multiplier/r 2#1000000000000001 0
force -freeze sim:/multiplier/m 2#1111100000000001 0
run