`timescale 1ns / 1ps

module seg7decimal(

	input y,
    input clk,
    //input clr,
    output reg [6:0] a_to_g,
    output reg [3:0] an,
    output wire dp
    //output reg [15:0] led 
	 );
	 
	 
wire [1:0] s;	 
reg [3:0] digit;
wire [3:0] aen;
reg [19:0] clkdiv;
reg [15:0]x;
//reg [15:0]led;

assign dp = 1;
assign s = clkdiv[19:18];
assign aen = 4'b1111; // all turned off initially


always @(*) begin
    if(y==0) begin
        x[3:0]=4'b0000;
        x[7:4]=4'b0001;
        x[11:8]=4'b0010;
        x[15:12]=4'b0011;
    end
    else
    begin
        x[3:0]=4'b0110;
        x[7:4]=4'b0101;
        x[11:8]=4'b0000;
        x[15:12]=4'b0100;
    end
end

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
0:a_to_g = 7'b0000110;////E												       __					
1:a_to_g = 7'b0010010;////S												f/	  /b
2:a_to_g = 7'b1000000;////O												  g
//                                                                           __	
3:a_to_g = 7'b1000111;////L										 	 e /   /c
4:a_to_g = 7'b0011001;////Y												 __
5:a_to_g = 7'b0001000;////A                                               d  
6:a_to_g = 7'b0001001;////H
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
