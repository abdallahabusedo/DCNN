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
		IMG :  IN std_logic_vector((IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0);
		clk , START , rst :IN std_logic;
		Done : OUT std_logic;
		pool_img : OUT std_logic_vector((IMG_SIZE/2)*(IMG_SIZE/2)*16-1 Downto 0)
	);
END ENTITY;

ARCHITECTURE pool_image_arch OF pool_window IS

	component extract_window IS
		generic (FILTER_SIZE : INTEGER ;IMG_SIZE : INTEGER);
		PORT(
			IMG : IN std_logic_vector(IMG_SIZE*IMG_SIZE*16-1 Downto 0);
			IMG_SIZE_in:IN integer;
			FILTER_SIZE_in:IN integer;
			rst:IN std_logic;
			OFFSET:IN integer;
			LAYER : OUT std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0)
		);
	END component;

	component Pool IS
		generic (WINDOW_SIZE : INTEGER := 2);
		PORT(
			WINDOW : IN std_logic_vector((WINDOW_SIZE*WINDOW_SIZE*16)-1 DOWNTO 0);
			START,rst,clk : IN std_logic;
			AVR : OUT std_logic_vector(15 downto 0);
			Done : OUT std_logic
		);
	END component;

	TYPE conv_type IS array(0 TO ((IMG_SIZE/2)*(IMG_SIZE/2) -1))OF std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
	TYPE OFFSSET_type IS array(0 TO ((IMG_SIZE/2)*(IMG_SIZE/2) -1)) OF unsigned(9 DOWNTO 0);

	SIGNAL WINDOW : conv_type;
	SIGNAL OFFSSET : OFFSSET_type ;
	SIGNAL MiniPoolDone,temp1 : std_logic_vector(0 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1);
		
	BEGIN
		OFFSSET(0)<=(OTHERS =>'0');	
		loop0: FOR i IN 1 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1 GENERATE 
			OFFSSET(i) <= OFFSSET(i-1)+"0000000010"+IMG_SIZE when( (to_integer(OFFSSET(i-1))+FILTER_SIZE )mod  IMG_SIZE)=0 else
			OFFSSET(i-1)+"0000000010" ;
		END GENERATE;

		loop1: FOR i IN 0 TO (IMG_SIZE/2)*(IMG_SIZE/2)-1  GENERATE 
			fx0:extract_window GENERIC MAP (FILTER_SIZE,IMG_SIZE)PORT MAP(IMG,IMG_SIZE,FILTER_SIZE,rst,to_integer(OFFSSET(i)),WINDOW(i));

			fx1:Pool GENERIC MAP (FILTER_SIZE) PORT MAP(WINDOW(i),START,rst,clk,pool_img(i*16+15 DOWNTO i*16),MiniPoolDone(i));

		END GENERATE;

		temp1 <= (OTHERS => '1');
		Done <= '1' WHEN MiniPoolDone = temp1
				  ELSE '0';

	END pool_image_arch;