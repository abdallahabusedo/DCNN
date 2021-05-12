module cpu(input clk ,input rst,input interrupt,input load_process,input cnn_image,output done);

integer  data_file ;
integer  scan_file ; 
reg [15:0] rowSizes [27:0] ;
reg [15:0] splitSizes [27:0] ;
reg [447:0]rows [27:0] ;
reg [27:0] signals;
reg [27:0] outsignals;
integer i;

`define NULL 0    

initial begin
  i=0;
  data_file = $fopen("out.txt", "r");
  if (data_file == `NULL) begin
    $display("data_file handle was NULL");
    $finish;
  end
end

always @(posedge load_process) begin
  scan_file = $fscanf(data_file, "%b\n", rowSizes[i]);
  scan_file = $fscanf(data_file, "%b\n", splitSizes[i]);
  scan_file = $fscanf(data_file, "%b\n", rows[i]);
  signals[i]=1;
  i=i+1;
end

genvar k;
for (k =0;k<28;k=k+1) begin

sendRow sr(
   rows[k],
   splitSizes[k],
   rowSizes[k]
  );
end
endmodule 
