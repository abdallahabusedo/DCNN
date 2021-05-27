LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY write_ram IS
GENERIC (count : integer :=5);
PORT(
		clk : IN std_logic; 
		enable : IN std_logic;
		init_address : IN integer;
		data_in : IN std_logic_vector((16*count)-1 DOWNTO 0);
        done : OUT std_logic;
		write_address : OUT integer;
		dataout : OUT  std_logic_vector(15 DOWNTO 0)
);

END write_ram;

ARCHITECTURE arch_write_ram OF write_ram IS
	BEGIN

	process(clk,enable) IS
		variable i:integer :=0;
	Begin
		if(rising_edge(clk) and enable = '1') then
			if (i < count) then 
				write_address <= init_address + i;
				dataout <= data_in(i*16+15 DOWNTO i*16);
				i := i +1;
			end if;
			if (i = count) then
				done <= '1';
			end if;
		end if;
		
	End process;
			
		
END arch_write_ram;
