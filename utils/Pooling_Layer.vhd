library ieee;
library work;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.c_pkg.all;
ENTITY pooling_layer IS
	generic (WINDOW_SIZE : integer := 2 ; Maps_Count : integer := 2 ;IMG_SIZE : integer := 8);
	PORT(
		InFeatureMaps : IN  std_logic_vector((Maps_Count*IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0);                     
		rst , START , clk:IN std_logic;
		OutFeatureMaps : OUT std_logic_vector((Maps_Count*(IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO 0);	
		Done : OUT std_logic
	);
END ENTITY;

ARCHITECTURE arch_pooling_layer OF pooling_layer IS

	COMPONENT pool_window IS
	GENERIC (FILTER_SIZE : INTEGER := 2;IMG_SIZE : INTEGER := 4);
		PORT(
			IMG :  IN std_logic_vector((IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0);
			clk , START , rst :IN std_logic;
			Done : OUT std_logic;
			pool_img : OUT std_logic_vector((IMG_SIZE/2)*(IMG_SIZE/2)*16-1 Downto 0)
		);
	END COMPONENT;
	
	SIGNAL MiniPoolDone,temp1 : std_logic_vector(0 TO Maps_Count-1);
	SIGNAL tempPoolOut : std_logic_vector((Maps_Count*(IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO 0);
	
	BEGIN
	PROCESS(rst)
		begin
			if(rst = '1') then 
				temp1 <= (OTHERS => '1');
			end if;
	END process;

	loop1: FOR i IN 0 TO Maps_Count-1 GENERATE 		
		fx0:pool_window GENERIC MAP (WINDOW_SIZE,IMG_SIZE)PORT MAP(InFeatureMaps((i*IMG_SIZE*IMG_SIZE*16) + (IMG_SIZE*IMG_SIZE*16)-1 DOWNTO i*IMG_SIZE*IMG_SIZE*16),clk,START,rst,MiniPoolDone(i),tempPoolOut((i*IMG_SIZE/2*IMG_SIZE/2*16) + ((IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO i*(IMG_SIZE/2)*(IMG_SIZE/2)*16));
		
		OutFeatureMaps((i*(IMG_SIZE/2)*(IMG_SIZE/2)*16) + ((IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO i*(IMG_SIZE/2)*(IMG_SIZE/2)*16) <= tempPoolOut((i*IMG_SIZE/2*IMG_SIZE/2*16) + ((IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO i*(IMG_SIZE/2)*(IMG_SIZE/2)*16);
	END GENERATE;
		
		Done <= '1' WHEN MiniPoolDone = temp1
				  	ELSE '0';
	
END ARCHITECTURE;
