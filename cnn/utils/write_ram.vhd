LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY write_ram IS
GENERIC (size : INTEGER :=5);
	PORT(
		clk,rst : IN STD_LOGIC; 
		enable : IN STD_LOGIC;
		init_address : IN INTEGER;
		count : IN INTEGER;
		data_in : IN STD_LOGIC_VECTOR((16*size)-1 DOWNTO 0);
        done : OUT STD_LOGIC;
		write_address : OUT INTEGER;
		dataout : OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END write_ram;

ARCHITECTURE arch_write_ram OF write_ram IS
	BEGIN

	PROCESS(clk,rst,enable) IS
		VARIABLE i:INTEGER :=0;
	BEGIN
		IF (rst = '1') THEN
			i := 0;
			done <= '0';
		END IF;
		IF(rising_edge(clk) AND enable = '1') THEN
			IF (i < count) THEN 
				done<='0';
				write_address <= init_address + i;
				dataout <= data_in(i*16+15 DOWNTO i*16);
				i := i +1;
			END IF;
			IF (i = count) THEN
				done <= '1';
			END IF;
		END IF;
		
	END PROCESS;	
END arch_write_ram;