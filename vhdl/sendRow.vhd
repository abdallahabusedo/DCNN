LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY sendRow IS

	PORT (
		row   : IN STD_LOGIC_VECTOR(479 DOWNTO 0);
		clk   : IN STD_LOGIC;
		ready : IN STD_LOGIC;
		send  : OUT STD_LOGIC;
		stop  : INOUT STD_LOGIC
	);

END sendRow;

ARCHITECTURE sendRow_ARCHITECTURE OF sendRow IS
	COMPONENT io IS
		PORT (
			cpuData            : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			clk                : IN STD_LOGIC;
			startDecompression : INOUT STD_LOGIC;
			ready              : IN STD_LOGIC;
			stop               : OUT STD_LOGIC;
			rowSize            : INOUT INTEGER := 1;
			extraBits          : IN INTEGER;
			initialRowSize     : IN INTEGER;
			splitSize          : IN INTEGER
		);

	END COMPONENT;

	SIGNAL currentIndex       : INTEGER                        := 0;
	SIGNAL data               : STD_LOGIC_VECTOR(15 DOWNTO 0)  := (OTHERS => '1');
	SIGNAL startDecompression : STD_LOGIC                      := '0';
	SIGNAL rowSignal          : STD_LOGIC_VECTOR(479 DOWNTO 0) := (OTHERS => '1');
	SIGNAL rowSize            : INTEGER;
	SIGNAL tempRowSize        : INTEGER := 100;
	SIGNAL splitSize          : INTEGER := 100;
	SIGNAL initialRowSize     : INTEGER := 100;
	SIGNAL extraBits          : INTEGER := 100;

BEGIN

	PROCESS (clk) IS
	BEGIN
		--Now the data is ready so we can send it 16 bit by 16 bit to the io--
		IF (rowSize        <= 0) THEN
			startDecompression <= '0';
		END IF;
		IF (stop = '0') THEN
			IF (ready = '1' AND currentIndex = 1) THEN

				initialRowSize <= to_integer(unsigned(row(15 DOWNTO 0)));
				tempRowSize    <= to_integer(unsigned(row(15 DOWNTO 0)));
				splitSize      <= to_integer(unsigned(row(31 DOWNTO 16)));
				extraBits      <= 16 - (initialRowSize MOD 16);
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
	sendIO : io PORT MAP(data, clk, startDecompression, ready, stop, rowSize, extraBits, initialRowSize, splitSize);

END sendRow_ARCHITECTURE;
