library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
USE IEEE.std_logic_unsigned.ALL;
ENTITY sendRow IS

PORT(
	row : IN std_logic_vector(479 DOWNTO 0);
	clk : IN std_logic;
	ready:IN std_logic;
	send:OUT std_logic;
	stop:INOUT std_logic
);

END sendRow;
ARCHITECTURE sendRow_ARCHITECTURE OF sendRow IS
COMPONENT io IS
PORT(
	cpuData:IN std_logic_vector(15 DOWNTO 0);
	clk : IN std_logic;
	startDecompression:INOUT std_logic;
	ready:IN std_logic;
	stop :OUT std_logic;
	rowSize            : INOUT INTEGER := 1;
	extraBits   : IN INTEGER;
	initialRowSize     : IN INTEGER;
	splitSize          : IN INTEGER
);

END COMPONENT;

signal currentIndex:integer:=0;
signal data : std_logic_vector(15 DOWNTO 0) := (others => '1');
signal startDecompression:std_logic:='0';
signal rowSignal : std_logic_vector(479 DOWNTO 0):= (others => '1');
signal rowSize:integer;
SIGNAL tempRowSize        : INTEGER := 100;
SIGNAL splitSize          : INTEGER := 100;
SIGNAL initialRowSize     : INTEGER := 100;
SIGNAL extraBits		: INTEGER := 100;
BEGIN

process(clk) is
begin
--Now the data is ready so we can send it 16 bit by 16 bit to the io--
if(rowSize<=0) then
startDecompression<='0';
end if;
if(stop='0') then
	if(ready='1' and currentIndex=1) then

	initialRowSize <= to_integer(unsigned(row(15 DOWNTO 0)));
	tempRowSize <= to_integer(unsigned(row(15 DOWNTO 0)));
	splitSize <= to_integer(unsigned(row(31 DOWNTO 16)));
	extraBits <= 16 - (initialRowSize MOD 16);
	rowSignal <= row;
	rowSignal <= STD_LOGIC_VECTOR(shift_right(unsigned(row), 32));
	send<='0';
	end if;
	if(rising_edge(clk)) then
	if(ready='1') then
	data <= rowSignal(15 DOWNTO 0);
	rowSignal <= STD_LOGIC_VECTOR(shift_right(unsigned(rowSignal), 16));
	currentIndex <= currentIndex+1;
	tempRowSize  <= tempRowSize - 16;
	end if;
	if(currentIndex=30 OR tempRowSize <= 0) then
	startDecompression<='1';
	currentIndex<=0;
	send<='1';
	tempRowSize <= 100;
	end if;

	end if;
end if;
end process ;


sendIO:io port map (data,clk,startDecompression,ready,stop,rowSize, extraBits, initialRowSize, splitSize);

end  sendRow_ARCHITECTURE;
