`timescale 1ns / 1ns

module tb;
parameter SIZE = 14, DEPTH = 1024;

reg clk;
initial begin
  clk = 1;
  forever
	  #5 clk = ~clk;
end

reg rst;
initial begin
  rst = 1;
  repeat (10) @(posedge clk);
  rst <= #1 0;
  repeat (600) @(posedge clk);
  // uncomment the following line to display the content at address 50 in console
  // $display("Content of address 50 is %d.", inst_blram.memory[50]);
  $finish;
end

wire wrEn;
wire [SIZE-1:0] addr_toRAM;
wire [31:0] data_toRAM, data_fromRAM;

VerySimpleCPU inst_VerySimpleCPU(
  .clk(clk),
  .rst(rst),
  .wrEn(wrEn),
  .data_fromRAM(data_fromRAM),
  .addr_toRAM(addr_toRAM),
  .data_toRAM(data_toRAM)
);

blram #(SIZE, DEPTH) inst_blram(
  .clk(clk),
  .rst(rst),
  .i_we(wrEn),
  .i_addr(addr_toRAM),
  .i_ram_data_in(data_toRAM),
  .o_ram_data_out(data_fromRAM)
);

endmodule

module blram(clk, rst, i_we, i_addr, i_ram_data_in, o_ram_data_out);

parameter SIZE = 10, DEPTH = 1024;

input clk;
input rst;
input i_we;
input [SIZE-1:0] i_addr;
input [31:0] i_ram_data_in;
output reg [31:0] o_ram_data_out;

reg [31:0] memory[0:DEPTH-1];

always @(posedge clk) begin
  o_ram_data_out <= #1 memory[i_addr[SIZE-1:0]];
  if (i_we)
		memory[i_addr[SIZE-1:0]] <= #1 i_ram_data_in;
end 

initial begin
//////////////////////////
// write BRAM content here
memory[0] = 32'h908c01f4;
memory[1] = 32'h908c41f5;
memory[2] = 32'ha0898230;
memory[3] = 32'ha089c231;
memory[4] = 32'h808a0226;
memory[5] = 32'h60898227;
memory[6] = 32'hd0898009;
memory[7] = 32'h80870227;
memory[8] = 32'hd091000a;
memory[9] = 32'h80870228;
memory[10] = 32'h8087421c;
memory[11] = 32'h60874258;
memory[12] = 32'hc084c21d;
memory[13] = 32'hd091000f;
memory[14] = 32'h8096021c;
memory[15] = 32'h108c0001;
memory[16] = 32'h108c4001;
memory[17] = 32'h80914230;
memory[18] = 32'h709141fe;
memory[19] = 32'hc0848245;
memory[20] = 32'hd0910002;
memory[21] = 32'hd0058015;
memory[22] = 32'h0;
memory[500] = 32'ha;
memory[501] = 32'h5;
memory[502] = 32'h3;
memory[503] = 32'h7;
memory[504] = 32'h2a;
memory[505] = 32'hc;
memory[506] = 32'h16;
memory[507] = 32'h20;
memory[508] = 32'h8;
memory[509] = 32'hf;
memory[530] = 32'h15;
memory[531] = 32'he;
memory[540] = 32'h1;
memory[541] = 32'h1;
memory[550] = 32'h1;
memory[551] = 32'h1;
memory[560] = 32'h1;
memory[561] = 32'h1;
memory[580] = 32'h0;
memory[581] = 32'h0;
memory[600] = 32'h0;

//////////////////////////
end

endmodule