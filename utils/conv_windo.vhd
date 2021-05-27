LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY conv_wimdow_1 IS
	GENERIC (FILTER_SIZE : INTEGER := 3);
	PORT(
		WINDOW : IN STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0);
		FILTER : IN STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0);
		PIXEL_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		end_conv : OUT STD_LOGIC;
		clk,strat_signal,rst: IN STD_LOGIC
	);
END ENTITY;

ARCHITECTURE conv_window_arch OF conv_wimdow_1 IS
	COMPONENT sflop IS  
		PORT(CLK: IN STD_LOGIC;
			D : IN sfixed (4 DOWNTO -11);  
			Q : OUT sfixed (4 DOWNTO -11)
		);	
	END COMPONENT;  

	COMPONENT MUL_WIN_FLT IS
		GENERIC (FILTER_SIZE : INTEGER := 3);
		PORT(
			WINDOW : IN STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0);
			FILTER : IN STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0);
			PIXEL : OUT STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL MUL_PIX_FIT:STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0);
	SIGNAL D: sfixed (4 DOWNTO -11):=(others => '0');
	SIGNAL Q: sfixed (4 DOWNTO -11);

	BEGIN
		MUL_WIN_FLT1:MUL_WIN_FLT GENERIC MAP (FILTER_SIZE) PORT MAP(WINDOW,FILTER,MUL_PIX_FIT);
		SUM_Reg:sflop PORT MAP(clk,D,Q);
		
		PROCESS(clk,strat_signal)
			VARIABLE i:INTEGER :=0;
    		BEGIN
				IF (CLK'event and CLK = '1' and strat_signal='1') THEN  
					IF(i<FILTER_SIZE*FILTER_SIZE)THEN 
						D <= resize (arg => Q+to_sfixed(MUL_PIX_FIT( i*16+15 DOWNTO i*16 ),4,-11) , 
							left_index => D'HIGH ,
							right_index => D'LOW ,
							round_style => fixed_round, 
							overflow_style => fixed_saturate); 
						i:=i+1;
						end_conv<='0';
					ELSIF(i>FILTER_SIZE*FILTER_SIZE) THEN
						end_conv<='1';
					ELSE 
						end_conv<='0';
						i:=i+1;
					END IF;
				ELSIF(strat_signal='0'or rst='1') THEN
					D<=(others => '0');
					i:=0;
				END IF;
				
				PIXEL_OUT<=to_slv (Q); 
		END PROCESS;
			
END conv_window_arch;
