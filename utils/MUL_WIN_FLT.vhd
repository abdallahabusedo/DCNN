LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--Signed and unsigned types
USE IEEE.numeric_std.all;
USE IEEE.std_logic_unsigned.all;

package c_pkg is
        type bus_array1 is array(4 DOWNTO 0) of signed(15 DOWNTO 0);
        type bus_array2 is array(24 DOWNTO 0) of signed(15 DOWNTO 0);
	type bus_array5 is array(8 DOWNTO 0) of signed(31 DOWNTO 0);
	type bus_array4 is array(8 DOWNTO 0) of signed(15 DOWNTO 0);
end package;


library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
use work.c_pkg.all;

ENTITY MUL_WIN_FLT IS
	generic (FILTER_SIZE : integer := 3);
	PORT(
		WINDOW : IN bus_array4;
		FILTER : IN bus_array4;
		PIXEL : OUT bus_array5
	);
END ENTITY;
ARCHITECTURE MUL_WIN_FLT_arch OF MUL_WIN_FLT IS
	BEGIN
		loop0: FOR i IN 0 TO FILTER_SIZE*FILTER_SIZE-1 GENERATE 		
			PIXEL(i)<=(WINDOW(i)*FILTER(i));		
		END GENERATE;
	
END MUL_WIN_FLT_arch;
