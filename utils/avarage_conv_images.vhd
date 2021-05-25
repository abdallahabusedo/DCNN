library ieee;
library work;
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.std_logic_unsigned.all;
use work.c_pkg.all;


ENTITY conv_avg IS
generic (IMG_number : integer := 3;IMG_SIZE : integer := 5);
	PORT(
		img_arr :IN convolution_imags_type; -- for one block of images
		start:IN integer;  
		avg_img : OUT img_array;
		signal_str,clk:IN std_logic
	);
END ENTITY;
ARCHITECTURE conv_avg_arch OF conv_avg IS
component sflop IS  
  PORT(CLK: IN std_logic;
	D : in sfixed (4 downto -11);  
    Q :OUT sfixed (4 downto -11)
	);	
end component;  
	SIGNAL D: img_array:= (
		0 => "0000000000000000",
		OTHERS => "0000000000000000");
	SIGNAL Q: img_array;
	SIGNAL IMG_Snumber: sfixed (4 downto -11) :=to_sfixed(IMG_number,4,-11);
	BEGIN
		loop0: FOR i IN 0 TO IMG_SIZE*IMG_SIZE -1 GENERATE 			
				SUM_Reg:sflop PORT MAP(clk,D(i),Q(i));
		END GENERATE;
		process(clk,signal_str)
			variable i:integer :=0 ;
			 
    			begin
			  if (CLK'event and CLK = '1' and signal_str='1' and i<IMG_number) then
				for p in 0 to IMG_SIZE*IMG_SIZE-1 loop
         					D(p) <= resize (arg => Q(i)+img_arr(start+i)(p) , 
						left_index => D(i)'high ,
						right_index => D(i)'low ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate); 
				end loop;
				i:=i+1; 
        		end if;
			for p in 0 to IMG_SIZE*IMG_SIZE-1 loop
         				avg_img(p) <= resize (arg => Q(i)/IMG_Snumber , 
						left_index => avg_img(p)'high ,
						right_index => avg_img(p)'low ,
						round_style => fixed_round, 
						overflow_style => fixed_saturate);  
			end loop;
			
		end process;

END conv_avg_arch;