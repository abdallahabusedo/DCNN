LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY read_ram IS
GENERIC (count : INTEGER :=5);
PORT(
		clk : IN STD_LOGIC; 
		enable : IN STD_LOGIC;
		init_address : IN INTEGER;
		--count : IN INTEGER ;
		data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        done : OUT STD_LOGIC;
		read_address : OUT INTEGER;
		dataout : OUT  STD_LOGIC_VECTOR((16*count)-1 DOWNTO 0)
);

END read_ram;

ARCHITECTURE arch_read_ram OF read_ram IS
	BEGIN

	PROCESS(clk,enable) IS
		VARIABLE i:INTEGER :=0;
	Begin
		IF(rising_edge(clk) AND enable = '1') THEN
			IF (i < count) THEN 
				read_address <= init_address + i;
				dataout(i*16+15 DOWNTO i*16)  <= data_in;
				i := i +1;
			END IF;
			if (i = count) then
				done <= '1';
			end if;
			
		END IF;	
	END PROCESS;
			
		
END arch_read_ram;
