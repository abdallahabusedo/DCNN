add wave -position end  sim:/accumulator/clk
add wave -position end  sim:/accumulator/d
add wave -position end  sim:/accumulator/rst
add wave -position end  sim:/accumulator/q
add wave -position end  sim:/accumulator/state
force -freeze sim:/accumulator/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/accumulator/d 16#FCFC 0
run
force -freeze sim:/accumulator/d 16#0001 0
run
force -freeze sim:/accumulator/rst 1 0
run
force -freeze sim:/accumulator/rst 0 0
force -freeze sim:/accumulator/d 12 0
run