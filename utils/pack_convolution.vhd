LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;

package c_pkg is
    type img_array is array(1024 DOWNTO 0) of sfixed (4 downto -11);
	type filter_array is array(24 DOWNTO 0) of sfixed (4 downto -11);
	type feature_map_pooling is array(0 TO 15) OF img_array;
end package;