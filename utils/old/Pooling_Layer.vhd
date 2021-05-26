library ieee;
library work;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.c_pkg.all;

ENTITY pooling_layer IS
	generic (WINDOW_SIZE : integer := 2 ; Maps_Count : integer := 6 ;IMG_SIZE : integer := 4);
	PORT(
		InFeatureMaps : IN convolution_imags_type;                      
		OutFeatureMaps : OUT convolution_imags_type;	
		Done : OUT std_logic := '0';
		clk,START:IN std_logic
	);
END ENTITY;

ARCHITECTURE arch_pooling_layer OF pooling_layer IS
	COMPONENT pool_window IS
	generic (FILTER_SIZE : integer := 2;IMG_SIZE : integer := 4);
		PORT(
			IMG : IN img_array;
			clk,START :IN std_logic;
			Done : OUT std_logic;
			pool_img : OUT img_array
		);
	END component;
	
	SIGNAL MiniPoolDone,temp1 : std_logic_vector(0 TO Maps_Count-1);
	SIGNAL tempPoolOut : convolution_imags_type;
	
	BEGIN
		loop1: FOR i IN 0 TO Maps_Count-1 GENERATE 		
				fx0:pool_window GENERIC MAP (WINDOW_SIZE,IMG_SIZE)PORT MAP(InFeatureMaps(i),clk,START,MiniPoolDone(i),tempPoolOut(i));
				OutFeatureMaps(i) <= tempPoolOut(i);
		END GENERATE;
		
		temp1 <= (OTHERS => '1');
		Done <= '1' WHEN MiniPoolDone = temp1
				  ELSE '0';
	
END ARCHITECTURE;
