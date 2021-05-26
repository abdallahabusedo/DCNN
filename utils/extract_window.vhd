LIBRARY IEEE;
LIBRARY work;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
------------------------------------------------------------------------
ENTITY extract_window IS
GENERIC (FILTER_SIZE : INTEGER:=3 ;IMG_SIZE : INTEGER:=5);
	PORT(
		IMG : IN STD_LOGIC_VECTOR(IMG_SIZE*IMG_SIZE*16-1 DOWNTO 0);
		IMG_SIZE_in:IN INTEGER;
		FILTER_SIZE_in:IN INTEGER;
		REST:IN STD_LOGIC;
		OFFSET:IN INTEGER;
		LAYER : OUT STD_LOGIC_VECTOR(FILTER_SIZE*FILTER_SIZE*16-1 DOWNTO 0)
	);
END ENTITY;
------------------------------------------------------------------------
ARCHITECTURE extract_window_arch OF extract_window IS
	BEGIN
		PROCESS(IMG,OFFSET,REST)
        		VARIABLE k_filter,add_filter,k_img,add_img : INTEGER ;
        		VARIABLE i,j,l_img,l_filter,fi,im : INTEGER;
    			BEGIN
				IF(REST='1')THEN
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
				END IF;
				fi :=FILTER_SIZE_in;
				im :=IMG_SIZE_in ;
				k_filter:=0;
				k_img:=OFFSET;
				add_img:=OFFSET;
				add_filter:=0;
    				for i IN 0 to fi-1 loop
					for p IN 0 to fi-1 loop
         					LAYER(add_filter*16+15 DOWNTO add_filter*16) <= IMG(add_img*16+15 DOWNTO add_img*16);
						add_img :=add_img+im;
						add_filter :=add_filter+fi; 
					END loop;
					k_img:=k_img+1;
					add_img:=k_img;
					k_filter:=k_filter+1;
					add_filter:=k_filter;
    				END loop;
		END PROCESS;
END extract_window_arch;
