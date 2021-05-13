library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

ENTITY io IS
PORT(
	cpuData:IN std_logic_vector(15 DOWNTO 0);
	clk : IN std_logic;
	startDecompression:IN std_logic;
	ready:IN std_logic

);

END io;
ARCHITECTURE ioo OF io IS

signal row:std_logic_vector(479 DOWNTO 0 );
signal clk2:std_logic;
BEGIN
clk2<=not clk;
process(clk2) is
begin

if(rising_edge(clk2) and ready='1') then

row <= row(463 DOWNTO 16) & cpuData & "0000000000000000";

end if;

end process;

end ioo;