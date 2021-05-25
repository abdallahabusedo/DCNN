add wave -position end  sim:/layer/biases
add wave -position end  sim:/layer/values
add wave -position end  sim:/layer/weights
add wave -position end  sim:/layer/enable
add wave -position end  sim:/layer/clk
add wave -position end  sim:/layer/ii

add wave -position end  sim:/layer/neurons_generation(0)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(0)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(0)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(0)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(0)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(0)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(0)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(0)/accumulator/state

add wave -position end  sim:/layer/neurons_generation(1)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(1)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(1)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(1)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(1)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(1)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(1)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(1)/accumulator/state

add wave -position end  sim:/layer/neurons_generation(2)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(2)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(2)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(2)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(2)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(2)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(2)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(2)/accumulator/state

add wave -position end  sim:/layer/neurons_generation(3)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(3)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(3)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(3)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(3)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(3)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(3)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(3)/accumulator/state

add wave -position end  sim:/layer/neurons_generation(4)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(4)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(4)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(4)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(4)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(4)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(4)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(4)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(4)/accumulator/state

add wave -position end  sim:/layer/neurons_generation(5)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(5)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(5)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(5)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(5)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(5)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(5)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(5)/accumulator/state

add wave -position end  sim:/layer/neurons_generation(6)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(6)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(6)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(6)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(6)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(6)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(6)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(6)/accumulator/state

add wave -position end  sim:/layer/neurons_generation(7)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(7)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(7)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(7)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(7)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(7)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(7)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(7)/accumulator/state

add wave -position end  sim:/layer/neurons_generation(8)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(8)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(8)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(8)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(8)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(8)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(8)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(8)/accumulator/state

add wave -position end  sim:/layer/neurons_generation(9)/neuron/multiplier/index
add wave -position end  sim:/layer/neurons_generation(9)/neuron/multiplier/m
add wave -position end  sim:/layer/neurons_generation(9)/neuron/multiplier/r
add wave -position end  sim:/layer/neurons_generation(9)/neuron/multiplier/result
add wave -position end  sim:/layer/neurons_generation(9)/neuron/adder/a
add wave -position end  sim:/layer/neurons_generation(9)/neuron/adder/b
add wave -position end  sim:/layer/neurons_generation(9)/neuron/new_acc
add wave -position end  sim:/layer/neurons_generation(9)/accumulator/state

force -freeze sim:/layer/enable 1 0
force -freeze sim:/layer/biases 16#00CC019902660333040004CC0599066607330800 0
force -freeze sim:/layer/values 16#08000A000E00 0
force -freeze sim:/layer/weights 16#026601990400026604000199019902660400019904000266040002660199040001990266020006000000020000000600060002000000060000000200 0
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
run
run
run