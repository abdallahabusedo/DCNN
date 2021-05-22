LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY cpu IS

	PORT (
		row   : IN STD_LOGIC_VECTOR(479 DOWNTO 0);
		cnnData:IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		loadCNN:IN STD_LOGIC;
		clk   : IN STD_LOGIC;
		ready : IN STD_LOGIC;
		send  : OUT STD_LOGIC;
		stop  : IN STD_LOGIC;
		data  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		startDecompression : OUT STD_LOGIC := '0';

		rowSize_vec                : IN STD_LOGIC_VECTOR(15 DOWNTO 0) ;

		extraBits_vec              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		--:= (others => '1');   --cpu
		initialRowSize             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) ;
		--:= (others => '1');
		--:= "0000100000000000";   --cpu
		splitSize                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
		--:= (others => '1') --cpu

	);

END cpu;

ARCHITECTURE cpu_ARCHITECTURE OF cpu IS

	SIGNAL currentIndex       : INTEGER                        := 0;
	SIGNAL rowSignal          : STD_LOGIC_VECTOR(479 DOWNTO 0) := (OTHERS => '1');
	SIGNAL tempRowSize        : INTEGER := 100;
	SIGNAL cnnDataCLK	      : std_logic;
	SIGNAL DOUT               : STD_LOGIC_VECTOR( 3 DOWNTO 0);
	SIGNAL rowSize            : INTEGER;
	SIGNAL extraBits            : INTEGER;
BEGIN
        rowSize <= to_integer(unsigned( rowSize_vec));
        extraBits_vec <=std_logic_vector(to_unsigned(extraBits, 16));
	cnnDataCLK<=not clk;
	PROCESS (clk,loadCNN,cnnDataCLK) IS
	BEGIN
		--Now the data is ready so we can send it 16 bit by 16 bit to the io--
		IF (rowSize        <= 0) THEN
			startDecompression <= '0';
		END IF;
		IF(falling_edge(cnnDataCLK) and loadCNN='1') THEN
			data<=cnnData;
		END IF;
		IF (stop = '0' and loadCNN='0') THEN
			IF (ready = '1' AND currentIndex = 1) THEN

				initialRowSize <= row(15 DOWNTO 0);
				tempRowSize    <= to_integer(unsigned(row(15 DOWNTO 0)));
				splitSize      <= row(31 DOWNTO 16);
				extraBits      <= 16 - (tempRowSize MOD 16); -- Extra Zeros because the row is not divisible by 16 (They should be removed from the sent data)
				rowSignal      <= row;
				rowSignal      <= STD_LOGIC_VECTOR(shift_right(unsigned(row), 32));
				send           <= '0';
			END IF;
			IF (rising_edge(clk)) THEN
				IF (ready = '1') THEN
					data         <= rowSignal(15 DOWNTO 0);
					rowSignal    <= STD_LOGIC_VECTOR(shift_right(unsigned(rowSignal), 16));
					currentIndex <= currentIndex + 1;
					tempRowSize  <= tempRowSize - 16;
				END IF;
				IF (currentIndex = 30 OR tempRowSize <= 0) THEN
					startDecompression                   <= '1';
					currentIndex                         <= 0;
					send                                 <= '1';
					tempRowSize                          <= 100;
				END IF;

			END IF;
		END IF;
	END PROCESS;

END cpu_ARCHITECTURE;
