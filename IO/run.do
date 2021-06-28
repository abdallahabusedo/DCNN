vsim -gui work.tb
add wave sim:/tb/*
run 6450850
mem save -o mem.mem -f {} /tb/tb_chip/ram/ram