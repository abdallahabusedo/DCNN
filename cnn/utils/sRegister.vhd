LIBRARY IEEE;  
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;  
USE IEEE.numeric_std.ALL;

ENTITY sflop IS  
    PORT(
        CLK: IN STD_LOGIC;
        D : IN sfixed (4 DOWNTO -11); 
        Q :OUT sfixed (4 DOWNTO -11)  
    );
END sflop;  
architecture sarchi OF sflop IS  
  BEGIN  
    PROCESS (CLK)  
      BEGIN  
        IF (CLK'event AND CLK = '0') THEN  
          Q <= D;  
        END IF;  
    END PROCESS;  
END sarchi;
