LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_unsigned.all;

package pool_pkg is
        type bus_array is array(24 DOWNTO 0) of signed(15 DOWNTO 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
use work.pool_pkg.all;

ENTITY Pool IS
	PORT(
		WINDOW : IN bus_array;
		AVR : OUT signed(15 DOWNTO 0)
		
	);
END ENTITY;
ARCHITECTURE arch_Pool OF Pool IS
	BEGIN
		process(WINDOW)
			variable sum : signed(16 DOWNTO 0); --16 for overflow
			variable division : signed(15 DOWNTO 0);
			variable complement : unsigned(4 DOWNTO 0);
			variable tempAvr : signed(31 DOWNTO 0);
    			begin
				sum := (others => '0');
				division := b"0000000001010001";
    				for i in 0 to 24 loop
         				sum := sum + (WINDOW(i)(15) & WINDOW(i));
					-- handling overflow
					if sum(16) = '0' and (to_integer(unsigned(sum(15 DOWNTO 11)))>15)then
						sum(16 DOWNTO 11) := b"001111";
					elsif sum(16) = '1' then
						complement := NOT(unsigned(sum(15 DOWNTO 11)));
						complement := complement + 1;
						if(to_integer(complement)>16) then 
							sum(16 DOWNTO 11) := b"110000";
						end if;
					end if;  
    				end loop;
				tempAvr := (sum(16)&sum(14 DOWNTO 0))*division;
				--AVR <= tempAvr(26 DOWNTO 11);
				AVR <= sum(16)&sum(14 DOWNTO 0);
		end process;
	
		
END arch_Pool;
