library ieee;
library work;
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;


ENTITY conv_avg IS
generic (IMG_number : integer := 3;IMG_SIZE : integer := 5);
	PORT(
		img_arr :IN std_logic_vector(IMG_number*IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		start:IN integer;
		avg_img : OUT std_logic_vector(IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		end_conv :OUT std_logic;
		clk,strat_signal,rst:IN std_logic
	);
END ENTITY;
ARCHITECTURE conv_avg_arch OF conv_avg IS
component sflop IS  
  PORT(CLK: IN std_logic;
	D : in sfixed (4 downto -11);  
    Q :OUT sfixed (4 downto -11)
	);	
end component;  
	TYPE REG_ARR is array(0 TO IMG_SIZE*IMG_SIZE-1) of sfixed (4 downto -11);
	SIGNAL D: REG_ARR;
	SIGNAL Q: REG_ARR;
	SIGNAL IMG_Snumber: sfixed (4 downto -11) :=to_sfixed(IMG_number,4,-11);
	SIGNAL avg_img_out:REG_ARR;
	BEGIN
		loop0: FOR i IN 0 TO IMG_SIZE*IMG_SIZE -1 GENERATE 			
				SUM_Reg:sflop PORT MAP(clk,D(i),Q(i));
		END GENERATE;
		process(clk,strat_signal)
			variable k:integer :=0 ;
			 
    			begin
			  if(strat_signal='0'or rst='1')then
				D<= (OTHERS => "0000000000000000");
				k:=0;
        		end if;
			  if (CLK'event and CLK = '1' and strat_signal='1' ) then  
				if( k < IMG_number) then
					if(IMG_SIZE > 2) then
						for p in 0 to IMG_SIZE*IMG_SIZE-1 loop
							D(p) <= resize (arg => Q(k)+to_sfixed(img_arr( ((k+start)*IMG_SIZE*IMG_SIZE+p)*16+15 Downto ((k+start)*IMG_SIZE*IMG_SIZE+p)*16),4,-11) , 
								left_index => D(p)'high ,
								right_index => D(p)'low ,
								round_style => fixed_round, 
								overflow_style => fixed_saturate); 
						end loop;
					else
					        D(0) <= resize (arg => Q(0)+to_sfixed(img_arr( ((k+start)*IMG_SIZE*IMG_SIZE)*16+15 Downto ((k+start)*IMG_SIZE*IMG_SIZE)*16),4,-11) , 
							left_index => D(0)'high ,
							right_index => D(0)'low ,
							round_style => fixed_round, 
							overflow_style => fixed_saturate); 
					end if;
				end if;
			if(k>IMG_number) then
				end_conv<='1';
			end if;
			if(k<=IMG_number)then
				end_conv<='0';
				k:=k+1;
			end if;
			end if;
			
			IF (IMG_SIZE > 2) THEN
				for p in 0 to IMG_SIZE*IMG_SIZE-1 loop
					avg_img_out(p) <= resize (arg => Q(p)/IMG_Snumber , 
						left_index => avg_img_out(p)'high ,
						right_index => avg_img_out(p)'low ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate);  
						avg_img(p*16+15 downto p*16)<=to_slv (avg_img_out(p));
				end loop;
			else
				avg_img_out(0) <= resize (arg => Q(0)/IMG_Snumber , 
				left_index => avg_img_out(0)'high ,
				right_index => avg_img_out(0)'low ,
				round_style => fixed_round, 
				overflow_style => fixed_saturate);  
				avg_img(15 downto 0)<=to_slv (avg_img_out(0));
			END IF;
			
		end process;

END conv_avg_arch;