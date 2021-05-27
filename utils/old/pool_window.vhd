LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.c_pkg.ALL;

ENTITY pool_window IS
	GENERIC (FILTER_SIZE : INTEGER := 2;IMG_SIZE : INTEGER := 4);
	PORT(
		IMG : IN img_array;
		START : IN STD_LOGIC;
		clk :IN STD_LOGIC;
		Done : OUT STD_LOGIC;
		pool_img : OUT img_array
	);
END ENTITY;

ARCHITECTURE pool_image_arch OF pool_window IS

	COMPONENT extract_window IS
		GENERIC (FILTER_SIZE : INTEGER ;IMG_SIZE : INTEGER);
		PORT(
			IMG : IN img_array;
			OFFSET:IN INTEGER;
			LAYER : OUT filter_array
		);
	END COMPONENT;

	COMPONENT Pool IS
		GENERIC (WINDOW_SIZE : INTEGER := 2);
		PORT(
			WINDOW : IN filter_array;
			START : IN STD_LOGIC;
			AVR : OUT sfixed (4 DOWNTO -11);
			Done : OUT STD_LOGIC := '0';
			clk:IN STD_LOGIC 
		);
	END COMPONENT;

	--donot forget to change sizes
	TYPE pixel_type IS ARRAY(0 TO 24)OF sfixed (4 DOWNTO -11);
	SIGNAL item_out : pixel_type ;
	SIGNAL OUT_LAYER:img_array;
	TYPE conv_type IS ARRAY(0 TO 63)OF filter_array;
	SIGNAL WINDOW : conv_type;
	TYPE OFFSSET_type IS ARRAY(0 TO 63) OF unsigned(9 DOWNTO 0);
	SIGNAL OFFSSET : OFFSSET_type := (
		0 => "0000000000",
		OTHERS => "0000000000");
		
	SIGNAL MiniPoolDone,temp1 : STD_LOGIC_VECTOR(0 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1);
		
	BEGIN
		loop0: FOR i IN 1 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1 GENERATE 
			OFFSSET(i) <= OFFSSET(i-1)+"0000000010"+IMG_SIZE when( (to_integer(OFFSSET(i-1))+FILTER_SIZE )mod  IMG_SIZE)=0 else
			OFFSSET(i-1)+"0000000010" ;
		END GENERATE;

		loop1: FOR i IN 0 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1  GENERATE 
			fx0:extract_window GENERIC MAP (FILTER_SIZE,IMG_SIZE)PORT MAP(IMG,to_integer(OFFSSET(i)),WINDOW(i));
			fx1:Pool GENERIC MAP (FILTER_SIZE) PORT MAP(WINDOW(i),START,item_out(i),MiniPoolDone(i),clk);
			OUT_LAYER(i)<=item_out(i);
		END GENERATE;

		pool_img<=OUT_LAYER;
		temp1 <= (OTHERS => '1');
		Done <= '1' WHEN MiniPoolDone = temp1
				  ELSE '0';

	END pool_image_arch;
	
	
	
	