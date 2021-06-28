vsim -gui work.extract_window(extract_window_arch)
add wave -position insertpoint  \
sim:/extract_window/FILTER_SIZE \
sim:/extract_window/IMG_SIZE \
sim:/extract_window/IMG \
sim:/extract_window/IMG_SIZE_in \
sim:/extract_window/FILTER_SIZE_in \
sim:/extract_window/rst \
sim:/extract_window/OFFSET \
sim:/extract_window/LAYER \
force -freeze sim:/extract_window/IMG_SIZE_in 5 0
force -freeze sim:/extract_window/FILTER_SIZE_in 3 0
force -freeze sim:/extract_window/rst 1 0
force -freeze sim:/extract_window/OFFSET 5 0
force -freeze sim:/extract_window/IMG 0000100000000000000010010000000000011000000000000001100000000000000010000000000000001000000000000000100010000000000010000100000000001000000001000000100010000000001010000000000001001000000000000000100000010000001010000000000000001000001000000000100010000000000010000000000000101001000000000001100000000000000110000000000000101000000000000000100100000000000010001000000000001000110000000000100000100000 0
run

#FOR OFFSET 5 out should be 
000010000100000000001000000001000000100010000000000010000001000000101000000000000000100000100000001010010000000000011000000000000001000000000000


# IMG
# 0000100000000000   0000100100000000   0001100000000000   0001100000000000   0000100000000000
#      PIXEL 24            PIXEL 23          PIXEL 22           PIXEL 21            PIXEL 20
# 0000100000000000   0000100010000000   0000100001000000   0000100000000100   0000100010000000
#      PIXEL 19            PIXEL 18          PIXEL 17           PIXEL 16            PIXEL 15
# 0010100000000000   0100100000000000   0000100000010000   0010100000000000   0000100000100000
#      PIXEL 14            PIXEL 13          PIXEL 12           PIXEL 11            PIXEL 10
# 0000100010000000   0000100000000000   0010100100000000   0001100000000000   0001000000000000
#        PIXEL 9            PIXEL 8          PIXEL 7           PIXEL 6            PIXEL 5
# 0010100000000000   0000100100000000   0000100010000000   0000100011000000   0000100000100000
#        PIXEL 4            PIXEL 3          PIXEL 2           PIXEL 1            PIXEL 0
