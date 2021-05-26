LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY io_module IS
    PORT (
        DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        --DOUT               : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        cnn_image : IN STD_LOGIC;
        --done               : OUT STD_LOGIC;
        --ready_result       : IN STD_LOGIC;
        --result             : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        --memory wires
        address : OUT INTEGER;
        ramDataIn : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        writeRam : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

        ---
        startDecompression : IN STD_LOGIC;
        load_process : IN STD_LOGIC;
        stop : OUT STD_LOGIC;
        rowSize : OUT INTEGER;
        ---
        extrabits : IN INTEGER;
        initialRowSize : IN INTEGER;
        splitSize : IN INTEGER

    );

END io_module;

ARCHITECTURE io_module_arch OF io_module IS
    COMPONENT decompressor IS
        PORT (
            Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            startDecompression : IN STD_LOGIC;
            stop : OUT STD_LOGIC;
            cnn_image : IN STD_LOGIC;
            address : OUT INTEGER;
            ramDataIn : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            writeRam : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT io IS
        PORT (
            cpuData : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            startDecompression : IN STD_LOGIC;
            load_process : IN STD_LOGIC;
            rowSize : OUT INTEGER;
            extraBits : IN INTEGER; -- Extra Zeros because the row is not divisible by 16 (They should be removed from the received data)
            initialRowSize : IN INTEGER;
            splitSize : IN INTEGER;
            cnn_image : IN STD_LOGIC;
            splittedData : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );

    END COMPONENT;

    SIGNAL splittedData : STD_LOGIC_VECTOR(15 DOWNTO 0);


BEGIN

    io_interface : io PORT MAP(DIN, clk, rst, startDecompression, load_process, rowSize, extrabits, initialRowSize, splitsize, cnn_image, splittedData);

    decompressor_io : decompressor PORT MAP(splittedData, clk, rst, startDecompression, stop, cnn_image, address, ramDataIn, writeRam);

END io_module_arch;