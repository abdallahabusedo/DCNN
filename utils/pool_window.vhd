library ieee;
library work;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
use work.c_pkg.all;

ENTITY pool_window IS
generic (FILTER_SIZE : integer := 2;IMG_SIZE : integer := 4);
	PORT(
		IMG : IN img_array;
		pool_img : OUT img_array;
		clk:IN std_logic
	);
END ENTITY;

ARCHITECTURE pool_image_arch OF pool_window IS

component extract_window IS
	generic (FILTER_SIZE : integer ;IMG_SIZE : integer);
	PORT(
		IMG : IN img_array;
		OFFSET:IN integer;
		LAYER : OUT filter_array
	);
END component;

component Pool IS
	generic (WINDOW_SIZE : integer := 2);
	PORT(
		WINDOW : IN filter_array;
		AVR : OUT sfixed (4 downto -11);
		clk:IN std_logic 
	);
END component;

--donot forget to change sizes
TYPE pixel_type IS array(0 TO 24)OF sfixed (4 downto -11);
SIGNAL item_out : pixel_type ;
SIGNAL OUT_LAYER:img_array;
TYPE conv_type IS array(0 TO 63)OF filter_array;
SIGNAL WINDOW : conv_type;
TYPE OFFSSET_type IS array(0 TO 63) OF unsigned(9 DOWNTO 0);
SIGNAL OFFSSET : OFFSSET_type := (
	0 => "0000000000",
	OTHERS => "0000000000");
	
BEGIN
loop0: FOR i IN 1 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1 GENERATE 
	OFFSSET(i) <= OFFSSET(i-1)+"0000000010"+IMG_SIZE when( (to_integer(OFFSSET(i-1))+FILTER_SIZE )mod  IMG_SIZE)=0 else
	OFFSSET(i-1)+"0000000010" ;
END GENERATE;

loop1: FOR i IN 0 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1  GENERATE 
	fx0:extract_window GENERIC MAP (FILTER_SIZE,IMG_SIZE)PORT MAP(IMG,to_integer(OFFSSET(i)),WINDOW(i));
	fx1:Pool GENERIC MAP (FILTER_SIZE) PORT MAP(WINDOW(i),item_out(i),clk);
	OUT_LAYER(i)<=item_out(i);
END GENERATE;

pool_img<=OUT_LAYER;

END pool_image_arch;