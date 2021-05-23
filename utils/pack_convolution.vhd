LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
--package c_pkg is
--        type bus_array1 is array(1024 DOWNTO 0) of signed(15 DOWNTO 0); -- for Img-
--        type bus_array2 is array(784 DOWNTO 0) of signed(15 DOWNTO 0); -- for Img conv
--	type bus_array3 is array(13 DOWNTO 0) of signed(15 DOWNTO 0);
--	type bus_array4 is array(24 DOWNTO 0) of signed(15 DOWNTO 0); --for filtter
--end package;

package c_pkg is
        type img_array is array(1024 DOWNTO 0) of signed(15 DOWNTO 0);
	type MUL_array is array(24 DOWNTO 0) of signed(31 DOWNTO 0);
	type filter_array is array(24 DOWNTO 0) of signed(15 DOWNTO 0);
end package;