LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.c_pkg.all;

ENTITY cnn_read_ram_img IS
GENERIC (count : integer :=5);
    PORT(
            clk : IN std_logic; 
            enable : IN std_logic;
            init_address : IN integer;
            data_in : IN std_logic_vector(15 DOWNTO 0);
            done : OUT std_logic;
            read_address : OUT integer;
            dataout : OUT img_array
    );
END cnn_read_ram_img;

ARCHITECTURE arch_cnn_read_ram_img OF cnn_read_ram_img IS
	BEGIN

	process(clk,enable) IS
		variable i:integer :=0;
	Begin
		if(rising_edge(clk) and enable = '1') then
			if (i < count) then 
				read_address <= init_address + i;
				dataout(i)  <= to_sfixed(data_in,4,-11);
				i := i +1;
			end if;
			if (i = count) then
				done <= '1';
			end if;
		end if;
		
	End process;
			
		
END arch_cnn_read_ram_img;
