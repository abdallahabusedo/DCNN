LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;

package c_pkg is
    --type img_array is array(0 to 24 ) of sfixed (4 downto -11);
	--type filter_array is array(0 to 9 ) of sfixed (4 downto -11);
	--type feature_map_pooling is array(0 TO 3) OF img_array;
	type img_array is array(0 TO 1024) of sfixed (4 downto -11);
	type filter_array is array(0 TO 24) of sfixed (4 downto -11);
	type feature_map_pooling is array(0 TO 15) OF img_array;
	type convolution_imags_type is array (0 TO 210*16-1) OF img_array;
	type convolution_filtters_type is array (0 TO 210*16-1)OF filter_array;
end package;