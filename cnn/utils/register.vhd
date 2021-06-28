LIBRARY IEEE;  
USE IEEE.std_logic_1164.ALL;  
 USE IEEE.numeric_std.ALL;
entity flop IS  
  PORT(CLK: IN STD_LOGIC;
	D : IN signed(31 DOWNTO 0);  
      Q :OUT signed(31 DOWNTO 0));  
END flop;  
architecture archi OF flop IS  
  BEGIN  
    PROCESS (CLK)  
      BEGIN  
        IF (CLK'event AND CLK = '0') THEN  
          Q <= D;  
        END IF;  
    END PROCESS;  
END archi;
