`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2018 23:48:59
// Design Name: 
// Module Name: scores_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module scores_display(
input [7:0] sw,
input clk,
output [6:0]a_to_g,
output [3:0] an,
output wire dp
);

integer i;
 reg [3:0] Hundreds;
 reg [3:0] Tens;
 reg [3:0] Ones;
always @ (sw)
begin
    Hundreds = 4'd0;
    Tens = 4'd0;
    Ones = 4'd0;
    for(i=7;i>=0;i = i-1) begin
        if(Hundreds >= 5)
                Hundreds = Hundreds + 3;
        if(Tens >= 5)
                Tens = Tens + 3;
        if(Ones >= 5)
                Ones = Ones + 3;

        Hundreds = Hundreds<<1;
        Hundreds[0] = Tens[3];
        Tens = Tens << 1;
        Tens[0] = Ones[3];
        Ones = Ones<<1;
        Ones[0] = sw[i];


    end
end

wire [15:0] out;
assign out[3:0] = Ones;
assign out[7:4] = Tens;
assign out[11:8] = Hundreds;
assign out[15:12] =4'b0000;



seven_seg(out , clk, a_to_g , an , dp);
endmodule
