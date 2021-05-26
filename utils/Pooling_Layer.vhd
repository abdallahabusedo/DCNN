LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.c_pkg.ALL;

ENTITY pooling_layer IS
	GENERIC (WINDOW_SIZE : INTEGER := 2 ; Maps_Count : INTEGER := 6 ;IMG_SIZE : INTEGER := 4);
	PORT(
		InFeatureMaps : IN convolution_imags_type;                      
		OutFeatureMaps : OUT convolution_imags_type;	
		Done : OUT STD_LOGIC := '0';
		clk,START:IN STD_LOGIC
	);
END ENTITY;

ARCHITECTURE arch_pooling_layer OF pooling_layer IS
	COMPONENT pool_window IS
	GENERIC (FILTER_SIZE : INTEGER := 2;IMG_SIZE : INTEGER := 4);
		PORT(
			IMG : IN img_array;
			clk,START :IN STD_LOGIC;
			Done : OUT STD_LOGIC;
			pool_img : OUT img_array
		);
	END COMPONENT;
	
	SIGNAL MiniPoolDone,temp1 : STD_LOGIC_VECTOR(0 TO Maps_Count-1);
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
