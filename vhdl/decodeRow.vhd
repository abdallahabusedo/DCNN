LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY decompressor IS

	PORT (
		Data               : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		clk                : IN STD_LOGIC;
		startDecompression : IN STD_LOGIC;
		stop               : OUT STD_LOGIC := '0';
		loadCNN  	       : IN STD_LOGIC ;
		address            : OUT INTEGER := 0;
		ramDataIn          : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		writeRam           : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)

	);

END decompressor;
ARCHITECTURE decompressor_ARCHITECTURE OF decompressor IS
	
	SIGNAL rowImage         : STD_LOGIC_VECTOR(447 DOWNTO 0) := (OTHERS => '1');
	SIGNAL ZeroOne          : STD_LOGIC                      := '0';
	SIGNAL startStoring     : STD_LOGIC                      := '0';
	SIGNAL wasDecompressing : STD_LOGIC := '0';
	SIGNAL begining         : STD_LOGIC := '1';
	SIGNAL addressCounter   : INTEGER := 0;
	SIGNAL writeRamSignal   : STD_LOGIC_VECTOR(1 DOWNTO 0)   := "00";
	SIGNAL WriteCLK :std_logic;

BEGIN
	WriteCLK<=not clk;
	writeRam <= writeRamSignal;
	address <= addressCounter;
	--Code/Data = Number of zeros || Number of ones --
	ramDataIn <= rowImage(447 DOWNTO 432) when loadCNN='0'
		   ELSE Data ;					
	PROCESS (clk,loadCNN) IS
	BEGIN
	IF(loadCNN='0') THEN
		IF (startDecompression = '1') THEN
			wasDecompressing <= '1';
			stop             <= '1';
		END IF;
		IF (rising_edge(clk) AND startDecompression = '1') THEN
			IF (ZeroOne = '0') THEN
				rowImage <= STD_LOGIC_VECTOR(shift_left(unsigned(rowImage), to_integer(unsigned(Data))));
				ZeroOne  <= '1';
			ELSE
				rowImage <= STD_LOGIC_VECTOR(rotate_left(unsigned(rowImage), to_integer(unsigned(Data))));
				ZeroOne  <= '0';
			END IF;
		END IF;

		IF (startDecompression = '0' AND wasDecompressing = '1') THEN
			startStoring     <= '1';
			wasDecompressing <= '0';
			begining         <= '1';
			writeRamSignal <= "10";
			
		ELSIF (rising_edge(clk) AND startStoring = '1' AND begining = '0' AND addressCounter MOD 28 = 0) THEN
			stop         <= '0';
			writeRamSignal     <= "00";
			startStoring <= '0';
			rowImage     <= (OTHERS => '1');
			ZeroOne      <= '0';
		ELSIF (rising_edge(clk) AND startStoring = '1') THEN
			writeRamSignal <= "10";
			rowImage <= STD_LOGIC_VECTOR(shift_left(unsigned(rowImage), 16));
			begining <= '0';
		END IF;

	END IF;
	IF (rising_edge(clk) AND loadCNN = '1') THEN
		writeRamSignal <= "10";
			
	END IF;
	IF (falling_edge(loadCNN)) THEN
		writeRamSignal <= "00";
	END IF;
	
	

	IF (falling_edge(clk) AND writeRamSignal = "10" AND (startStoring = '1' or loadCNN='1')) THEN
		addressCounter <= addressCounter + 1;
	END IF;

	END PROCESS;

END decompressor_ARCHITECTURE;
