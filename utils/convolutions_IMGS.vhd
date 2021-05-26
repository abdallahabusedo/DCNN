
library ieee;
library work;
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
use work.c_pkg.all;

ENTITY convolute_images IS
generic (FILTER_SIZE : integer := 3;IMG_SIZE : integer := 5;images_count: integer:=3;filters_count: integer:=1);
	PORT(
		IMGs : IN convolution_imags_type;
		FILTERs : IN convolution_filtters_type;
		avg_imgs : OUT convolution_imags_type;
		end_conv :OUT std_logic;
		clk,strat_signal:IN std_logic
	);
END ENTITY;
ARCHITECTURE convolute_images_arch OF convolute_images IS
component convolut_image IS
generic (FILTER_SIZE : integer := 3;IMG_SIZE : integer := 5);
	PORT(
		IMG : IN img_array;
		FILTER1 : IN filter_array;
		convoluted_img : OUT img_array;
		end_conv :OUT std_logic;
		clk,strat_signal:IN std_logic
	);
END component;
component conv_avg IS
generic (IMG_number : integer := 3;IMG_SIZE : integer := 5);
	PORT(
		img_arr :IN convolution_imags_type; -- for one block of images 
		start:IN integer;
		avg_img : OUT img_array;
		end_conv :OUT std_logic;
		clk,strat_signal:IN std_logic
	);
END component;
signal strat_avg:std_logic:='0';
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