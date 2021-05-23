library ieee;
library work;
USE ieee.fixed_float_types.ALL;
USE ieee.fixed_pkg.ALL;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.c_pkg.all;
------------------------------------------------------------------------
ENTITY extract_window IS
generic (FILTER_SIZE : integer ;IMG_SIZE : integer);
	PORT(
		IMG : IN img_array;
		OFFSET:IN integer;
		LAYER : OUT filter_array
	);
END ENTITY;
------------------------------------------------------------------------
ARCHITECTURE extract_window_arch OF extract_window IS
SIGNAL arr:filter_array;
	BEGIN
		process(IMG,OFFSET)--,FILTER1)
        		variable k_filter : integer := 0;
        		variable add_filter : integer := 0;
        		variable k_img : integer := 0;
        		variable add_img : integer := 0;
        		variable i : integer := 0;
        		variable j : integer := 0;
        		variable l_img : integer := 0;
        		variable l_filter : integer := 0;
        		variable fi : integer ;
        		variable im : integer ;
        		variable count_pixel : integer:=0 ;

    			begin
				fi :=FILTER_SIZE;
				im :=IMG_SIZE ;
				k_filter:=0;
				k_img:=OFFSET;
				add_img:=OFFSET;
				add_filter:=0;
    				for i in 0 to fi-1 loop
					for p in 0 to fi-1 loop
         					arr(add_filter) <= IMG(add_img);
						add_img :=add_img+im;
						add_filter :=add_filter+fi; 
					end loop;
					k_img:=k_img+1;
					add_img:=k_img;
					k_filter:=k_filter+1;
					add_filter:=k_filter;
    				end loop;
		end process;
		LAYER<=arr;
END extract_window_arch;
