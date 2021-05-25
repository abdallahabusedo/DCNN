LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY io IS
	PORT (
		cpuData            : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		clk                : IN STD_LOGIC;
		rst                : IN STD_LOGIC;
		startDecompression : IN STD_LOGIC;
		ready              : IN STD_LOGIC;
		rowSize            : OUT INTEGER;
		extraBits          : IN INTEGER ; -- Extra Zeros because the row is not divisible by 16 (They should be removed from the received data)
		initialRowSize     : IN INTEGER ;
		splitSize          : IN INTEGER ;
		loadCNN		   : IN STD_LOGIC;
		splittedData       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)

	);

END io;

ARCHITECTURE ioo OF io IS

	SIGNAL row          : STD_LOGIC_VECTOR(479 DOWNTO 0);
	SIGNAL clk2         : STD_LOGIC;
	SIGNAL rowSizeSignal: INTEGER;
	 
BEGIN
	clk2 <= NOT clk;
	rowSize <= rowSizeSignal;
	
	PROCESS (clk2,clk,loadCNN,rst) IS
	BEGIN
	IF (rst = '1') THEN
		rowSizeSignal <= 1;
	ELSE
		IF(rising_edge(clk2) and loadCNN='1') THEN
			splittedData<=cpuData;
			row <=  (OTHERS => '0');
		ELSE 
			IF (rising_edge(clk2) AND ready = '1' AND startDecompression = '0') THEN
				row                 <= STD_LOGIC_VECTOR(shift_right(unsigned(row), 16));
				row(479 DOWNTO 464) <= cpuData;
			END IF;

			IF (rising_edge(startDecompression)) THEN
				rowSizeSignal <= initialRowSize;
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
				rowSizeSignal <= rowSizeSignal - splitSize;
			END IF;
		END IF;
	END IF;
	END PROCESS;
	
END ioo;
