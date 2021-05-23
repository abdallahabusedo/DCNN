library ieee;  
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;
use ieee.std_logic_1164.ALL;  
USE IEEE.numeric_std.ALL;

entity sflop is  
  port(CLK: IN std_logic;
	D : in sfixed (4 downto -11); 
    Q :OUT sfixed (4 downto -11)  
	);
end sflop;  
architecture sarchi of sflop is  
  begin  
    process (CLK)  
      begin  
        if (CLK'event and CLK = '0') then  
          Q <= D;  
        end if;  
    end process;  
end sarchi;
