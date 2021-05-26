vsim -gui work.convolute_images
add wave -position insertpoint  \
sim:/convolute_images/FILTER_SIZE \
sim:/convolute_images/IMG_SIZE \
sim:/convolute_images/images_count \
sim:/convolute_images/filters_count \
sim:/convolute_images/IMGs \
sim:/convolute_images/FILTERs \
sim:/convolute_images/convoluted_imgs \


add wave -position insertpoint  \
sim:/convolute_images/avg_imgs
sim:/convolute_images/clk
force -freeze sim:/convolute_images/clk 0 0, 1 {50 ps} -r 100

force -freeze sim:/convolute_images/IMGs(0)(1)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(2)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(3)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(4)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(5)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(6)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(7)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(8)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(9)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(10) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(11) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(12) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(13) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(14) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(15) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(16) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(17) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(18) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(19) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(20) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(21) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(22) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(23) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(24) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(0)(0)  0000100000000000  0

force -freeze sim:/convolute_images/IMGs(1)(1)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(2)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(3)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(4)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(5)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(6)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(7)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(8)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(9)  0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(10) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(11) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(12) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(13) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(14) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(15) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(16) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(17) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(18) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(19) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(20) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(21) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(22) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(23) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(24) 0000100000000000 0
force -freeze sim:/convolute_images/IMGs(1)(0)  0000100000000000  0


force -freeze sim:/convolute_images/IMGs(2)(1)  0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(2)  0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(3)  0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(4)  0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(5)  0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(6)  0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(7)  0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(8)  0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(9)  0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(10) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(11) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(12) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(13) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(14) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(15) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(16) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(17) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(18) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(19) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(20) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(21) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(22) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(23) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(24) 0001100000000000 0
force -freeze sim:/convolute_images/IMGs(2)(0)  0001100000000000  0



 
 
force -freeze sim:/convolute_images/FILTERs(0)(0)  0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(0)(1)  0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(0)(2)  0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(0)(3)  0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(0)(4)  0000100000000000 0
force -freeze sim:/convolute_images/FILTERs(0)(5)  0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(0)(6)  0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(0)(7)  0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(0)(8)  0000000000000000 0
 
force -freeze sim:/convolute_images/FILTERs(1)(0) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(1)(1) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(1)(2) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(1)(3) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(1)(4) 0001000000000000 0
force -freeze sim:/convolute_images/FILTERs(1)(5) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(1)(6) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(1)(7) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(1)(8) 0000000000000000 0
 
force -freeze sim:/convolute_images/FILTERs(2)(0) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(2)(1) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(2)(2) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(2)(3) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(2)(4) 0001100000000000 0
force -freeze sim:/convolute_images/FILTERs(2)(5) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(2)(6) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(2)(7) 0000000000000000 0
force -freeze sim:/convolute_images/FILTERs(2)(8) 0000000000000000 0

