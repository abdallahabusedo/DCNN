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
  Signal max01,max23 ,max45 ,max67 ,max89 :sfixed (n-fp-1 downto -fp);
  Signal max03,max47 ,max49 ,max09 ,max:sfixed (n-fp-1 downto -fp);
  Signal in010,in011 ,in230 ,in231 ,in450,in451 :sfixed (n-fp-1 downto -fp);
  Signal in670,in671 ,in890 ,in891 :sfixed (n-fp-1 downto -fp);
  Signal ind01,ind23 ,ind45 ,ind67 ,ind89 :std_logic_vector (3 downto 0);
  Signal ind03,ind47 ,ind49 ,ind09 :std_logic_vector (3 downto 0);
  BEGIN 
  in010 <= to_sfixed(signed(x(15 downto 0)));
  in011 <= to_sfixed(signed(x(31 downto 16)));
  comp01: compartor GENERIC MAP (n,fc) PORT MAP(
    in010,
    in011,
    "0000",
    "0001",
    max01,
    ind01
  );
  in230 <= to_sfixed(signed(x(47 downto 32)));
  in231 <= to_sfixed(signed(x(63 downto 48)));
  comp23: compartor GENERIC MAP (n,fc) PORT MAP(
    in230,
    in231,
    "0010",
    "0011",
    max23,
    ind23
  );
  in450 <= to_sfixed(signed(x(79 downto 64)));
  in451 <= to_sfixed(signed(x(95 downto 80)));
  comp45: compartor GENERIC MAP (n,fc) PORT MAP(
    in450,
    in451,
    "0100",
    "0101",
    max45,
    ind45
  );
  in670 <= to_sfixed(signed(x(111 downto 96)));
  in671 <= to_sfixed(signed(x(127 downto 112)));
  comp67: compartor GENERIC MAP (n,fc) PORT MAP(
    in670,
    in671,
    "0110",
    "0111",
    max67,
    ind67
  );
  in890 <= to_sfixed(signed(x(143 downto 128)));
  in891 <= to_sfixed(signed(x(159 downto 144)));
  comp89: compartor GENERIC MAP (n,fc) PORT MAP(
    in890,
    in891,
    "1000",
    "1001",
    max89,
    ind89
  );
  comp03: compartor GENERIC MAP (n,fc) PORT MAP(
    max01,
    max23,
    ind01,
    ind23,
    max03,
    ind03
  );
  comp47: compartor GENERIC MAP (n,fc) PORT MAP(
    max45,
    max67,
    ind45,
    ind67,
    max47,
    ind47
  );
  comp49: compartor GENERIC MAP (n,fc) PORT MAP(
    max47,
    max89,
    ind47,
    ind89,
    max49,
    ind49
  );
  compfinal: compartor GENERIC MAP (n,fc) PORT MAP(
    max03,
    max49,
    ind03,
    ind49,
    max,
    ind
  );
END a_softmax;