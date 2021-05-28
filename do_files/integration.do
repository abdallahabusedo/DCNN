vsim -gui work.cnn_integration
add wave -position insertpoint  \
sim:/cnn_integration/clk \
sim:/cnn_integration/START \
sim:/cnn_integration/rst \
sim:/cnn_integration/data_in \
sim:/cnn_integration/data_out \
sim:/cnn_integration/address \
sim:/cnn_integration/WR \
sim:/cnn_integration/Done

add wave -position insertpoint  \
sim:/cnn_integration/data_in \
sim:/cnn_integration/conv0_avg_imgs \
sim:/cnn_integration/conv0_END_conv \
sim:/cnn_integration/conv0_start_signal \
sim:/cnn_integration/pool0_OutFeatureMaps \
sim:/cnn_integration/pool0_done \
sim:/cnn_integration/pool0_start \
sim:/cnn_integration/read_img_enable \
sim:/cnn_integration/read_img_init_address \
sim:/cnn_integration/read_img_count \
sim:/cnn_integration/read_img_data_in \
sim:/cnn_integration/read_img_done \
sim:/cnn_integration/read_img_read_address \
sim:/cnn_integration/read_img_dataout \
sim:/cnn_integration/read_fil_enable \
sim:/cnn_integration/read_fil_init_address \
sim:/cnn_integration/read_fil_count \
sim:/cnn_integration/read_fil_data_in \
sim:/cnn_integration/read_fil_done \
sim:/cnn_integration/read_fil_read_address \
sim:/cnn_integration/read_fil_dataout \
sim:/cnn_integration/conv1_avg_imgs \
sim:/cnn_integration/conv1_END_conv \
sim:/cnn_integration/conv1_start_signal \
sim:/cnn_integration/pool0_start \
sim:/cnn_integration/START \
sim:/cnn_integration/conv2_avg_imgs \
sim:/cnn_integration/conv2_END_conv \
sim:/cnn_integration/conv2_start_signal \
sim:/cnn_integration/pool1_OutFeatureMaps \
sim:/cnn_integration/pool1_done \
sim:/cnn_integration/pool1_start \
sim:/cnn_integration/step_counter 
force -freeze sim:/cnn_integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/cnn_integration/rst 1 0
run
run
force -freeze sim:/cnn_integration/rst 0 0
force -freeze sim:/cnn_integration/START 1 0
force -freeze sim:/cnn_integration/data_in 0000100000000000 0
run 48500ps
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
run 700ps
force -freeze sim:/cnn_integration/data_in 0000100000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
run 800ps
force -freeze sim:/cnn_integration/data_in 0001000000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
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
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
run
run
run
run
run
run
force -freeze sim:/cnn_integration/data_in 0000100000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
run
run
run
run
run
run
run
run
force -freeze sim:/cnn_integration/data_in 0000100000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
run
run
run
run
run
run
run
run
force -freeze sim:/cnn_integration/data_in 0001000000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
run
run
run
run
run
run
run
run
force -freeze sim:/cnn_integration/data_in 0001000000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
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
force -freeze sim:/cnn_integration/data_in 0000100000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
run
run
run
run
run
run
run
run
force -freeze sim:/cnn_integration/data_in 0000100000000000 0
force -freeze sim:/cnn_integration/data_in 0000100000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
run
run
run
run
run
run
run
run
force -freeze sim:/cnn_integration/data_in 0000100000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
run
run
run
run
run
run
run
run
force -freeze sim:/cnn_integration/data_in 0000100000000000 0
run
force -freeze sim:/cnn_integration/data_in 0000000000000000 0
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