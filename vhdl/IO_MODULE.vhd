LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY io_module IS
	PORT (
	DIN                : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        --DOUT               : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	clk                : IN STD_LOGIC;
        cnn_image          : IN STD_LOGIC;
		--done               : OUT STD_LOGIC;
		--ready_result       : IN STD_LOGIC;
		--result             : IN STD_LOGIC_VECTOR(3 DOWNTO 0);


        --memory wires
        address              : OUT INTEGER := 0;
        ramDataIn            : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        writeRam             : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

        ---
        startDecompression : IN std_logic;
	    ready              : IN STD_LOGIC;
        stop               : OUT std_logic;
	    rowSize            : OUT INTEGER := 1;
        ---
        extrabits          : IN Integer := 100;
        initialRowSize     : IN INTEGER := 100;
        splitSize          : IN INTEGER := 100
      
	);

END io_module;

ARCHITECTURE io_module_arch OF io_module IS
    component decompressor is
        PORT (
            Data               : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk                : IN STD_LOGIC;
            startDecompression : IN STD_LOGIC;
            stop               : OUT STD_LOGIC := '0';
            loadCNN  	   : IN STD_LOGIC :='0';
            address            : OUT INTEGER := 0;
            ramDataIn          : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            writeRam           : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)   := "00"
        );
	END COMPONENT;
	
    component io is
        PORT (
            cpuData            : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk                : IN STD_LOGIC;
            startDecompression : IN STD_LOGIC;
            ready              : IN STD_LOGIC;
            rowSize            : OUT INTEGER := 1;
            extraBits          : IN INTEGER; -- Extra Zeros because the row is not divisible by 16 (They should be removed from the received data)
            initialRowSize     : IN INTEGER;
            splitSize          : IN INTEGER;
            loadCNN		       : IN STD_LOGIC;
            splittedData       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );

    END COMPONENT;

    signal splittedData     : STD_LOGIC_VECTOR(15 downto 0) ;

	BEGIN

    io_interface : io PORT MAP(DIN,clk,startDecompression,ready,rowSize,extrabits,initialRowSize,splitsize,cnn_image,splittedData);
    decompressor_io : decompressor PORT MAP(splittedData, clk,startDecompression , stop, cnn_image,address,ramDataIn,writeRam);

END io_module_arch;
