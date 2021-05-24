add wave -position end sim:/neuron/bias
add wave -position end  sim:/neuron/weights
add wave -position end  sim:/neuron/values
add wave -position end  sim:/neuron/index
add wave -position end  sim:/neuron/acc
add wave -position end  sim:/neuron/mult_out
add wave -position end  sim:/neuron/adder_opd_2
add wave -position end  sim:/neuron/new_acc
add wave -position end  sim:/neuron/multiplier/m
add wave -position end  sim:/neuron/multiplier/msf
add wave -position end  sim:/neuron/multiplier/r
add wave -position end  sim:/neuron/multiplier/rsf
add wave -position end  sim:/neuron/multiplier/ressf
add wave -position end  sim:/neuron/adder/asf
add wave -position end  sim:/neuron/adder/bsf
add wave -position end  sim:/neuron/adder/ressf

force -freeze sim:/neuron/bias 2#1111111111011011 0
force -freeze sim:/neuron/weights 16#01100004FFF4 0
force -freeze sim:/neuron/values 16#000900130044 0
force -freeze sim:/neuron/acc 0 0


force -freeze sim:/neuron/index 0 0
run
force -freeze sim:/neuron/index 1 0
run
force -freeze sim:/neuron/index 2 0
run
force -freeze sim:/neuron/index 2 0
run
force -freeze sim:/neuron/index 3 0
run
