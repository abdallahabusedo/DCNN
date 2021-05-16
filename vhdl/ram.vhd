LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram_Entity IS

PORT(
		
		clk : IN std_logic;
		Address:IN integer;
		DATAIN : IN  std_logic_vector(15 DOWNTO 0);
		ReadWriteSignals:IN std_logic_vector(1 DOWNTO 0);
		DATAOUT : OUT  std_logic_vector(15 DOWNTO 0)
);

END ram_Entity;

ARCHITECTURE RAM_Memory OF ram_Entity IS

	TYPE ram_type IS ARRAY(0 TO 1999) OF std_logic_vector(15 DOWNTO 0);
	SIGNAL ram : ram_type ;
	SIGNAL ActualClk:std_logic;
	BEGIN
	ActualClk<=not clk;
	process(ActualClk) IS
	Begin
		if(rising_edge(ActualClk) and ReadWriteSignals = "10") then
			ram(Address) <= DATAIN ;
		end if;
	End process;
	DATAOUT <= ram(Address) when ReadWriteSignals = "01" ;
			
		
END RAM_Memory;
