module tb(input interrupt,output done,input send,input stop);

integer  image_file ;
integer  data_file ;
integer  scan_file ; 
integer scan_file_data;
reg [479:0]row ;
reg [15:0] cnnData;

wire [15:0] data;
wire startDecompression;

wire [15:0] rowSize;
wire [15:0] extraBits;
wire [15:0] initialRowSize;
wire [15:0] splitSize ;
wire [3:0] result ;
integer counter =0;

reg load_process;
reg cnn_image;
reg clk;
reg rst;

// reg reg_stop;


initial begin
  rst = 1;
  #50
  rst = 0;
  load_process = 1;
  cnn_image = 0;
  data_file = $fopen("data.txt", "r");
  image_file = $fopen("out.txt", "r");
  if (data_file == 0 || image_file == 0) begin
    $display("data_file handle was NULL");
    $finish;
  end
end

always begin
    clk = 1'b0;
    #50; // low for 20 * timescale = 20 ns

    clk = 1'b1; 
    #50; // high for 20 * timescale = 20 ns
end


always @(posedge load_process,posedge send) begin
// reg_stop = stop;
if(stop==0 && cnn_image==0 && rst == 0) begin
  counter = counter + 1;
  if(counter == 30) begin
    cnn_image = 1;
  end 
  scan_file = $fscanf(image_file, "%b\n", row);
 end
end

always @(posedge clk) begin
if(cnn_image==1 && rst == 0) begin
  scan_file_data = $fscanf(data_file, "%b\n", cnnData);
  if(scan_file_data == -1) begin
    load_process = 0 ;
  end

end
end

cpu tb_cpu(
   row,
   cnnData,
   cnn_image,
   clk,
   rst,
   load_process,
   send,
   stop,
   data,
   startDecompression,
   rowSize,
   extraBits,
   initialRowSize,
   splitSize

);

chip tb_chip(
  	load_process,
  	cnn_image,
  	clk,
  	rst,
    send,
    stop,           //io  
    result,
    data,           //cpu
    startDecompression, //--cpu
    rowSize,            // to cpu
    extraBits,          //  --cpu
    initialRowSize,     // --cpu
    splitSize           //--cpu
);

endmodule 
