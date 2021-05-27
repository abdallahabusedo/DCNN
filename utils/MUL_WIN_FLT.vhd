LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MUL_WIN_FLT IS
	GENERIC (FILTER_SIZE : INTEGER := 3);
	PORT(
		WINDOW : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		FILTER : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		PIXEL : OUT std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0)
	);
END ENTITY;
ARCHITECTURE MUL_WIN_FLT_arch OF MUL_WIN_FLT IS
TYPE pixel_type IS array(0 TO FILTER_SIZE*FILTER_SIZE-1)OF sfixed (4 downto -11);
signal PIXEL_sfixed:pixel_type;
	BEGIN
		loop0: FOR i IN 0 TO FILTER_SIZE*FILTER_SIZE-1 GENERATE	 	
			PIXEL_sfixed(i) <= resize (arg =>to_sfixed( WINDOW( i*16+15 Downto i*16 ),4,-11)*to_sfixed(FILTER(i*16+15 Downto i*16),4,-11), 
						left_index => PIXEL_sfixed(i)'high ,
						right_index => PIXEL_sfixed(i)'low ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate);
			PIXEL(i*16+15 Downto i*16 )<= to_slv (PIXEL_sfixed(i));
		END GENERATE;
	
END MUL_WIN_FLT_arch;
