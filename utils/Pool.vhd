LIBRARY IEEE;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_unsigned.all;

package pool_pkg is
        type bus_array is array(3 DOWNTO 0) of sfixed (4 downto -11);
end package;

library ieee;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
use work.pool_pkg.all;

ENTITY Pool IS
	PORT(
		WINDOW : IN bus_array;
		AVR : OUT sfixed (4 downto -11)
		
	);
END ENTITY;
ARCHITECTURE arch_Pool OF Pool IS

signal test : sfixed (4 downto -11);

	BEGIN
		process(WINDOW)
			variable sum : sfixed (4 downto -11);
			variable division : sfixed (4 downto -11);
    			begin
				sum := (others => '0');
				division := to_sfixed (0.25, 4, -11);
    				for i in 0 to 3 loop

					sum := resize (arg => sum+WINDOW(i), 
			  				left_index => sum'high ,
			 				right_index => sum'low ,
							round_style => fixed_round, 
							overflow_style => fixed_saturate);  

    				end loop;
		test <= sum;
		AVR <= resize (arg => sum*division , 
			  				left_index => AVR'high ,
			 				right_index => AVR'low ,
							round_style => fixed_round, 
							overflow_style => fixed_saturate); 
		end process;
	
		
END arch_Pool;
