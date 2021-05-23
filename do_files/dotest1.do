vsim -gui work.pool_window
# vsim -gui work.pool_window 
# Start time: 06:38:45 on May 23,2021
# Loading std.standard
# Loading ieee.fixed_float_types
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading ieee.math_real(body)
# Loading ieee.fixed_generic_pkg(body)
# Loading ieee.fixed_pkg
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.c_pkg
# Loading work.pool_window(pool_image_arch)
# Loading work.extract_window(extract_window_arch)
# Loading ieee.float_generic_pkg(body)
# Loading ieee.float_pkg
# Loading work.pool(arch_pool)
# Loading work.sflop(sarchi)
add wave -position insertpoint  \
sim:/pool_window/FILTER_SIZE \
sim:/pool_window/IMG_SIZE \
sim:/pool_window/IMG \
sim:/pool_window/pool_img \
sim:/pool_window/clk \
sim:/pool_window/item_out \
sim:/pool_window/OUT_LAYER \
sim:/pool_window/WINDOW \
sim:/pool_window/OFFSSET
force -freeze sim:/pool_window/clk 0 0, 1 {50 ps} -r 100
mem load -i D:/V_Project_new/VLSI/window.mem -startaddress 0 -endaddress 24 /pool_window/IMG
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /pool_window/loop1(3)/fx1
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /pool_window/loop1(2)/fx1
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /pool_window/loop1(1)/fx1
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /pool_window/loop1(0)/fx1
run
run
run
run
run
run
run
run