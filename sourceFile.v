`timescale 1ns / 1ps


module sevenSegDisp(
   input clk,
   input clr,
   input start,
   input stop,
   input wire A,B,C,E,F,H,I,J,K,L,O,P,S,U,
   output reg crt,wng,
   output reg [6:0] a_to_g,
   output reg [3:0] an,
   output wire dp 
    );
    
    reg [25:0] clkdiv = 26'b0;
        wire [3:0] s;
        wire [1:0] c;
        reg [3:0] state;
        wire [3:0] aen;
        reg [1:0] mode = 2;
        reg [3:0] rand_num;
        reg [3:0] rand_seed = 4'b0001;

        
        assign dp = 1;
      //  assign s = clkdiv[29:26];
        assign s = rand_num[3:0];
        assign c = clkdiv[25:24];
        assign aen = 4'b1111;
        
              
        
        always@(posedge clk) begin
            if(clr==1)
                mode <= 2;
            else if(start==1) begin
                mode <= 1;
                end
            else if(stop==1) begin
                mode <= 0;
                end
        end
       
        always @(*)
        begin
        if(mode == 1)
        case(s)
            0:state = 0;
            1:state = 1;
            2:state = 2;
            3:state = 3;
            4:state = 4;
            5:state = 5;
            6:state = 6;
            7:state = 7;
            8:state = 8;
            9:state = 9;
            10:state = 10;
            11:state = 11;
            12:state = 12;
            13:state = 13;
            14:state = 14;
    //        15:state = 15;
    
            endcase
       else if(mode == 2)
            state=15;  
    
        end
        
            
     
            
           
        
        
        always @(*)
        begin
             case(state)
                    //////////<---MSB-LSB<---
                    //////////////gfedcba////////////////////////////////////////////           
                    //0:a_to_g = 7'b1000000;                                                                 
                    0:a_to_g = 7'b0001000;         //A                                      
                    1:a_to_g = 7'b0000000;         //B                                                                                                         
                    2:a_to_g = 7'b1000110;         //C                                     
                    3:a_to_g = 7'b0000110;         //E   
                    4:a_to_g = 7'b0001110;         //F                                      
                    5:a_to_g = 7'b0001001;         //H                                                                                                         
                    6:a_to_g = 7'b1111001;         //I                                     
                    7:a_to_g = 7'b1100001;         //J      
                    8:a_to_g = 7'b1000111;         //L                                      
                    9:a_to_g = 7'b1000000;        //O                                                                                                         
                    10:a_to_g = 7'b0001100;        //P                                     
                    11:a_to_g = 7'b0010010;        //S   
                    12:a_to_g = 7'b1000001;         //U      
                    13:a_to_g = 7'b0100111;        //c                                     
                    14:a_to_g = 7'b0001011;        //h                                            
                    15:a_to_g = 7'b0111111;
                    default: a_to_g = 7'b0111111; // U
        
                    endcase
            end
                  
                    
        
        
        always @(*)begin
        if(mode == 2)
            an=4'b0000;
        else if(mode ==1)
        case(c)
            0:an=4'b1110;
            1:an=4'b1101;
            2:an=4'b1011;
            3:an=4'b0111;
            default:an=4'b1111;
        endcase
        end
        
        always @(posedge clk ) begin
        if ( clr == 1)
        clkdiv <= 0;
        else if(start==1)
        begin
            clkdiv=0;     
        end    
        else if(stop==1)
        clkdiv<=0;
        else begin
            clkdiv <= clkdiv+1;
            if(clkdiv==0)begin
             rand_num <= rand_num+rand_seed;
             rand_seed <= rand_seed+1;
             rand_seed
            end
          end
        end
        
  /*
        always@(posedge clk)
        begin
           if(start==1)
           begin
            rand_num[0] = rand_num[1]^rand_num[3];
            rand_num[1] = rand_num[0]^rand_num[2];
            rand_num[2] = rand_num[1]^rand_num[0];
            rand_num[3] = rand_num[2]^rand_num[3];
           end
           else
           begin
           rand_num = 4'b1011;
           end
        end
        
        */
        always@(posedge clk)
        begin
            if(mode==1)
              begin
                if(state == 0 && A ==1)
                    crt = 1;
                else if(state == 1 && B ==1)
                    begin
                     crt =1;
                     wng=0;
                    end
                 else if (state == 2 && C ==1)
                     begin
                                      crt =1;
                                      wng=0;
                                     end
                else if(state == 3 && E ==1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else if (state == 4 && F ==1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else if(state == 5 && H ==1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else if (state == 6 && I ==1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else if(state == 7 && L ==1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else if (state == 8 && O ==1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else if(state == 9 && H ==1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else if (state == 10 && I ==1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else if(state == 11 && L ==1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else if (state == 12 && O == 1)
                     begin
                                     crt =1;
                                     wng=0;
                                    end
                else
                 begin
                    wng =1;
                    crt=0;
                  end
              end
        end
    
    
endmodule


