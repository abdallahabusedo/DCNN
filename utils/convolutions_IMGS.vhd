
LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY convolute_images IS
GENERIC (FILTER_SIZE : INTEGER := 3;IMG_SIZE : INTEGER := 5;images_count: INTEGER:=3;filters_count: INTEGER:=1);
	PORT(
		IMGs : IN std_logic_vector(images_count*IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		FILTERs : IN std_logic_vector(images_count*filters_count*FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		avg_imgs : OUT std_logic_vector(filters_count*(IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16-1 Downto 0);
		end_conv :OUT std_logic;
		clk,strat_signal,rst:IN std_logic
	);
END ENTITY;
ARCHITECTURE convolute_images_arch OF convolute_images IS
COMPONENT convolut_image IS
GENERIC (FILTER_SIZE : INTEGER := 3;IMG_SIZE : INTEGER := 5);
	PORT(
		IMG : IN  std_logic_vector(IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		FILTER1 : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		convoluted_img : OUT std_logic_vector((IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16-1 Downto 0);
		end_conv :OUT std_logic;
		clk,strat_signal,rst:IN std_logic
	);
END COMPONENT;
COMPONENT conv_avg IS
GENERIC (IMG_number : INTEGER := 3;IMG_SIZE : INTEGER := 5);
	PORT(
		img_arr :IN std_logic_vector(IMG_number*IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		start:IN integer;
		avg_img : OUT std_logic_vector(IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		end_conv :OUT std_logic;
		clk,strat_signal,rst:IN std_logic
	);
END COMPONENT;
signal strat_avg:std_logic:='0';
signal convoluted_imgs : std_logic_vector(images_count*filters_count*(IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16-1 Downto 0);
BEGIN
loop0: FOR i IN 0 TO filters_count-1 GENERATE 	
	loop1: FOR k IN 0 TO images_count-1 GENERATE 			
				fx0:convolut_image GENERIC MAP (FILTER_SIZE,IMG_SIZE)PORT MAP
				(IMGs((K*IMG_SIZE*IMG_SIZE*16)+(IMG_SIZE*IMG_SIZE*16)-1 downto (K*IMG_SIZE*IMG_SIZE*16) ),
				FILTERs(((i*images_count+k)*FILTER_SIZE*FILTER_SIZE*16)+(FILTER_SIZE*FILTER_SIZE*16) -1 downto ((i*images_count+k)*FILTER_SIZE*FILTER_SIZE*16)),
				convoluted_imgs(((i*images_count+k)*(IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16)+((IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16)-1 downto ((i*images_count+k)*(IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16)),
					strat_avg ,clk,strat_signal,rst); 	
	END GENERATE;
	CA0:conv_avg GENERIC MAP (images_count,IMG_SIZE-FILTER_SIZE+1)PORT MAP(
	convoluted_imgs (((i+1)*images_count*(IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16) -1 downto (i*images_count)*(IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16),0
	,avg_imgs(((i+1)*(IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16) -1 downto i*(IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16),end_conv ,clk,strat_avg,rst);

END GENERATE;

END convolute_images_arch;