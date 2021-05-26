LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.c_pkg.ALL;

ENTITY pool_window IS
	generic (FILTER_SIZE : INTEGER := 2;IMG_SIZE : INTEGER := 4);
	PORT(
		IMG :  IN STD_LOGIC_VECTOR((IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0);
		clk :IN STD_LOGIC;
		Done : OUT STD_LOGIC;
		REST:IN STD_LOGIC;
		pool_img : OUT STD_LOGIC_VECTOR((IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE pool_image_arch OF pool_window IS

	component extract_window IS
		generic (FILTER_SIZE : INTEGER ;IMG_SIZE : INTEGER);
		PORT(
		IMG : IN STD_LOGIC_VECTOR(IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		IMG_SIZE_in:IN INTEGER;
		FILTER_SIZE_in:IN INTEGER;
		REST:IN STD_LOGIC;
		OFFSET:IN INTEGER;
		LAYER : OUT STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0)
		);
	END component;

	component Pool IS
		generic (WINDOW_SIZE : INTEGER := 2);
		PORT(
		WINDOW : IN STD_LOGIC_VECTOR((WINDOW_SIZE*WINDOW_SIZE*16)-1 DOWNTO 0);
		AVR : OUT sfixed (4 DOWNTO -11);	
		Done : OUT STD_LOGIC := '0';
		REST:IN STD_LOGIC;
		clk:IN STD_LOGIC 
		);
	END component;

	--donot forget to change sizes

	TYPE pixel_type IS array(0 TO 24)OF sfixed (4 DOWNTO -11);
	SIGNAL item_out : pixel_type ;
	--SIGNAL item_out : sfixed (4 DOWNTO -11);
	SIGNAL OUT_LAYER:STD_LOGIC_VECTOR((IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0);
	--TYPE conv_type IS array(0 TO 63)OF filter_array;
	TYPE conv_type IS array(0 TO ((IMG_SIZE/2)*(IMG_SIZE/2) -1))OF STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
	--SIGNAL WINDOW : IS array(0 TO 63) STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
	
	SIGNAL WINDOW : conv_type;
	TYPE OFFSSET_type IS array(0 TO 63) OF unsigned(9 DOWNTO 0);
	--IF(REST=1)THEN
	SIGNAL OFFSSET : OFFSSET_type := (
		0 => "0000000000",
		OTHERS => "0000000000");
	--END if;	
	SIGNAL MiniPoolDone,temp1 : STD_LOGIC_VECTOR(0 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1);
		
	BEGIN
		loop0: FOR i IN 1 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1 GENERATE 
			OFFSSET(i) <= OFFSSET(i-1)+"0000000010"+IMG_SIZE when( (to_integer(OFFSSET(i-1))+FILTER_SIZE )mod  IMG_SIZE)=0 else
			OFFSSET(i-1)+"0000000010" ;
		END GENERATE;

		loop1: FOR i IN 0 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1  GENERATE 
			fx0:extract_window GENERIC MAP (FILTER_SIZE,IMG_SIZE)PORT MAP(IMG,IMG_SIZE,FILTER_SIZE,REST,to_integer(OFFSSET(i)),WINDOW(i));

			fx1:Pool GENERIC MAP (FILTER_SIZE) PORT MAP(WINDOW(i),item_out(i),MiniPoolDone(i),REST,clk);

			OUT_LAYER(i*16+15 DOWNTO i*16)<=to_slv(item_out(i));
		END GENERATE;

		pool_img<=OUT_LAYER;
		temp1 <= (OTHERS => '1');
		Done <= '1' WHEN MiniPoolDone = temp1
				  ELSE '0';

	END pool_image_arch;