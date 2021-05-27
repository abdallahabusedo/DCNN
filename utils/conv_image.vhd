LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY convolut_image IS
GENERIC (FILTER_SIZE : INTEGER := 3;IMG_SIZE : INTEGER := 5);
	PORT(
		IMG : IN  std_logic_vector(IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		FILTER1 : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		convoluted_img : OUT std_logic_vector((IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16-1 Downto 0);
		end_conv :OUT std_logic;
		clk,strat_signal,rst:IN std_logic
	);
END ENTITY;
ARCHITECTURE conv_image_arch OF convolut_image IS
COMPONENT conv_wimdow_1 IS 
	GENERIC (FILTER_SIZE : INTEGER);
	PORT(
		WINDOW : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		FILTER : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		PIXEL_OUT : OUT std_logic_vector(15 downto 0);
		end_conv :OUT std_logic;
		clk,strat_signal,rst:IN std_logic
	);
END COMPONENT;
----------------------------------------------------
component extract_window IS
	generic(FILTER_SIZE : integer ;IMG_SIZE : integer);
	PORT(
		IMG : IN std_logic_vector(IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		IMG_SIZE_in:IN integer;
		FILTER_SIZE_in:IN integer;
		rst:IN std_logic;
		OFFSET:IN integer;
		LAYER : OUT std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0)
	);
END COMPONENT;

TYPE conv_type IS array(0 TO (IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)-1)OF std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
SIGNAL WINDOW : conv_type;
SIGNAL y: std_logic_vector((IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16-1 Downto 0);

TYPE OFFSSET_type IS array(0 TO (IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)-1) OF unsigned(9 DOWNTO 0);
	SIGNAL OFFSSET : OFFSSET_type ;
	BEGIN
		OFFSSET(0)<=(OTHERS =>'0');	
		loop0: FOR i IN 1 TO (IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)-1 GENERATE 		
				OFFSSET(i) <= OFFSSET(i-1)+to_unsigned(FILTER_SIZE,10) when ( (to_integer(OFFSSET(i-1))+FILTER_SIZE )mod  IMG_SIZE)=0 else
       				OFFSSET(i-1)+"0000000001" ;
		END GENERATE;
		loop1: FOR i IN 0 TO (IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)-1   GENERATE 		
				fx0:extract_window GENERIC MAP (FILTER_SIZE,IMG_SIZE)PORT MAP(IMG,IMG_SIZE,FILTER_SIZE,rst,to_integer(OFFSSET(i)),WINDOW(i));
				fx1:conv_wimdow_1 GENERIC MAP (FILTER_SIZE)  PORT MAP(WINDOW(i),
					FILTER1,convoluted_img(i*16+15 downto i*16),end_conv,clk,strat_signal,rst);
   	
		END GENERATE;
END conv_image_arch;

