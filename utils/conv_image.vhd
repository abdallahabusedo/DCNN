library ieee;
library work;
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
use work.c_pkg.all;

ENTITY convolut_image IS
generic (FILTER_SIZE : integer := 3;IMG_SIZE : integer := 5);
	PORT(
		IMG : IN img_array;
		FILTER1 : IN filter_array;
		convoluted_img : OUT img_array;
		end_conv :OUT std_logic;
		clk,strat_signal:IN std_logic
	);
END ENTITY;
ARCHITECTURE conv_image_arch OF convolut_image IS
component conv_wimdow_1 IS 
	generic (FILTER_SIZE : integer);
	PORT(
		WINDOW : IN filter_array;
		FILTER : IN filter_array;
		PIXEL_OUT : OUT sfixed (4 downto -11);
		end_conv :OUT std_logic;
		clk,strat_signal:IN std_logic
	);
END component;
----------------------------------------------------
component extract_window IS
	generic (FILTER_SIZE : integer ;IMG_SIZE : integer);
	PORT(
		IMG : IN img_array;
		OFFSET:IN integer;
		LAYER : OUT filter_array
	);
END component;

TYPE pixel_type IS array(0 TO 24)OF sfixed (4 downto -11);
SIGNAL item_out : pixel_type ;
SIGNAL OUT_LAYER:img_array;
TYPE conv_type IS array(0 TO 28*28)OF filter_array;
SIGNAL WINDOW : conv_type;
TYPE OFFSSET_type IS array(0 TO 28*28) OF unsigned(9 DOWNTO 0);
	SIGNAL OFFSSET : OFFSSET_type := (
	0 => "0000000000",
	OTHERS => "0000000000");
	BEGIN
loop0: FOR i IN 1 TO (IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)-1 GENERATE 			
				OFFSSET(i) <= OFFSSET(i-1)+to_unsigned(FILTER_SIZE,10) when ( (to_integer(OFFSSET(i-1))+FILTER_SIZE )mod  IMG_SIZE)=0 else
       				OFFSSET(i-1)+"0000000001" ;
END GENERATE;
loop1: FOR i IN 0 TO (IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)-1  GENERATE 		
				fx0:extract_window GENERIC MAP (FILTER_SIZE,IMG_SIZE)PORT MAP(IMG,to_integer(OFFSSET(i)),WINDOW(i));
				fx1:conv_wimdow_1 GENERIC MAP (FILTER_SIZE)  PORT MAP(WINDOW(i),
					FILTER1,item_out(i),end_conv,clk,strat_signal);
				OUT_LAYER(i)<=item_out(i);
   	
END GENERATE;
convoluted_img<=OUT_LAYER;
END conv_image_arch;

