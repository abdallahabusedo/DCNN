vsim work.pooling_layer
add wave -position insertpoint  \
sim:/pooling_layer/Done \
sim:/pooling_layer/IMG_SIZE \
sim:/pooling_layer/InFeatureMaps \
sim:/pooling_layer/Maps_Count \
sim:/pooling_layer/MiniPoolDone \
sim:/pooling_layer/OutFeatureMaps \
sim:/pooling_layer/WINDOW_SIZE \
sim:/pooling_layer/clk \
sim:/pooling_layer/temp1 \
sim:/pooling_layer/tempPoolOut

force -freeze sim:/pooling_layer/clk 0 0, 1 {50 ps} -r 100

force -freeze sim:/pooling_layer/InFeatureMaps(0)(0) 0001100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(1) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(2) 0010100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(3) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(4) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(5) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(6) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(7) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(8) 0100100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(9) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(10) 0010100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(11) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(12) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(13) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(14) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(0)(15) 0000100000000000 0


force -freeze sim:/pooling_layer/InFeatureMaps(1)(0) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(1) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(2) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(3) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(4) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(5) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(6) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(7) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(8) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(9) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(10) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(11) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(12) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(13) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(14) 0000100000000000 0
force -freeze sim:/pooling_layer/InFeatureMaps(1)(15) 0000100000000000 0

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