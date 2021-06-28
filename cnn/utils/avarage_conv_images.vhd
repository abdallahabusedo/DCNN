LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;


ENTITY conv_avg IS
GENERIC (IMG_number : INTEGER := 2;IMG_SIZE : INTEGER := 4);
	PORT(
		img_arr :IN STD_LOGIC_VECTOR(IMG_number*IMG_SIZE*IMG_SIZE*16-1 DOWNTO 0);
		start:IN INTEGER;
		avg_img : OUT STD_LOGIC_VECTOR(IMG_SIZE*IMG_SIZE*16-1 DOWNTO 0);
		end_conv :OUT STD_LOGIC;
		clk,strat_signal,rst:IN STD_LOGIC
	);
END ENTITY;
ARCHITECTURE conv_avg_arch OF conv_avg IS
COMPONENT sflop IS  
  PORT(CLK: IN STD_LOGIC;
	D : IN sfixed (4 DOWNTO -11);  
    Q :OUT sfixed (4 DOWNTO -11)
	);	
END COMPONENT;  
	TYPE REG_ARR IS ARRAY(0 TO IMG_SIZE*IMG_SIZE-1) OF sfixed (4 DOWNTO -11);
	SIGNAL D: REG_ARR;
	SIGNAL Q: REG_ARR;
	SIGNAL IMG_Snumber: sfixed (4 DOWNTO -11) :=to_sfixed(IMG_number,4,-11);
	SIGNAL avg_img_out:REG_ARR;
	BEGIN
		loop0: FOR i IN 0 TO IMG_SIZE*IMG_SIZE -1 GENERATE 			
				SUM_Reg:sflop PORT MAP(clk,D(i),Q(i));
		END GENERATE;
		PROCESS(clk,strat_signal)
			VARIABLE k:INTEGER :=0 ;
			 
    			BEGIN
			  IF(strat_signal='0'or rst='1')THEN
				D<= (OTHERS => "0000000000000000");
				k:=0;
        		END IF;
			  IF (CLK'event and CLK = '1' and strat_signal='1' ) THEN  
				IF( k < IMG_number) THEN
					IF(IMG_SIZE >= 2) THEN
						FOR p IN 0 TO IMG_SIZE*IMG_SIZE-1 LOOP
							D(p) <= resize (arg => Q(k)+to_sfixed(img_arr( ((k+start)*IMG_SIZE*IMG_SIZE+p)*16+15 DOWNTO ((k+start)*IMG_SIZE*IMG_SIZE+p)*16),4,-11) , 
								left_index => D(p)'HIGH ,
								right_index => D(p)'LOW ,
								round_style => fixed_round, 
								overflow_style => fixed_saturate); 
						END LOOP;
					ELSE
					        D(0) <= resize (arg => Q(0)+to_sfixed(img_arr( ((k+start)*IMG_SIZE*IMG_SIZE)*16+15 DOWNTO ((k+start)*IMG_SIZE*IMG_SIZE)*16),4,-11) , 
							left_index => D(0)'HIGH ,
							right_index => D(0)'LOW ,
							round_style => fixed_round, 
							overflow_style => fixed_saturate); 
					END IF;
				END IF;
			IF(k>IMG_number) THEN
				end_conv<='1';
			END IF;
			IF(k<=IMG_number)THEN
				end_conv<='0';
				k:=k+1;
			END IF;
			END IF;
			
			IF (IMG_SIZE >= 2) THEN
				FOR p IN 0 TO IMG_SIZE*IMG_SIZE-1 LOOP
					avg_img_out(p) <= resize (arg => Q(p)/IMG_Snumber , 
						left_index => avg_img_out(p)'HIGH ,
						right_index => avg_img_out(p)'LOW ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate);  
						avg_img(p*16+15 DOWNTO p*16)<=to_slv (avg_img_out(p));
				END LOOP;
			ELSE
				avg_img_out(0) <= resize (arg => Q(0)/IMG_Snumber , 
				left_index => avg_img_out(0)'HIGH ,
				right_index => avg_img_out(0)'LOW ,
				round_style => fixed_round, 
				overflow_style => fixed_saturate);  
				avg_img(15 DOWNTO 0)<=to_slv (avg_img_out(0));
			END IF;
			
		END PROCESS;

END conv_avg_arch;