library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
use work.c_pkg.all;

ENTITY convolut_image IS
generic (FILTER_SIZE : integer := 3;IMG_SIZE : integer := 5);
	PORT(
		IMG : IN bus_array2;
		FILTER1 : IN bus_array4;
		convoluted_img : OUT bus_array2;
		clk:IN std_logic
	);
END ENTITY;
ARCHITECTURE conv_image_arch OF convolut_image IS
component conv_wimdow_1 IS 
	PORT(
		WINDOW : IN bus_array4;
		FILTER : IN bus_array4;
		PIXEL_OUT : OUT signed(31 DOWNTO 0);
		clk:IN std_logic
	);
END component;
----------------------------------------------------
component extract_window IS
	PORT(
		IMG : IN bus_array2;
		OFFSET:IN integer;
		LAYER : OUT bus_array4
	);
END component;

TYPE pixel_type IS array(0 TO 24)OF signed(31 DOWNTO 0);
SIGNAL item_out : pixel_type ;
SIGNAL OUT_LAYER:bus_array2;
TYPE conv_type IS array(0 TO 63)OF bus_array4;
SIGNAL WINDOW : conv_type;
TYPE OFFSSET_type IS array(0 TO 63) OF unsigned(9 DOWNTO 0);
	SIGNAL OFFSSET : OFFSSET_type := (
	0 => "0000000000",
	OTHERS => "0000000000");
	BEGIN
loop0: FOR i IN 1 TO (IMG_SIZE-FILTER_SIZE-1)*(IMG_SIZE-FILTER_SIZE-1)-1 GENERATE 			
				OFFSSET(i) <= OFFSSET(i-1)+"0000000011" when ( (to_integer(OFFSSET(i-1))+FILTER_SIZE )mod  IMG_SIZE)=0 else
       				OFFSSET(i-1)+"0000000001" ;
END GENERATE;
loop1: FOR i IN 0 TO (IMG_SIZE-FILTER_SIZE-1)*(IMG_SIZE-FILTER_SIZE-1)-1  GENERATE 		
				fx0:extract_window GENERIC MAP (FILTER_SIZE,IMG_SIZE)PORT MAP(IMG,to_integer(OFFSSET(i)),WINDOW(i));
				fx1:conv_wimdow_1 GENERIC MAP (FILTER_SIZE)  PORT MAP(WINDOW(i),FILTER1,item_out(i),clk);
				OUT_LAYER(i)<=item_out(i)(26 DOWNTO 11);
   	
END GENERATE;
convoluted_img<=OUT_LAYER;
END conv_image_arch;

