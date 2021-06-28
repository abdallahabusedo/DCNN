LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MUL_WIN_FLT IS
	GENERIC (FILTER_SIZE : INTEGER := 3);
	PORT(
		WINDOW : IN STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0);
		FILTER : IN STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0);
		PIXEL : OUT STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE MUL_WIN_FLT_arch OF MUL_WIN_FLT IS
	TYPE pixel_type IS ARRAY(0 TO FILTER_SIZE*FILTER_SIZE-1)OF sfixed (4 DOWNTO -11);
SIGNAL PIXEL_sfixed:pixel_type;
	BEGIN
		loop0: FOR i IN 0 TO FILTER_SIZE*FILTER_SIZE-1 GENERATE	 	
			PIXEL_sfixed(i) <= resize (arg =>to_sfixed( WINDOW( i*16+15 DOWNTO i*16 ),4,-11)*to_sfixed(FILTER(i*16+15 DOWNTO i*16),4,-11), 
						left_index => PIXEL_sfixed(i)'HIGH ,
						right_index => PIXEL_sfixed(i)'LOW ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate);
			PIXEL(i*16+15 DOWNTO i*16 )<= to_slv (PIXEL_sfixed(i));
		END GENERATE;
	
END MUL_WIN_FLT_arch;
