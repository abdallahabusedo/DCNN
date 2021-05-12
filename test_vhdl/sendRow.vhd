library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

ENTITY sendRow IS

PORT(
	row : IN std_logic_vector(447 DOWNTO 0);
	splitSize:IN std_logic_vector(15 DOWNTO 0);
	rowSize:IN std_logic_vector(15 DOWNTO 0)
);

END sendRow;
ARCHITECTURE sendRow_ARCHITECTURE OF sendRow IS


BEGIN


end  sendRow_ARCHITECTURE;
