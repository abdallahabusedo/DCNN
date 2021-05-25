library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity layer is
    generic (
        last_layer_values_count : integer := 3;  -- full input size
        neurons_count : integer := 10
    );
    port (
        values: in std_logic_vector(last_layer_values_count*16 - 1 downto 0);
        weights: in std_logic_vector(last_layer_values_count*neurons_count*16 - 1 downto 0);
        biases: in std_logic_vector(neurons_count*16 - 1 downto 0);
        enable: in std_ulogic;

        layer_out: out std_logic_vector(neurons_count * 16 - 1 downto 0);
        enable_next: out std_ulogic
    ) ;
end layer;

architecture layer_arch of layer is

    signal clk : std_ulogic := '1';
    signal acc_out : std_logic_vector(neurons_count * 16 - 1 downto 0) := (others => '0');
    signal neu_out : std_logic_vector(neurons_count * 16 - 1 downto 0) := (others => '0');
    signal cur_index : std_logic_vector (7 downto 0) := (others => '0');
    signal ii: integer := 0;
begin

    ii <= to_integer(unsigned(cur_index));

    -- Update clock
    clk <= not clk after 0.2 ns when enable = '1' else '0';

    neurons_generation : for i in 0 to (neurons_count-1) generate
        neuron: entity work.neuron
            GENERIC MAP (last_layer_values_count)
            PORT MAP (
                acc_out(15 + i*16 downto i*16),
                biases(15 + i*16 downto i*16),
                weights(((i+1)*16*last_layer_values_count) - 1 downto i*16*last_layer_values_count),
                values,
                cur_index,
                neu_out(15 + i*16 downto i*16)
            );
        accumulator: entity work.accumulator
            PORT MAP (
                clk,
                '0',
                neu_out(15 + i*16 downto i*16),
                acc_out(15 + i*16 downto i*16) 
            );
    end generate ; -- neurons_generation

    counter: entity work.counter 
        GENERIC MAP (last_layer_values_count+1)
        PORT MAP (clk, '0', cur_index);

    layer_out <= neu_out;

    enable_next <= '0' WHEN (ii < (last_layer_values_count + 1)) ELSE '1';

end layer_arch ; -- layer_arch