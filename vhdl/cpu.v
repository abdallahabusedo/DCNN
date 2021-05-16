module cpu(input clk ,input rst,input interrupt,input load_process,input cnn_image,output done,input send,input stop);

integer  data_file ;
integer  scan_file ; 
reg [479:0]row ;
reg ready;

`define NULL 0    

initial begin

  data_file = $fopen("out.txt", "r");
  if (data_file == `NULL) begin
    $display("data_file handle was NULL");
    $finish;
  end
end

always @(load_process,posedge send) begin
if(stop==0) begin
  ready=0;
  scan_file = $fscanf(data_file, "%b\n", row);
  ready = 1;
 end
end


sendRow sr(
   row,
   clk,
   ready,
   send,
   stop
);

endmodule 