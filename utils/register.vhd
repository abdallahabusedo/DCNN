library ieee;  
use ieee.std_logic_1164.all;  
 USE IEEE.numeric_std.all;
entity flop is  
  port(CLK: IN std_logic;
	D : in signed(31 DOWNTO 0);  
      Q :OUT signed(31 DOWNTO 0));  
end flop;  
architecture archi of flop is  
  begin  
    process (CLK)  
      begin  
        if (CLK'event and CLK = '0') then  
          Q <= D;  
        end if;  
    end process;  
end archi;
