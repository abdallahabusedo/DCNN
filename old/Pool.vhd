LIBRARY IEEE;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.float_pkg.ALL;
USE work.c_pkg.ALL;

ENTITY Pool IS
GENERIC (WINDOW_SIZE : INTEGER := 2);
	PORT(
		WINDOW : IN filter_array;
		START : IN STD_LOGIC;
		AVR : OUT sfixed (4 DOWNTO -11);
		Done : OUT STD_LOGIC := '0';
		clk:IN STD_LOGIC 
	);
END ENTITY;
ARCHITECTURE arch_Pool OF Pool IS
	COMPONENT sflop IS  
	  PORT(
		CLK: IN STD_LOGIC;
		D : IN sfixed (4 DOWNTO -11);  
		Q :OUT sfixed (4 DOWNTO -11)
		); 
	END COMPONENT; 
	
	SIGNAL sumD: sfixed (4 DOWNTO -11):=(others => '0');
	SIGNAL sumQ: sfixed (4 DOWNTO -11);
	SIGNAL WINDOW_SIZE2: sfixed (4 DOWNTO -11);
	SIGNAL division : sfixed (4 DOWNTO -11);
	
	BEGIN
		WINDOW_SIZE2 <= to_sfixed(WINDOW_SIZE*WINDOW_SIZE,4,-11);
		division <= resize (arg => 1/WINDOW_SIZE2, 
						left_index => division'HIGH ,
						right_index => division'LOW ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate); 
						
		SUM_Reg:sflop PORT MAP(clk,sumD,sumQ);
		PROCESS(clk,START)
			VARIABLE i:INTEGER :=0 ;
			BEGIN
				IF (clk'event and CLK = '1' and START ='1') THEN  
					IF(i<WINDOW_SIZE*WINDOW_SIZE)THEN
						sumD <= resize (arg => sumQ+WINDOW(i), 
							left_index => sumD'HIGH ,
							right_index => sumD'LOW ,
							round_style => fixed_round, 
							overflow_style => fixed_saturate); 
						i:=i+1;
					ELSE
						Done <= '1';
					END IF;
					
				END IF;
				AVR <= resize (arg => sumQ*division , 
						left_index => AVR'HIGH ,
						right_index => AVR'LOW ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate); 
		END PROCESS;
END arch_Pool;