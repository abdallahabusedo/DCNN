LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;

PACKAGE c_pkg IS
	TYPE img_array IS ARRAY(0 TO 1024) of sfixed (4 DOWNTO -11);
	TYPE filter_array IS ARRAY(0 TO 24) of sfixed (4 DOWNTO -11);
	TYPE feature_map_pooling IS ARRAY(0 TO 15) OF img_array;
	TYPE convolution_imags_type IS ARRAY (0 TO 210*16-1) OF img_array;
	TYPE convolution_filtters_type IS ARRAY (0 TO 210*16-1)OF filter_array;
END PACKAGE;