library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fc is
    generic (
        CNN_Values_Size: integer := 10;
        Layer1_Neurons_Count: integer := 5;
        Layer2_Neurons_Count: integer := 10;
        Data_Size: integer := 16;
        Precision: integer := 11
    );
    port (
        CNNOut    : in std_logic_vector(CNN_Values_Size*Data_Size - 1 downto 0);
        Weights1  : in std_logic_vector(CNN_Values_Size*Layer1_Neurons_Count*Data_Size - 1 downto 0);
        Weights2  : in std_logic_vector(Layer1_Neurons_Count*Layer2_Neurons_Count*Data_Size - 1 downto 0);
        Biases1   : in std_logic_vector(Layer1_Neurons_Count*Data_Size - 1 downto 0);
        Biases2   : in std_logic_vector(Layer2_Neurons_Count*Data_Size - 1 downto 0);
        enable    : in std_ulogic;

        Prediction: out std_logic_vector(3 downto 0);
        FCEN      : out std_ulogic
    ) ;
end fc;

architecture fc_arch of fc is

    signal Layer1Out: std_logic_vector(Layer1_Neurons_Count*Data_Size - 1 downto 0);
    signal Layer2Out: std_logic_vector(Layer2_Neurons_Count*Data_Size - 1 downto 0);
    signal Layer1En : std_ulogic := '0';
begin

    Layer1: entity work.layer
        GENERIC MAP (CNN_Values_Size, Layer1_Neurons_Count)
        PORT MAP (CNNOut, Weights1, Biases1, enable, Layer1Out, Layer1En);

    Layer2: entity work.layer
        GENERIC MAP (Layer1_Neurons_Count, Layer2_Neurons_Count)
        PORT MAP (Layer1Out, Weights2, Biases2, Layer1En, Layer2Out, FCEN);
    
    Maximizer: entity work.softmax
        GENERIC MAP (Data_Size*Layer2_Neurons_Count, Data_Size, Precision)
        PORT MAP (Layer2Out, Prediction);

end fc_arch ; -- fc_arch