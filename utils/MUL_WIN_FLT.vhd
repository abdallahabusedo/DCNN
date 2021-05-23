library ieee;
library work;
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.c_pkg.all;

ENTITY MUL_WIN_FLT IS
	generic (FILTER_SIZE : integer := 3);
	PORT(
		WINDOW : IN filter_array;
		FILTER : IN filter_array;
		PIXEL : OUT filter_array
	);
END ENTITY;
ARCHITECTURE MUL_WIN_FLT_arch OF MUL_WIN_FLT IS
	BEGIN
		loop0: FOR i IN 0 TO FILTER_SIZE*FILTER_SIZE-1 GENERATE 	
					PIXEL(i) <= resize (arg => WINDOW(i)*FILTER(i), 
									left_index => PIXEL(i)'high ,
									right_index => PIXEL(i)'low ,
									round_style => fixed_round, 
									overflow_style => fixed_saturate); 

				
		END GENERATE;
	
END MUL_WIN_FLT_arch;
