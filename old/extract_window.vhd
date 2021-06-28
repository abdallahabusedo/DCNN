LIBRARY IEEE;
LIBRARY work;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.c_pkg.ALL;
------------------------------------------------------------------------
ENTITY extract_window IS
GENERIC (FILTER_SIZE : INTEGER ;IMG_SIZE : INTEGER);
	PORT(
		IMG : IN img_array;
		OFFSET:IN INTEGER;
		LAYER : OUT filter_array
	);
END ENTITY;
------------------------------------------------------------------------
ARCHITECTURE extract_window_arch OF extract_window IS
SIGNAL arr:filter_array;
	BEGIN
		PROCESS(IMG,OFFSET)--,FILTER1)
        		VARIABLE k_filter : INTEGER := 0;
        		VARIABLE add_filter : INTEGER := 0;
        		VARIABLE k_img : INTEGER := 0;
        		VARIABLE add_img : INTEGER := 0;
        		VARIABLE i : INTEGER := 0;
        		VARIABLE j : INTEGER := 0;
        		VARIABLE l_img : INTEGER := 0;
        		VARIABLE l_filter : INTEGER := 0;
        		VARIABLE fi : INTEGER ;
        		VARIABLE im : INTEGER ;
        		VARIABLE count_pixel : INTEGER:=0 ;

    			BEGIN
				fi :=FILTER_SIZE;
				im :=IMG_SIZE ;
				k_filter:=0;
				k_img:=OFFSET;
				add_img:=OFFSET;
				add_filter:=0;
    				FOR i IN 0 TO fi-1 LOOP
					FOR p IN 0 TO fi-1 LOOP
         					arr(add_filter) <= IMG(add_img);
						add_img :=add_img+im;
						add_filter :=add_filter+fi; 
					END LOOP;
					k_img:=k_img+1;
					add_img:=k_img;
					k_filter:=k_filter+1;
					add_filter:=k_filter;
    				END LOOP;
		END PROCESS;
		LAYER<=arr;
END extract_window_arch;
