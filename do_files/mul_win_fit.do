vsim -gui work.mul_win_flt(mul_win_flt_arch)
force -freeze sim:/mul_win_flt/WINDOW UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU 0

force -freeze sim:/mul_win_flt/WINDOW 000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000 0
force -freeze sim:/mul_win_flt/FILTER UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU 0
force -freeze sim:/mul_win_flt/FILTER 000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000 0
run
force -freeze sim:/mul_win_flt/WINDOW 000010000000000000011000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000 0
run