Library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use IEEE.fixed_pkg.all;

ENTITY compartor IS
  generic (
    n : integer := 16;
    fp: integer := 11
  );
  PORT ( a, b: IN sfixed (n-fp-1 downto -fp);
  ind1,ind2: IN std_logic_vector (3 downto 0);
  max: OUT sfixed (n-fp-1 downto -fp);
	max_ind: OUT std_logic_vector (3 downto 0));
END compartor;

ARCHITECTURE a_compartor OF compartor IS
	BEGIN
    max <= a when a>b
    else b;
    max_ind <= ind1 when a>b
    else ind2;
END a_compartor;