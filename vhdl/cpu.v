module cpu(input clk ,input rst,input interrupt,input load_process,input cnn_image,output done,input send);

integer  data_file ;
integer  scan_file ; 
reg [479:0]row ;
reg ready;

reg [259:0]test_row;


`define NULL 0    

initial begin
  data_file = $fopen("out.txt", "r");
  if (data_file == `NULL) begin
    $display("data_file handle was NULL");
    $finish;
  end
end

always @(load_process,posedge send) begin
  ready=0;
  scan_file = $fscanf(data_file, "%b\n", row);
  ready = 1;
  
end


sendRow sr(
   row,
   clk,
   ready,
   send
);

endmodule 
