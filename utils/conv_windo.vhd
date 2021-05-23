library ieee;
library work;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
use work.c_pkg.all;

ENTITY conv_wimdow_1 IS
generic (FILTER_SIZE : integer := 3);
	PORT(
		WINDOW : IN filter_array;
		FILTER : IN filter_array;
		PIXEL_OUT : OUT signed(31 DOWNTO 0);
		clk:IN std_logic
	);
END ENTITY;
ARCHITECTURE conv_window_arch OF conv_wimdow_1 IS
component flop IS  
  PORT(CLK: IN std_logic;
	D : in signed(31 DOWNTO 0);  
      Q :OUT signed(31 DOWNTO 0));  
end component;  
	component MUL_WIN_FLT IS
	PORT(
		WINDOW : IN filter_array;
		FILTER : IN filter_array;
		PIXEL : OUT MUL_array
	);
	END component;
	SIGNAL MUL_PIX_FIT:MUL_array;
	SIGNAL D: signed(31 DOWNTO 0):="00000000000000000000000000000000";
	SIGNAL Q: signed(31 DOWNTO 0);
	BEGIN
		MUL_WIN_FLT1:MUL_WIN_FLT GENERIC MAP (FILTER_SIZE) PORT MAP(WINDOW,FILTER,MUL_PIX_FIT);
		SUM_Reg:flop PORT MAP(clk,D,Q);
		process(clk)
			variable i:integer :=0 ;
    			begin
			  if (CLK'event and CLK = '1') then  
				if(i<FILTER_SIZE*FILTER_SIZE)then 
					D<=Q+MUL_PIX_FIT(i);
					i:=i+1;
				end if;
        		end if;  
			PIXEL_OUT<=Q; 
		end process;
			
END conv_window_arch;
