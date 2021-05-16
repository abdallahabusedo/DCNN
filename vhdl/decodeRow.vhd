library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
USE IEEE.std_logic_unsigned.ALL;
ENTITY decompressor IS

PORT(
	Data : IN std_logic_vector(8 DOWNTO 0);
	clk : IN std_logic;
	startDecompression:IN std_logic;
	stop:OUT std_logic:='0'
	
	
);

END decompressor;
ARCHITECTURE decompressor_ARCHITECTURE OF decompressor IS
COMPONENT ram_Entity IS

PORT(
	
		clk : IN std_logic;
		Address:IN integer;
		DATAIN : IN  std_logic_vector(15 DOWNTO 0);
		ReadWriteSignals:IN std_logic_vector(1 DOWNTO 0);
		DATAOUT : OUT  std_logic_vector(15 DOWNTO 0)
);

END COMPONENT;
	Signal rowImage:std_logic_vector(447 DOWNTO 0):=(others => '1');
	Signal ZeroOne:std_logic:='0';
	Signal address:integer:=0;
	Signal startStoring:std_logic:='0';
	Signal writeRam:std_logic_vector(1 DOWNTO 0):="00";
	Signal ramData:std_logic_vector(15 DOWNTO 0);
	Signal ramDataOut:std_logic_vector(15 DOWNTO 0);
	Signal wasDecompressing:std_logic:='0';
	
BEGIN

--Code/Data = Number of zeros || Number of ones --
process(clk) is
begin
	if(startDecompression='1') then
		wasDecompressing<='1';
		stop<='1';
	end if;
	if(rising_edge(clk) and startDecompression='1') then
		if(ZeroOne='0') then
			rowImage<=STD_LOGIC_VECTOR(shift_left(unsigned(rowImage), to_integer(unsigned(Data))));
			ZeroOne<='1';
		else
			rowImage<=STD_LOGIC_VECTOR(rotate_left(unsigned(rowImage), to_integer(unsigned(Data))));
			ZeroOne<='0';
		end if;
	end if;
	if(address > 0 and address mod 28= 0) then
		stop<='0';
		wasDecompressing<='0';
		startStoring<='0';
		rowImage<=(others => '1');
		ZeroOne<='0';
	end if;
	if(startDecompression ='0' and wasDecompressing='1') then
		startStoring<='1';
		writeRam<="10";
	end if;
	if(rising_edge(clk) and startStoring='1') then
		ramData<=rowImage(447 DOWNTO 432);
		rowImage<=STD_LOGIC_VECTOR(shift_left(unsigned(rowImage),16));
		address<=address+1;
	end if;
	
end process;

ram:ram_Entity port map (clk,address,ramData,writeRam,ramDataOut);

end  decompressor_ARCHITECTURE;
