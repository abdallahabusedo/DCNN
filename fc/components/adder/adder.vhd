library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.fixed_pkg.all;

entity adder is
  port (
    a: in std_logic_vector(15 downto 0);
    b: in std_logic_vector(15 downto 0);
    res: out std_logic_vector(15 downto 0)
  ) ;
end adder;

architecture adder_arch of adder is
    signal asf: sfixed(4 downto -11);
    signal bsf: sfixed(4 downto -11);
    signal ressf: sfixed(4 downto -11);
begin
    asf <= to_sfixed(a, 4, -11);
    bsf <= to_sfixed(b, 4, -11);
    ressf <= resize(asf + bsf, 4, -11);
    res <= to_slv(ressf);
end adder_arch ; -- adder_arch