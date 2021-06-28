LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.c_pkg.ALL;
ENTITY pooling_layer IS
	GENERIC (WINDOW_SIZE : INTEGER := 2 ; Maps_Count : INTEGER := 2 ;IMG_SIZE : INTEGER := 8);
	PORT(
		InFeatureMaps : IN  STD_LOGIC_VECTOR((Maps_Count*IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0);                     
		rst , START , clk:IN STD_LOGIC;
		OutFeatureMaps : OUT STD_LOGIC_VECTOR((Maps_Count*(IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO 0);	
		Done : OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE arch_pooling_layer OF pooling_layer IS

	COMPONENT pool_window IS
	GENERIC (FILTER_SIZE : INTEGER := 2;IMG_SIZE : INTEGER := 4);
		PORT(
			IMG :  IN STD_LOGIC_VECTOR((IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0);
			clk , START , rst :IN STD_LOGIC;
			Done : OUT STD_LOGIC;
			pool_img : OUT STD_LOGIC_VECTOR((IMG_SIZE/2)*(IMG_SIZE/2)*16-1 DOWNTO 0)
		);
	END COMPONENT;
	
	SIGNAL MiniPoolDone,temp1 : STD_LOGIC_VECTOR(0 TO Maps_Count-1);
	SIGNAL tempPoolOut : STD_LOGIC_VECTOR((Maps_Count*(IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO 0);
	
	BEGIN
	PROCESS(rst)
		BEGIN
			IF(rst = '1') THEN 
				temp1 <= (OTHERS => '1');
			END IF;
	END PROCESS;

	loop1: FOR i IN 0 TO Maps_Count-1 GENERATE 		
		fx0:pool_window GENERIC MAP (WINDOW_SIZE,IMG_SIZE)PORT MAP(InFeatureMaps((i*IMG_SIZE*IMG_SIZE*16) + (IMG_SIZE*IMG_SIZE*16)-1 DOWNTO i*IMG_SIZE*IMG_SIZE*16),clk,START,rst,MiniPoolDone(i),tempPoolOut((i*IMG_SIZE/2*IMG_SIZE/2*16) + ((IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO i*(IMG_SIZE/2)*(IMG_SIZE/2)*16));
		
		OutFeatureMaps((i*(IMG_SIZE/2)*(IMG_SIZE/2)*16) + ((IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO i*(IMG_SIZE/2)*(IMG_SIZE/2)*16) <= tempPoolOut((i*IMG_SIZE/2*IMG_SIZE/2*16) + ((IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO i*(IMG_SIZE/2)*(IMG_SIZE/2)*16);
	END GENERATE;
		
		Done <= '1' WHEN MiniPoolDone = temp1
				  	ELSE '0';
	
END ARCHITECTURE;
