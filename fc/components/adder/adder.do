add wave -position end  sim:/adder/a
add wave -position end  sim:/adder/b
add wave -position end  sim:/adder/res
add wave -position end  sim:/adder/asf
add wave -position end  sim:/adder/bsf
add wave -position end  sim:/adder/ressf
force -freeze sim:/adder/a 2#0000100000000000 0
force -freeze sim:/adder/b 2#0000100000000000 0
run
force -freeze sim:/adder/a 2#0001100000000000 0
run
force -freeze sim:/adder/b 2#1111100000000000 0
run
force -freeze sim:/adder/b 0 0
run