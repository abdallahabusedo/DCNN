LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY io_module IS
	PORT (
		DIN                : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		DOUT               : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		CLK                : IN STD_LOGIC;
		Load_Process       : IN STD_LOGIC;
		CNN_IMAGE          : IN STD_LOGIC;
		done               : OUT STD_LOGIC;
		RESULT_DONE        : IN STD_LOGIC;
		RESULT             : IN STD_LOGIC_VECTOR(15 DOWNTO 0)

	);

END io_module;

ARCHITECTURE io_module_arch OF io_module IS
	COMPONENT decompressor IS

		PORT (
			Data               : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			clk                : IN STD_LOGIC;
			startDecompression : IN STD_LOGIC;
			stop               : OUT STD_LOGIC := '0';
			loadCNN  	   : IN STD_LOGIC 
		);

	END COMPONENT;

	SIGNAL row          : STD_LOGIC_VECTOR(479 DOWNTO 0) := (OTHERS => '0');
	SIGNAL clk2         : STD_LOGIC;
	
	SIGNAL splittedData : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
	clk2 <= NOT clk;
	
	PROCESS (clk2,clk,loadCNN) IS
	BEGIN
	IF(rising_edge(clk2) and loadCNN='1') THEN
		splittedData<=cpuData;
	ELSE 
		IF (rising_edge(clk2) AND ready = '1' AND startDecompression = '0') THEN

			row                 <= STD_LOGIC_VECTOR(shift_right(unsigned(row), 16));
			row(479 DOWNTO 464) <= cpuData;
		END IF;

		IF (rising_edge(startDecompression)) THEN
			rowSize <= initialRowSize;
			row     <= STD_LOGIC_VECTOR(shift_left(unsigned(row), extraBits)); -- Removing Extra Zeros that exists because row is not divisible by 16
		END IF;
		IF (rising_edge(clk2) AND startDecompression = '1') THEN

			IF (splitSize = 1) THEN
				splittedData <= "000000000000000" & row(479);
				row          <= STD_LOGIC_VECTOR(shift_left(unsigned(row), 1));
			ELSIF (splitSize = 2) THEN
				splittedData <= "00000000000000" & row(479 DOWNTO 478);
				row          <= STD_LOGIC_VECTOR(shift_left(unsigned(row), 2));
			ELSIF (splitSize = 3) THEN
				splittedData <= "0000000000000" & row(479 DOWNTO 477);
				row          <= STD_LOGIC_VECTOR(shift_left(unsigned(row), 3));
			ELSIF (splitSize = 4) THEN
				splittedData <= "000000000000" & row(479 DOWNTO 476);
				row          <= STD_LOGIC_VECTOR(shift_left(unsigned(row), 4));
			ELSIF (splitSize = 5) THEN
				splittedData <= "00000000000" & row(479 DOWNTO 475);
				row          <= STD_LOGIC_VECTOR(shift_left(unsigned(row), 5));
			ELSIF (splitSize = 6) THEN
				splittedData <= "0000000000" & row(479 DOWNTO 474);
				row          <= STD_LOGIC_VECTOR(shift_left(unsigned(row), 6));
			ELSIF (splitSize = 7) THEN
				splittedData <= "000000000" & row(479 DOWNTO 473);
				row          <= STD_LOGIC_VECTOR(shift_left(unsigned(row), 7));
			ELSIF (splitSize = 8) THEN
				splittedData <= "00000000" & row(479 DOWNTO 472);
				row          <= STD_LOGIC_VECTOR(shift_left(unsigned(row), 8));
			ELSIF (splitSize = 9) THEN
				splittedData <= "0000000" & row(479 DOWNTO 471);
				row          <= STD_LOGIC_VECTOR(shift_left(unsigned(row), 9));
			END IF;
			rowSize <= rowSize - splitSize;
		END IF;
	END IF;
	END PROCESS;
	DecompressorIO : decompressor PORT MAP(splittedData, clk, startDecompression, stop,loadCNN);
END ioo;