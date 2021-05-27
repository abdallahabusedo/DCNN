LIBRARY ieee;
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.float_pkg.all;
use work.c_pkg.all;

ENTITY Pool IS
generic (WINDOW_SIZE : integer := 2);
	PORT(
		WINDOW : IN filter_array;
		START : IN std_logic;
		AVR : OUT sfixed (4 downto -11);
		Done : OUT std_logic := '0';
		clk:IN std_logic 
	);
END ENTITY;
ARCHITECTURE arch_Pool OF Pool IS
	COMPONENT sflop IS  
	  PORT(
		CLK: IN std_logic;
		D : in sfixed (4 downto -11);  
		Q :OUT sfixed (4 downto -11)
		); 
	END COMPONENT; 
	
	SIGNAL sumD: sfixed (4 downto -11):=(others => '0');
	SIGNAL sumQ: sfixed (4 downto -11);
	SIGNAL WINDOW_SIZE2: sfixed (4 downto -11);
	SIGNAL division : sfixed (4 downto -11);
	
	BEGIN
		WINDOW_SIZE2 <= to_sfixed(WINDOW_SIZE*WINDOW_SIZE,4,-11);
		division <= resize (arg => 1/WINDOW_SIZE2, 
						left_index => division'high ,
						right_index => division'low ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate); 
						
		SUM_Reg:sflop PORT MAP(clk,sumD,sumQ);
		process(clk,START)
			variable i:integer :=0 ;
			begin
				if (clk'event and CLK = '1' and START ='1') then  
					if(i<WINDOW_SIZE*WINDOW_SIZE)then
						sumD <= resize (arg => sumQ+WINDOW(i), 
							left_index => sumD'high ,
							right_index => sumD'low ,
							round_style => fixed_round, 
							overflow_style => fixed_saturate); 
						i:=i+1;
					else
						Done <= '1';
					end if;
					
				end if;
				AVR <= resize (arg => sumQ*division , 
						left_index => AVR'high ,
						right_index => AVR'low ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate); 
		END process;
END arch_Pool;