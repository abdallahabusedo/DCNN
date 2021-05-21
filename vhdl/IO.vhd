library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

ENTITY io IS
PORT(
	cpuData:IN std_logic_vector(15 DOWNTO 0);
	clk : IN std_logic;
	startDecompression:IN std_logic;
	ready:IN std_logic;
	stop :OUT std_logic;
	rowSize:INOUT integer:=1;
	extraBits   : IN INTEGER;
	initialRowSize     : IN INTEGER;
	splitSize          : IN INTEGER

);

END io;
ARCHITECTURE ioo OF io IS
COMPONENT decompressor IS

PORT(
	Data : IN std_logic_vector(8 DOWNTO 0);
	clk : IN std_logic;
	startDecompression:IN std_logic;
	stop:OUT std_logic:='0'
	
	
);

END COMPONENT;

signal row:std_logic_vector(479 DOWNTO 0 ) := (others => '0');
signal clk2:std_logic;
signal test:integer := 0;
signal splittedData:std_logic_vector(8 DOWNTO 0);
BEGIN
clk2<=not clk;

process(clk2) is
begin

if(rising_edge(clk2) and ready='1' and startDecompression='0') then

	test <= test + 1;
	row <= STD_LOGIC_VECTOR(shift_right(unsigned(row), 16));
	row(479 DOWNTO 464) <= cpuData;
end if;

if(rising_edge(startDecompression)) then
   rowSize<=initialRowSize;
   row <= STD_LOGIC_VECTOR(shift_left(unsigned(row), extraBits));
end if;


if(rising_edge(clk2) and startDecompression='1') then
 	
   if(splitSize=1) then
	splittedData<= "00000000"&row(479);
	row<=STD_LOGIC_VECTOR(shift_left(unsigned(row), 1));
   elsif(splitSize=2) then
	splittedData<= "0000000"&row(479 DOWNTO 478);
	row<=STD_LOGIC_VECTOR(shift_left(unsigned(row), 2));
   elsif(splitSize=3) then
	splittedData<= "000000"&row(479 DOWNTO 477);
	row<=STD_LOGIC_VECTOR(shift_left(unsigned(row), 3));
   elsif(splitSize=4) then
	splittedData<= "00000"&row(479 DOWNTO 476);
	row<=STD_LOGIC_VECTOR(shift_left(unsigned(row), 4));
   elsif(splitSize=5) then
	splittedData<= "0000"&row(479 DOWNTO 475);
	row<=STD_LOGIC_VECTOR(shift_left(unsigned(row), 5));
   elsif(splitSize=6) then
	splittedData<= "000"&row(479 DOWNTO 474);
	row<=STD_LOGIC_VECTOR(shift_left(unsigned(row), 6));
   elsif(splitSize=7) then
	splittedData<= "00"&row(479 DOWNTO 473);
	row<=STD_LOGIC_VECTOR(shift_left(unsigned(row), 7));
   elsif(splitSize=8) then
	splittedData<= "0"&row(479 DOWNTO 472);
	row<=STD_LOGIC_VECTOR(shift_left(unsigned(row), 8));
   elsif(splitSize=9) then
	splittedData<= row(479 DOWNTO 471);
	row<=STD_LOGIC_VECTOR(shift_left(unsigned(row), 9));
   end if; 
 	rowSize<=rowSize-splitSize;
end if;
end process;
DecompressorIO:decompressor port map (splittedData,clk,startDecompression,stop);
end ioo;