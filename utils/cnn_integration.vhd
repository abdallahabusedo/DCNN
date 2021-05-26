LIBRARY IEEE;
USE IEEE.fixed_float_types.ALL;
USE IEEE.fixed_pkg.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.float_pkg.ALL;
USE work.c_pkg.ALL;

ENTITY cnn_integration IS
GENERIC (WINDOW_SIZE : INTEGER := 2);
	PORT(
		clk,START,rst:IN STD_LOGIC;
		data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		address : OUT INTEGER;
		RW : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- 01 read 10 write
		Done : OUT STD_LOGIC := '0' 
	);
END ENTITY;
ARCHITECTURE arch_cnn_integration OF cnn_integration IS
	COMPONENT convolute_images IS
		GENERIC (FILTER_SIZE : INTEGER := 3;IMG_SIZE : INTEGER := 5;images_count: INTEGER:=3;filters_count: INTEGER:=1);
		PORT(
		IMGs : IN convolution_imags_type;
		FILTERs : IN convolution_filtters_type;
		avg_imgs : OUT convolution_imags_type;
		END_conv :OUT STD_LOGIC;
		clk,strat_signal:IN STD_LOGIC
	);
	END COMPONENT;
	COMPONENT Pooling_layer IS
		PORT(
		InFeatureMaps : IN convolution_imags_type;                      
		OutFeatureMaps : OUT convolution_imags_type;	
		Done : OUT STD_LOGIC := '0';
		clk,START:IN STD_LOGIC
	); 
	END COMPONENT;
	COMPONENT cnn_read_ram_fil IS
		PORT(
            clk : IN STD_LOGIC; 
            enable : IN STD_LOGIC;
            init_address : IN INTEGER;
            data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            done : OUT STD_LOGIC;
            read_address : OUT INTEGER;
            dataout : OUT filter_array
    );
	END COMPONENT;
	COMPONENT cnn_read_ram_img IS
		PORT(
            clk : IN STD_LOGIC; 
            enable : IN STD_LOGIC;
            init_address : IN INTEGER;
            data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            done : OUT STD_LOGIC;
            read_address : OUT INTEGER;
            dataout : OUT img_array
    	);
	END COMPONENT;
	--wrong component either change the component or the array
	--find solution to USE the same conv AND pool layers
	COMPONENT write_ram IS
		GENERIC (count : integer :=5);
		PORT(
			clk : IN STD_LOGIC; 
			enable : IN STD_LOGIC;
			init_address : IN INTEGER;
			data_in : IN STD_LOGIC_VECTOR((16*count)-1 DOWNTO 0);
			done : OUT STD_LOGIC;
			write_address : OUT INTEGER;
			dataout : OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	----------------conv signals---------------------------
	SIGNAL conv0_avg_imgs : convolution_imags_type;
	SIGNAL conv0_END_conv,conv0_start_signal : STD_LOGIC;
	SIGNAL img_dataout_temp : convolution_imags_type;
	SIGNAL fil_dataout_temp : convolution_filtters_type;
	-------------------------------------------------------
	SIGNAL conv1_avg_imgs : convolution_imags_type;
	SIGNAL conv1_END_conv,conv1_start_signal : STD_LOGIC;
	-------------------------------------------------------
	SIGNAL conv2_avg_imgs : convolution_imags_type;
	SIGNAL conv2_END_conv,conv2_start_signal : STD_LOGIC;
	-------------------------------------------------------


	---------------------pooling signals-------------------                     
	SIGNAL pool0_OutFeatureMaps : convolution_imags_type;	
	SIGNAL pool0_done : STD_LOGIC := '0';
	SIGNAL pool0_start: STD_LOGIC;
	-------------------------------------------------------                     
	SIGNAL pool1_OutFeatureMaps : convolution_imags_type;	
	SIGNAL pool1_done : STD_LOGIC := '0';
	SIGNAL pool1_start: STD_LOGIC;
	-------------------------------------------------------


	---------------------read image signals---------------- 
	SIGNAL img_enable : STD_LOGIC;
    SIGNAL img_init_address : INTEGER;
    SIGNAL img_data_in : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL img_done : STD_LOGIC;
    SIGNAL img_read_address : INTEGER;
    SIGNAL img_dataout : img_array;
	-------------------read filter signals-----------------
	SIGNAL fil_enable : STD_LOGIC;
    SIGNAL fil_init_address : INTEGER;
    SIGNAL fil_data_in : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL fil_done : STD_LOGIC;
    SIGNAL fil_read_address : INTEGER;
    SIGNAL fil_dataout : filter_array;
	-------------------------------------------------------
	
	
	----------------------temp signals---------------------
	SIGNAL step_counter : INTEGER;

	
	BEGIN
	R0:cnn_read_ram_img GENERIC MAP (32*32) PORT MAP(
		clk,
		img_enable,
		img_init_address,
		img_data_in,
		img_done,
		img_read_address,
		img_dataout
	);

	R1:cnn_read_ram_fil GENERIC MAP (5*5) PORT MAP(
		clk,
		fil_enable,
		fil_init_address,
		fil_data_in,
		fil_done,
		fil_read_address,
		fil_dataout
	);
	
	CONV0:convolute_images GENERIC MAP (5,32,1,6) PORT MAP(
		img_dataout_temp,
		fil_dataout_temp,
		conv0_avg_imgs,
		conv0_END_conv,
		clk,
		conv0_start_signal
		);
	
	P0:Pooling_layer GENERIC MAP (2,6,28)PORT MAP(
		conv0_avg_imgs,
		pool0_OutFeatureMaps,
		pool0_done,
		clk,
		pool0_start
		);
		
	CONV1:convolute_images GENERIC MAP (5,14,6,16) PORT MAP(
		pool0_OutFeatureMaps,
		fil_dataout_temp,
		conv1_avg_imgs,
		conv1_END_conv,
		clk,
		conv1_start_signal
		);
	
	P1:Pooling_layer GENERIC MAP (2,16,10)PORT MAP(
		conv1_avg_imgs,
		pool1_OutFeatureMaps,
		pool1_done,
		clk,
		pool1_start
		);
	
	CONV2:convolute_images GENERIC MAP (5,5,16,210) PORT MAP(
		pool1_OutFeatureMaps,
		fil_dataout_temp,
		conv2_avg_imgs,
		conv2_END_conv,
		clk,
		conv2_start_signal
		);




	PROCESS(clk,START,rst) IS
		VARIABLE i:INTEGER := 0;
	BEGIN
		IF(rst ='1') THEN
			conv0_END_conv <= '0';
			conv0_start_signal <= '0';
			conv1_END_conv <= '0';
			conv1_start_signal <= '0';
			conv2_END_conv <= '0';
			conv2_start_signal <= '0';
			pool0_done <= '0';
			pool0_start <= '0';
			pool1_done <= '0';
			pool1_start <= '0';
			img_enable <= '0';
			img_done <= '0';
			fil_enable <= '0';
			fil_done <= '0';
			step_counter <= 0;
		END IF;

		img_dataout_temp(0) <= img_dataout;
		fil_dataout_temp(0) <= fil_dataout;

		IF(rising_edge(clk)) THEN
			IF(START = '1' AND step_counter = 0) THEN
				img_enable <= '1';
				RW <= "01";
				img_init_address <= 100;    --- we need to correct it with correct address of image
				step_counter <= 1; 
			END IF;
		
			IF(img_done = '1' AND step_counter = 1) THEN
				img_enable <= '0';
				img_done <= '0';
				RW <= "01";
				fil_enable <= '1';
				fil_init_address <= 200;  --- we need to correct it with correct address of filter
				step_counter <= 2;
			END IF;
			
			IF(fil_done = '1' AND step_counter = 2) THEN
				fil_done <= '0';
				RW <= "00";
				fil_enable <= '0';
				conv0_start_signal <= '1';
				step_counter <= 3;
			END IF;

			IF (conv0_end_conv = '1' AND step_counter = 3) THEN
				conv0_end_conv <= '0';
				conv0_start_signal <= '0';
				---don't forget to write in ram
				pool0_start <= '1';
				step_counter <= 4;
			END IF;

			IF (pool0_done = '1' AND step_counter = 4) THEN
				pool0_done <= '0';
				pool0_start <= '0';
				fil_enable <= '1';
				---don't forget to write in ram
				RW <= "01";
				fil_init_address <= 300;  --- we need to correct it with correct address of filter
				step_counter <= 5;
			END IF;

			IF (fil_done = '1' And step_counter = 5) THEN
				fil_done <= '0';
				fil_enable <= '0';
				--read ram
				conv1_start_signal <= '1';
				step_counter <= 6;
			END IF;

			IF (conv1_end_conv = '1' AND step_counter = 6) THEN
				conv1_end_conv <= '0';
				conv1_start_signal <= '0';
				-- write Ram
				--read ram
				pool1_start <= '1';
				step_counter <= 7;
			END IF;

			IF (pool1_done = '1' AND step_counter = 7) THEN
				pool1_done <= '0';
				pool1_start <= '0';
				fil_enable <= '1';
				--write ram
				RW <= "01";
				fil_init_address <= 400;  --- we need to correct it with correct address of filter
				step_counter <= 8;
			END IF;

			IF (fil_done = '1' AND step_counter = 8) THEN
				fil_done <= '0';
				fil_enable <= '0';
				--read ram
				conv2_start_signal <= '1';
				step_counter <= 9;
			END IF;

			IF (conv2_end_conv = '1' AND step_counter = 9) THEN
			    conv2_end_conv <= '0';
				conv2_start_signal <= '0';
				--write ram
				Done <= '1';
				step_counter <= 10;
			END IF;
		END IF;
	END PROCESS;
			
		------- donot foget to separate end conv and start pooling and viceversa between layers.

END arch_cnn_integration;
