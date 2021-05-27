library ieee;
library work;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY conv_wimdow_1 IS
generic (FILTER_SIZE : integer := 3);
	PORT(
		WINDOW : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		FILTER : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		PIXEL_OUT : OUT std_logic_vector(15 downto 0);
		end_conv :OUT std_logic;
		clk,strat_signal,REST:IN std_logic
	);
END ENTITY;
ARCHITECTURE conv_window_arch OF conv_wimdow_1 IS
component sflop IS  
  PORT(CLK: IN std_logic;
	D : in sfixed (4 downto -11);  
    Q :OUT sfixed (4 downto -11)
	);	
end component;  
	component MUL_WIN_FLT IS
	PORT(
		WINDOW : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		FILTER : IN std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
		PIXEL : OUT std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0)
	);
	END component;
	SIGNAL MUL_PIX_FIT:std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
	SIGNAL D: sfixed (4 downto -11):=(others => '0');
	SIGNAL Q: sfixed (4 downto -11);
	BEGIN
		MUL_WIN_FLT1:MUL_WIN_FLT GENERIC MAP (FILTER_SIZE) PORT MAP(WINDOW,FILTER,MUL_PIX_FIT);
		SUM_Reg:sflop PORT MAP(clk,D,Q);
		process(clk,strat_signal)
			variable i:integer :=0 ;
    			begin
			  
			  if (CLK'event and CLK = '1' and strat_signal='1') then  
				if(i<FILTER_SIZE*FILTER_SIZE)then 
					D <= resize (arg => Q+to_sfixed(MUL_PIX_FIT( i*16+15 Downto i*16 ),4,-11) , 
						left_index => D'high ,
						right_index => D'low ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate); 
					i:=i+1;
				end_conv<='0';
				elsif(i>FILTER_SIZE*FILTER_SIZE) then
					end_conv<='1';
				else 
					end_conv<='0';
					i:=i+1;
				end if;
			elsif(strat_signal='0'or REST='1')then
				D<=(others => '0');
				i:=0;
        		end if;
			
			PIXEL_OUT<=to_slv (Q); 
		end process;
			
END conv_window_arch;
