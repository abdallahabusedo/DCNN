module cpu(input clk ,input rst,input interrupt,input load_process,input cnn_image,output done,input send,input stop);

integer  image_file ;
integer  data_file ;
integer  scan_file ; 
integer scan_file_data;
reg [479:0]row ;
reg [15:0] cnnData;

`define NULL 0    

initial begin

  data_file = $fopen("data.txt", "r");
  image_file = $fopen("out.txt", "r");
  if (data_file == `NULL || image_file == `NULL) begin
    $display("data_file handle was NULL");
    $finish;
  end
end

always @(posedge load_process,posedge send) begin
if(stop==0 && cnn_image==0) begin
  scan_file = $fscanf(image_file, "%b\n", row);
 end
end

always @(posedge clk) begin
if(cnn_image==1) begin
  scan_file_data = $fscanf(data_file, "%b\n", cnnData);
end
end

sendRow sr(
   row,
cnnData,
cnn_image,
   clk,
   load_process,
   send,
   stop
);

endmodule 
