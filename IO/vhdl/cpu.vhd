LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
--USE IEEE.std_logic_unsigned.ALL;
ENTITY cpu IS
	PORT (
		row : IN STD_LOGIC_VECTOR(479 DOWNTO 0);
		cnnData : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		cnn_image : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		load_process : IN STD_LOGIC;
		send : OUT STD_LOGIC;
		stop : IN STD_LOGIC;
		data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		startDecompression : OUT STD_LOGIC;

		rowSize_vec : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --cpu;

		extraBits_vec : OUT STD_LOGIC_VECTOR(15 DOWNTO 0):=(others=>'0'); --cpu
		initialRowSize : OUT STD_LOGIC_VECTOR(15 DOWNTO 0):=(others=>'0');
		splitSize : OUT STD_LOGIC_VECTOR(15 DOWNTO 0):=(others=>'0')

	);

END cpu;

ARCHITECTURE cpu_ARCHITECTURE OF cpu IS

	SIGNAL currentIndex : INTEGER;
	SIGNAL rowSignal : STD_LOGIC_VECTOR(479 DOWNTO 0);
	SIGNAL tempRowSize : INTEGER;
	SIGNAL cnnDataCLK : STD_LOGIC;
	SIGNAL DOUT : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rowSize : INTEGER;
	SIGNAL extraBits : INTEGER:=0;
BEGIN
	rowSize <= to_integer(unsigned(rowSize_vec));
	extraBits_vec <= STD_LOGIC_VECTOR(to_unsigned(extraBits, 16));
	cnnDataCLK <= NOT clk;

	PROCESS (clk, cnn_image, cnnDataCLK, rst) IS
	BEGIN
		--Now the data is ready so we can send it 16 bit by 16 bit to the io--
		IF (rst = '1') THEN
			startDecompression <= '0';
			currentIndex <= 0;
			rowSignal <= (OTHERS => '1');
			splitSize <= (OTHERS => '1');
			initialRowSize <= "0000100000000000";
			tempRowSize <= 100;
			extraBits <= 100;
		ELSE
			IF (rowSize = 0 AND stop = '1') THEN
				startDecompression <= '0';
			END IF;
			IF (falling_edge(cnnDataCLK) AND cnn_image = '1') THEN
				data <= cnnData;
			END IF;
			IF (stop = '0' AND cnn_image = '0') THEN
				IF (load_process = '1' AND currentIndex = 1) THEN

					initialRowSize <= row(15 DOWNTO 0);
					tempRowSize <= to_integer(unsigned(row(15 DOWNTO 0)));
					splitSize <= row(31 DOWNTO 16);
					extraBits <= 16 - (tempRowSize MOD 16); -- Extra Zeros because the row is not divisible by 16 (They should be removed from the sent data)
					rowSignal <= row;
					rowSignal <= STD_LOGIC_VECTOR(shift_right(unsigned(row), 32));
					send <= '0';
				END IF;
				IF (rising_edge(clk)) THEN
					IF (load_process = '1') THEN
						data <= rowSignal(15 DOWNTO 0);
						rowSignal <= STD_LOGIC_VECTOR(shift_right(unsigned(rowSignal), 16));
						currentIndex <= currentIndex + 1;
						tempRowSize <= tempRowSize - 16;
					END IF;
					IF (currentIndex = 30 OR tempRowSize <= 0) THEN
						startDecompression <= '1';
						currentIndex <= 0;
						send <= '1';
						tempRowSize <= 100;
					END IF;

				END IF;
			END IF;
		END IF;
	END PROCESS;

END cpu_ARCHITECTURE;