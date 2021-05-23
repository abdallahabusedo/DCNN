Library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use IEEE.fixed_pkg.all;

ENTITY softmax IS
  Generic (
     length : Integer:=160;
     n : integer := 16;
     fp: integer := 11
  );
	PORT (x : IN   std_logic_vector (length-1 downto 0);
	ind: OUT std_logic_vector (3 downto 0));
END softmax;

ARCHITECTURE a_softmax OF softmax IS
	component compartor is
    PORT ( a, b: IN sfixed (n-fp-1 downto -fp);
    ind1,ind2: IN std_logic_vector (3 downto 0);
    max: OUT sfixed (n-fp-1 downto -fp);
    max_ind: OUT std_logic_vector (3 downto 0));
	END component;
  Signal cur_max,m :sfixed (n-fp-1 downto -fp);
  Signal cur_max_ind :std_logic_vector (3 downto 0);
	BEGIN
    cur_max <= to_sfixed(signed(x(15 downto 0)));
    cur_max_ind <= (others => '0');
		loop1: FOR i IN 1 TO 9 GENERATE
      m <= to_sfixed(signed(x(16*i+15 downto 16*i)));
			comparei: compartor GENERIC MAP (n,fc) PORT MAP(
        m,
        cur_max,
        std_logic_vector(to_unsigned(i, 4)),
        cur_max_ind,
        cur_max,
        cur_max_ind
      );
		END GENERATE;
    ind <= cur_max_ind;
END a_softmax;