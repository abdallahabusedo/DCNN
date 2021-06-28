library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity accumulator is
  port (
    clk, rst: in std_ulogic;
    d: in std_logic_vector(15 downto 0);
    q: out std_logic_vector(15 downto 0)
  ) ;
end accumulator;

architecture accumulator_arch of accumulator is

    signal state: std_logic_vector(15 downto 0) := (others => '0');

begin
    q <= state;

    reg_proc : process( clk, rst )
    begin
        if (rst = '1') then
            state <= (others => '0');
        elsif (falling_edge(clk)) then
            state <= d;
        end if ;
    end process ; -- reg_proc
end accumulator_arch ; -- accumulator_arch