LIBRARY IEEE;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.float_pkg.ALL;
USE work.c_pkg.ALL;

ENTITY cnn_integration IS
GENERIC (WINDOW_SIZE : INTEGER := 2; IMG_SIZE : INTEGER := 22; POOLING_FILTER_SIZE : INTEGER := 2 ; FILTER_SIZE : INTEGER := 3; CONV_LAYER1_SIZE : INTEGER := 2; CONV_LAYER2_SIZE : INTEGER := 2; CONV_LAYER3_SIZE : INTEGER := 2);
	PORT(
		clk,START,rst:IN STD_LOGIC;
		data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		address : OUT INTEGER;
		WR : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- 01 read 10 write
		Done : OUT STD_LOGIC := '0' 
	);
END ENTITY;
ARCHITECTURE arch_cnn_integration OF cnn_integration IS
	COMPONENT convolute_images IS
		GENERIC (FILTER_SIZE : INTEGER := 3;IMG_SIZE : INTEGER := 5;images_count: INTEGER:=3;filters_count: INTEGER:=1);
		PORT(
			IMGs : IN std_logic_vector(images_count*IMG_SIZE*IMG_SIZE*16-1 Downto 0);
			FILTERs : IN std_logic_vector(images_count*filters_count*FILTER_SIZE*FILTER_SIZE*16-1 Downto 0);
			avg_imgs : OUT std_logic_vector(filters_count*(IMG_SIZE-FILTER_SIZE+1)*(IMG_SIZE-FILTER_SIZE+1)*16-1 Downto 0);
			end_conv :OUT std_logic;
			clk,strat_signal,rst:IN std_logic
		);
	END COMPONENT;
	COMPONENT Pooling_layer IS
		generic (WINDOW_SIZE : integer := 2 ; Maps_Count : integer := 2 ;IMG_SIZE : integer := 4);
		PORT(
			InFeatureMaps : IN  std_logic_vector((Maps_Count*IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0);                     
			rst , START , clk:IN std_logic;
			OutFeatureMaps : OUT std_logic_vector((Maps_Count*(IMG_SIZE/2)*(IMG_SIZE/2)*16)-1 DOWNTO 0);	
			Done : OUT std_logic
		); 
	END COMPONENT;
	COMPONENT read_ram IS
		GENERIC (size : INTEGER :=5);
		PORT(
			clk,rst : IN STD_LOGIC; 
			enable : IN STD_LOGIC;
			init_address : IN INTEGER;
			count : IN INTEGER ;
			data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			done : OUT STD_LOGIC;
			read_address : OUT INTEGER;
			dataout : OUT  STD_LOGIC_VECTOR((16*size)-1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT write_ram IS
		GENERIC (size : INTEGER :=5);
		PORT(
			clk : IN STD_LOGIC; 
			enable : IN STD_LOGIC;
			init_address : IN INTEGER;
			count : IN INTEGER;
			data_in : IN STD_LOGIC_VECTOR((16*size)-1 DOWNTO 0);
			done : OUT STD_LOGIC;
			write_address : OUT INTEGER;
			dataout : OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	----------------conv signals---------------------------
	SIGNAL conv0_avg_imgs : std_logic_vector(CONV_LAYER1_SIZE*((IMG_SIZE-FILTER_SIZE+1)**2)*16-1 Downto 0);
	SIGNAL conv0_END_conv,conv0_start_signal : STD_LOGIC;
	-------------------------------------------------------
	SIGNAL conv1_avg_imgs : std_logic_vector(CONV_LAYER2_SIZE*(((((IMG_SIZE-FILTER_SIZE+1)/2)-FILTER_SIZE+1))**2)*16-1 Downto 0);
	SIGNAL conv1_END_conv,conv1_start_signal : STD_LOGIC;
	-------------------------------------------------------
	SIGNAL conv2_avg_imgs : std_logic_vector((CONV_LAYER3_SIZE*(((((((IMG_SIZE-FILTER_SIZE+1)/2)-FILTER_SIZE+1))/2)-FILTER_SIZE+1)**2)*16)-1 Downto 0);
	SIGNAL conv2_END_conv,conv2_start_signal : STD_LOGIC;
	-------------------------------------------------------


	---------------------pooling signals-------------------                     
	SIGNAL pool0_OutFeatureMaps : std_logic_vector(CONV_LAYER1_SIZE*(((IMG_SIZE-FILTER_SIZE+1)/2)**2)*16-1 DOWNTO 0);	
	SIGNAL pool0_done : STD_LOGIC ;
	SIGNAL pool0_start: STD_LOGIC;
	-------------------------------------------------------                     
	SIGNAL pool1_OutFeatureMaps : std_logic_vector(CONV_LAYER2_SIZE*(((((IMG_SIZE-FILTER_SIZE+1)/2)-FILTER_SIZE+1)/2)**2)*16-1 DOWNTO 0);
	SIGNAL pool1_done : STD_LOGIC ;
	SIGNAL pool1_start: STD_LOGIC;
	---------------------read ram images------------------
	SIGNAL read_img_enable : STD_LOGIC;
	SIGNAL read_img_rst : STD_LOGIC;
    SIGNAL read_img_init_address : INTEGER;
	SIGNAL read_img_count : INTEGER;
    SIGNAL read_img_data_in : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL read_img_done : STD_LOGIC;
    SIGNAL read_img_read_address : INTEGER;
    SIGNAL read_img_dataout : STD_LOGIC_VECTOR((IMG_SIZE*IMG_SIZE*16)-1 DOWNTO 0);

	---------------------read ram filters------------------ 
	SIGNAL read_fil_enable : STD_LOGIC;
	SIGNAL read_fil_rst : STD_LOGIC;
    SIGNAL read_fil_init_address : INTEGER;
	SIGNAL read_fil_count : INTEGER;
    SIGNAL read_fil_data_in : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL read_fil_done : STD_LOGIC;
    SIGNAL read_fil_read_address : INTEGER;
    SIGNAL read_fil_dataout : STD_LOGIC_VECTOR((FILTER_SIZE*FILTER_SIZE*CONV_LAYER3_SIZE*CONV_LAYER2_SIZE*16)-1 DOWNTO 0);
	------------------write IN RAM signals----------------
	SIGNAL write_enable : STD_LOGIC;
	SIGNAL write_init_address : INTEGER;
	SIGNAL write_count : INTEGER;
	SIGNAL write_data_in : STD_LOGIC_VECTOR((CONV_LAYER3_SIZE*16)-1 DOWNTO 0); --take care it is IN the updated form not the old one
	SIGNAL write_done : STD_LOGIC;
	SIGNAL write_address : INTEGER;
	SIGNAL write_dataout : STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	
	----------------------temp signals---------------------
	SIGNAL step_counter : INTEGER;

	
	BEGIN
	R0:read_ram GENERIC MAP (IMG_SIZE*IMG_SIZE) PORT MAP(
		clk,
		read_img_rst,
		read_img_enable,
		read_img_init_address,
		read_img_count,
		data_in,
		read_img_done,
		read_img_read_address,
		read_img_dataout
	);

	R1:read_ram GENERIC MAP (FILTER_SIZE*FILTER_SIZE*CONV_LAYER3_SIZE*CONV_LAYER2_SIZE) PORT MAP(
		clk,
		read_fil_rst,
		read_fil_enable,
		read_fil_init_address,
		read_fil_count,
		data_in,
		read_fil_done,
		read_fil_read_address,
		read_fil_dataout
	);

	W0:write_ram GENERIC MAP(CONV_LAYER3_SIZE*(((((((IMG_SIZE-FILTER_SIZE+1)/2)-FILTER_SIZE+1))/2)-FILTER_SIZE+1)**2)) PORT MAP(
		clk, 
		write_enable,
		write_init_address,
		write_count,
		conv2_avg_imgs,
		write_done,
		write_address,
		write_dataout
	);
	
	CONV0:convolute_images GENERIC MAP (FILTER_SIZE,IMG_SIZE,1,CONV_LAYER1_SIZE) PORT MAP(
		read_img_dataout,
		read_fil_dataout((FILTER_SIZE*FILTER_SIZE*CONV_LAYER1_SIZE*16)-1 DOWNTO 0),
		conv0_avg_imgs,
		conv0_END_conv,
		clk,
		conv0_start_signal,
		rst
		);
	
	P0:Pooling_layer GENERIC MAP (POOLING_FILTER_SIZE,CONV_LAYER1_SIZE,IMG_SIZE-FILTER_SIZE+1)PORT MAP(
		conv0_avg_imgs,
		rst,
		pool0_start,
		clk,
		pool0_OutFeatureMaps,
		pool0_done
		);
	
	CONV1:convolute_images GENERIC MAP (FILTER_SIZE,(IMG_SIZE-FILTER_SIZE+1)/2,CONV_LAYER1_SIZE,CONV_LAYER2_SIZE) PORT MAP(
		pool0_OutFeatureMaps,
		read_fil_dataout((FILTER_SIZE*FILTER_SIZE*CONV_LAYER2_SIZE*CONV_LAYER1_SIZE*16)-1 DOWNTO 0),
		conv1_avg_imgs,
		conv1_END_conv,
		clk,
		conv1_start_signal,
		rst
		);

	P1:Pooling_layer GENERIC MAP (POOLING_FILTER_SIZE,CONV_LAYER2_SIZE,(((IMG_SIZE-FILTER_SIZE+1)/2)-FILTER_SIZE+1))PORT MAP(
		conv1_avg_imgs,
		rst,
		pool1_start,
		clk,
		pool1_OutFeatureMaps,
		pool1_done
	);

    CONV2:convolute_images GENERIC MAP (FILTER_SIZE,(((IMG_SIZE-FILTER_SIZE+1)/2)-FILTER_SIZE+1)/2,CONV_LAYER2_SIZE,CONV_LAYER3_SIZE) PORT MAP(
		pool1_OutFeatureMaps,
		read_fil_dataout((FILTER_SIZE*FILTER_SIZE*CONV_LAYER2_SIZE*CONV_LAYER3_SIZE*16)-1 DOWNTO 0),
		conv2_avg_imgs,
		conv2_END_conv,
		clk,
		conv2_start_signal,
		rst
	);



	PROCESS(clk,START,rst) IS
		VARIABLE i:INTEGER := 0;
	BEGIN
		IF(rst ='1') THEN
			--conv0_END_conv <= '0';
			--conv0_start_signal <= '0';
			--conv1_END_conv <= '0';
			--conv1_start_signal <= '0';
			--conv2_END_conv <= '0';
			--conv2_start_signal <= '0';
			--pool0_done <= '0';
			--pool0_start <= '0';
			--pool1_done <= '0';
			--pool1_start <= '0';
			--read_img_enable <= '0';
			--read_img_done <= '0';
			--read_fil_enable <= '0';
			--read_fil_done <= '0';
			--write_enable <= '0';
			--write_done <= '0';
			step_counter <= 0;
		END IF;

		IF(rising_edge(clk)) THEN
			IF(START = '1' AND step_counter = 0) THEN
				read_img_init_address <= 100;    --- we need to correct it with correct address of image
				read_img_count <= IMG_SIZE*IMG_SIZE;
				read_img_enable <= '1';
				WR <= "01";
				step_counter <= 1; 
			END IF;

			IF(read_img_done = '1' AND step_counter < 3) THEN
				step_counter <= step_counter+1;
				--read_fil_rst <= '1';
			END IF; 

			IF(read_img_done = '1' AND step_counter = 3) THEN
				--read_fil_rst <= '0';
				WR <= "01";
				read_img_enable <= '0';
				read_fil_count <= FILTER_SIZE*FILTER_SIZE*CONV_LAYER1_SIZE;
				read_fil_enable <= '1';
				read_fil_init_address <= 200;  --- we need to correct it with correct address of filter
				step_counter <= 4;
			END IF;

			IF(read_fil_done = '1' AND step_counter < 6) THEN
				step_counter <= step_counter+1;
			END IF; 
			
			IF(read_fil_done = '1' AND step_counter = 6) THEN
				WR <= "00";
				read_fil_enable <= '0';
				conv0_start_signal <= '1';
				step_counter <= 7;
			END IF;

			IF(conv0_end_conv = '1' AND step_counter < 9) THEN
				step_counter <= step_counter+1;
			END IF; 

			IF (conv0_end_conv = '1' AND step_counter = 9) THEN
				conv0_start_signal <= '0';
				pool0_start <= '1';
				step_counter <= 10;
			END IF;

			IF(pool0_done = '1' AND step_counter < 12) THEN
				step_counter <= step_counter+1; 
				read_fil_rst <= '1';
			END IF; 

			IF (pool0_done = '1' AND step_counter = 12) THEN
				read_fil_rst <= '0';
				pool0_start <= '0';
				WR <= "01"; --read image
				read_fil_count <= FILTER_SIZE*FILTER_SIZE*CONV_LAYER2_SIZE*CONV_LAYER1_SIZE;
				read_fil_enable <= '1';
				read_fil_init_address <= 300;
				step_counter <= 13;
			END IF;

			IF(read_fil_done = '1' AND step_counter < 15 AND step_counter > 12) THEN
				step_counter <= step_counter+1;
			END IF; 

			IF(read_fil_done = '1' AND step_counter = 15) THEN
				read_fil_enable <= '0';
				WR <= "00";
				conv1_start_signal <= '1';
				step_counter <= 16;
			END IF;

			IF(conv1_end_conv = '1' AND step_counter < 18 AND step_counter > 15) THEN
				step_counter <= step_counter+1;
			END IF; 
			
			IF(conv1_end_conv = '1' AND step_counter = 18) THEN
				conv1_start_signal <= '0';
				step_counter <= 19;
				if(pool1_done = '1')THEN
					pool1_start <= '0';
				else
					pool1_start <= '1';
				end if ;
			END IF;

			IF(pool1_done = '1' AND step_counter < 21 AND step_counter > 18) THEN
				step_counter <= step_counter+1;
				pool1_start <= '0';
			    read_fil_rst <= '1';
			END IF; 

			IF (pool1_done = '1' AND step_counter = 21) THEN
			   read_fil_rst <= '0';
				WR <= "01"; --read image
				read_fil_count <= FILTER_SIZE*FILTER_SIZE*CONV_LAYER3_SIZE*CONV_LAYER2_SIZE;
				read_fil_enable <= '1';
				read_fil_init_address <= 400;  --- we need to correct it with correct address of image
				step_counter <= 22;
			END IF;

			IF(read_fil_done = '1' AND step_counter < 24 AND step_counter > 21) THEN
				step_counter <= step_counter+1;
			END IF; 

			IF(read_fil_done = '1' AND step_counter = 24) THEN
				read_fil_enable <= '0';
				WR <= "00";
				conv2_start_signal <= '1';
				step_counter <= 25;
			END IF;

			IF(conv2_end_conv = '1' AND step_counter < 27 AND step_counter > 24) THEN
				step_counter <= step_counter+1;
			END IF; 

			IF(conv2_end_conv = '1' AND step_counter = 27) THEN
			conv2_start_signal <= '0';
			WR <= "10"; --write image
			write_count <= CONV_LAYER3_SIZE;
			write_enable <= '1';
			write_init_address <= 500;  --- we need to correct it with correct address of filter
			Done <= '1';
			step_counter <= 28;
			END IF;
		END IF;
	END PROCESS;

END arch_cnn_integration;
