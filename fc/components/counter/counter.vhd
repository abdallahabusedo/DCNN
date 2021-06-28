library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
    generic (
        max: integer := 120
    );
    port (
        clk, rst: in std_ulogic;
        count: out std_logic_vector(7 downto 0)
    ) ;
end counter;

architecture counter_arch of counter is
    signal state: integer := 0;
begin
    count <= std_logic_vector(to_unsigned(state, 8));
    counter_proc : process( clk, rst )
    begin
        if (rst = '1') then
            state <= 0;
        elsif (rising_edge(clk) and state < max) then
            state <= state + 1;
        end if ;
    end process ; -- counter_proc

end counter_arch ; -- counter_arch