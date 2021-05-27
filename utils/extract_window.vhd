library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------------------------
ENTITY extract_window IS
generic (FILTER_SIZE : integer:=3 ;IMG_SIZE : integer:=5);
	PORT(
		IMG : IN std_logic_vector(IMG_SIZE*IMG_SIZE*16-1 Downto 0);
		IMG_SIZE_in:IN integer;
		FILTER_SIZE_in:IN integer;
		rst:IN std_logic;
		OFFSET:IN integer;
		LAYER : OUT std_logic_vector(FILTER_SIZE*FILTER_SIZE*16-1 Downto 0)
	);
END ENTITY;
------------------------------------------------------------------------
ARCHITECTURE extract_window_arch OF extract_window IS
	BEGIN
		process(IMG,OFFSET,rst)
        		variable k_filter,add_filter,k_img,add_img : integer ;
        		variable i,j,l_img,l_filter,fi,im : integer;
    			begin
				if(rst='1')then
					k_filter:=0;
					add_filter:=0;
					k_img:=0;
					add_img:=0;
					i:=0;
					j:=0;
					l_img:=0;
					l_filter:=0;
					fi:=0;
					im:=0;
				end if;
				fi :=FILTER_SIZE_in;
				im :=IMG_SIZE_in ;
				k_filter:=0;
				k_img:=OFFSET;
				add_img:=OFFSET;
				add_filter:=0;
    				for i in 0 to fi-1 loop
					for p in 0 to fi-1 loop
         					LAYER(add_filter*16+15 downto add_filter*16) <= IMG(add_img*16+15 downto add_img*16);
						add_img :=add_img+im;
						add_filter :=add_filter+fi; 
					END loop;
					k_img:=k_img+1;
					add_img:=k_img;
					k_filter:=k_filter+1;
					add_filter:=k_filter;
    				end loop;
		end process;
END extract_window_arch;
