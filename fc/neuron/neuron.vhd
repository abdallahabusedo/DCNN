library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.fixed_pkg.all;

entity neuron is
    generic (
        last_layer_values_count : integer := 3  -- full input size
    );
    port (
        acc     : in std_logic_vector(15 downto 0);
        bias    : in std_logic_vector(15 downto 0);
        weights : in std_logic_vector(last_layer_values_count*16 - 1 downto 0);
        values  : in std_logic_vector(last_layer_values_count*16 - 1 downto 0);
        index   : in std_logic_vector (7 downto 0);
        new_acc : out std_logic_vector(15 downto 0)
    );
end neuron;

architecture neuron_arch of neuron is
    signal mult_out: std_logic_vector (15 downto 0) := (others => '0');
    signal adder_opd_2: std_logic_vector (15 downto 0) := (others => '0');
    signal i: integer := 0;
begin

    i <= to_integer(unsigned(index)) * 16;

    multiplier: entity work.multiplier GENERIC MAP (last_layer_values_count, 16) PORT MAP (weights, values, i, mult_out);
    
    adder_opd_2 <= bias WHEN (i = 16*last_layer_values_count) ELSE mult_out;
    
    adder: entity work.adder PORT MAP (acc, adder_opd_2, new_acc); 

end neuron_arch ; -- neuron_arch