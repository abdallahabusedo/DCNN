LIBRARY IEEE;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.float_pkg.ALL;
USE work.c_pkg.ALL;

ENTITY Pool IS
generic (WINDOW_SIZE : INTEGER := 2);
	PORT(
		WINDOW : IN std_logic_vector((WINDOW_SIZE*WINDOW_SIZE*16)-1 DOWNTO 0);
		START,rst,clk : IN std_logic;
		AVR : OUT std_logic_vector(15 downto 0);
		Done : OUT std_logic
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
	
	SIGNAL sumD: sfixed (4 downto -11);
	SIGNAL sumQ: sfixed (4 downto -11);
	SIGNAL WINDOW_SIZE2: sfixed (4 downto -11);
	SIGNAL division : sfixed (4 downto -11);
	SIGNAL Temp: sfixed (4 downto -11);		
	BEGIN
		WINDOW_SIZE2 <= to_sfixed(WINDOW_SIZE*WINDOW_SIZE,4,-11);
		division <= resize (arg => 1/WINDOW_SIZE2, 
						left_index => division'HIGH ,
						right_index => division'LOW ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate); 
						
		SUM_Reg:sflop PORT MAP(clk,sumD,sumQ);
		process(clk)
			variable i:integer :=0 ;
			begin
				if(rst = '1') then 
					sumD <= (others => '0');
				end if;
				if (CLK'event and CLK = '1' and START ='1') then  
					if(i<WINDOW_SIZE*WINDOW_SIZE)then
						sumD <= resize (arg => sumQ+ to_sfixed(WINDOW(i*16+15 DOWNTO i*16),4,-11), 
							left_index => sumD'high ,
							right_index => sumD'low ,
							round_style => fixed_round, 
							overflow_style => fixed_saturate); 
						i:=i+1;
					ELSE
						Done <= '1';
					END IF;
					
				end if;
				Temp <= resize (arg => sumQ*division , 
						left_index => Temp'high ,
						right_index => Temp'low ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate); 
				AVR <= to_slv(Temp);
			
								
		END process;
END arch_Pool;

