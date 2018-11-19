`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IITRPR
// Engineer: Kamal Sharma
// 
// Create Date:    16:52:53 06/12/2014 
// Design Name: 
// Module Name:    seg7decimal 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seg7decimal(

	input [15:0]x,
    input clk,
    //input clr,
    output reg [6:0] a_to_g,
    output reg [3:0] an,
    output wire dp 
	 );
	 
	 
wire [1:0] s;	 
reg [3:0] digit;
wire [3:0] aen;
reg [19:0] clkdiv;

assign dp = 1;
assign s = clkdiv[19:18];
assign aen = 4'b1111; // all turned off initially

// quad 4to1 MUX.


always @(posedge clk)/* or posedge clr)*/
	
	case(s)
	0:digit = x[3:0]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
	1:digit = x[7:4]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
	2:digit = x[11:8]; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
	3:digit = x[15:12]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]
	
	default:digit = x[3:0];
	
	endcase
	
	//decoder or truth-table for 7a_to_g display values
	always @(*)

case(digit)


//////////<---MSB-LSB<---
//////////////gfedcba////////////////////////////////////////////                   a
0:a_to_g = 7'b0000110;////0000												       __					
1:a_to_g = 7'b0010010;////0001												f/	  /b
2:a_to_g = 7'b1000000;////0010												  g
//                                                                           __	
3:a_to_g = 7'b1000111;////0011										 	 e /   /c
//4:a_to_g = 7'b0011001;////0100												 __
//5:a_to_g = 7'b0010010;////0101                                               d  
//6:a_to_g = 7'b0000010;////0110
//7:a_to_g = 7'b1111000;////0111
//8:a_to_g = 7'b0000000;////1000
//9:a_to_g = 7'b0010000;////1001
//'hA:a_to_g = 7'b0111111; // dash-(g)
//'hB:a_to_g = 7'b1111111; // all turned off
//'hC:a_to_g = 7'b1110111;

default: a_to_g = 7'b0000000; // U

endcase


always @(*)begin
an=4'b1111;
if(aen[s] == 1)
an[s] = 0;
end


//clkdiv

always @(posedge clk /*or posedge clr*/) begin
/*if ( clr == 1)
clkdiv <= 0;
else*/
clkdiv <= clkdiv+1;
end


endmodule
