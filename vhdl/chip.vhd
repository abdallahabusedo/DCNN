LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
--USE IEEE.std_logic_unsigned.ALL;
ENTITY chip IS

    PORT (
        load_process : IN STD_LOGIC; --cpu
        cnn_image : IN STD_LOGIC; --testbench
        clk : IN STD_LOGIC; --testbench
        rst : IN STD_LOGIC;
        send : IN STD_LOGIC; --cpu

        stop : OUT STD_LOGIC; --io 
        result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
        data : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --cpu
        startDecompression : IN STD_LOGIC; --cpu
        rowSize_vec : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- to cpu
        extraBits_vec : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --cpu
        initialRowSize_vec : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --cpu
        splitSize_vec : IN STD_LOGIC_VECTOR(15 DOWNTO 0) --cpu
    );

END chip;

ARCHITECTURE chip_ARCHITECTURE OF chip IS
    COMPONENT io_module IS

        PORT (
            DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            cnn_image : IN STD_LOGIC;

            --memory wires
            address : OUT INTEGER := 0;
            ramDataIn : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            writeRam : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

            startDecompression : IN STD_LOGIC;
            load_process : IN STD_LOGIC;
            stop : OUT STD_LOGIC;
            rowSize : OUT INTEGER;

            ---
            extrabits : IN INTEGER;
            initialRowSize : IN INTEGER;
            splitSize : IN INTEGER
        );

    END COMPONENT;

    COMPONENT ram_entity IS

        PORT (
            clk : IN STD_LOGIC;
            Address : IN INTEGER;
            DATAIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ReadWriteSignals : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            DATAOUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );

    END COMPONENT;

    SIGNAL address : INTEGER;
    SIGNAL ramDataIn : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL writeRam : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL ramDataOUT : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL extraBits : INTEGER;
    SIGNAL initialRowSize : INTEGER;
    SIGNAL splitSize : INTEGER;
    SIGNAL rowSize : INTEGER;
    SIGNAL ioCLK : std_logic;
    --  SIGNAL stop_signal        : STD_LOGIC;              

BEGIN
    extraBits <= to_integer(unsigned(extraBits_vec));
    initialRowSize <= to_integer(unsigned(initialRowSize_vec));
    splitSize <= to_integer(unsigned(splitSize_vec));
    rowSize_vec <= STD_LOGIC_VECTOR(to_unsigned(rowSize, 16));
    -- stop <= stop_signal;

    sendIO : io_module PORT MAP(
        data, clk, rst, cnn_image,
        address, ramDataIn, writeRam,
        startDecompression, load_process, stop, rowSize, extraBits, initialRowSize, splitSize);

    ram : ram_entity PORT MAP(clk, address, ramDataIn, writeRam, ramDataOUT);

END chip_ARCHITECTURE;