
LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.c_pkg.ALL;

ENTITY convolute_images IS
GENERIC (FILTER_SIZE : INTEGER := 3;IMG_SIZE : INTEGER := 5;images_count: INTEGER:=3;filters_count: INTEGER:=1);
	PORT(
		IMGs : IN convolution_imags_type;
		FILTERs : IN convolution_filtters_type;
		avg_imgs : OUT convolution_imags_type;
		end_conv :OUT STD_LOGIC;
		clk,strat_signal:IN STD_LOGIC
	);
END ENTITY;
ARCHITECTURE convolute_images_arch OF convolute_images IS
COMPONENT convolut_image IS
GENERIC (FILTER_SIZE : INTEGER := 3;IMG_SIZE : INTEGER := 5);
	PORT(
		IMG : IN img_array;
		FILTER1 : IN filter_array;
		convoluted_img : OUT img_array;
		end_conv :OUT STD_LOGIC;
		clk,strat_signal:IN STD_LOGIC
	);
END COMPONENT;
COMPONENT conv_avg IS
GENERIC (IMG_number : INTEGER := 3;IMG_SIZE : INTEGER := 5);
	PORT(
		img_arr :IN convolution_imags_type; -- for one block of images 
		start:IN INTEGER;
		avg_img : OUT img_array;
		end_conv :OUT STD_LOGIC;
		clk,strat_signal:IN STD_LOGIC
	);
END COMPONENT;
signal strat_avg:STD_LOGIC:='0';
signal convoluted_imgs : convolution_imags_type;
BEGIN
loop0: FOR i IN 0 TO filters_count-1 GENERATE 	
	loop1: FOR k IN 0 TO images_count-1 GENERATE 			
				fx0:convolut_image GENERIC MAP (FILTER_SIZE,IMG_SIZE)PORT MAP
				(IMGs(k),FILTERs(i*images_count+k),convoluted_imgs(i*images_count+k),
					strat_avg ,clk,strat_signal);   	
	END GENERATE;
	CA0:conv_avg GENERIC MAP (images_count,IMG_SIZE-FILTER_SIZE+1)PORT MAP(convoluted_imgs 
	,i*images_count,avg_imgs(i),end_conv ,clk,strat_avg);

END GENERATE;

END convolute_images_arch;