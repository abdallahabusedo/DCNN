LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY read_ram IS
GENERIC (count : integer :=5);
PORT(
		clk : IN std_logic; 
		enable : IN std_logic;
		init_address : IN integer;
		data_in : IN std_logic_vector(15 DOWNTO 0);
        done : OUT std_logic;
		read_address : OUT integer;
		dataout : OUT  std_logic_vector((16*count)-1 DOWNTO 0)
);

END read_ram;

ARCHITECTURE arch_read_ram OF read_ram IS
	BEGIN

	process(clk,enable) IS
		variable i:integer :=0;
	Begin
		if(rising_edge(clk) and enable = '1') then
			if (i < count) then 
				read_address <= init_address + i;
				dataout(i*16+15 DOWNTO i*16)  <= data_in;
				i := i +1;
			end if;
			if (i = count) then
				done <= '1';
			end if;
		end if;
		
	End process;
			
		
END arch_read_ram;
