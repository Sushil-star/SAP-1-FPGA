`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2023 10:29:33
// Design Name: 
// Module Name: flof
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


module flof(
    input clk,
    input rst,
    input [7:0] din,
    input wr_en,
    input rd_en,
    output [7:0] dout,
    output empty,
    output full
    );
    reg [3:0] rd_ptr;
    reg [3:0] wr_ptr;
    reg [7:0] mem[0:15];
    reg [7:0] dataout;
    assign full = (wr_ptr == 4'hf);
    assign empty = (rd_ptr == 4'h0);
    always @(posedge clk or posedge rst)
     begin
       if (rst)
         begin
          rd_ptr <= 4'h0;
          wr_ptr <= 4'h0;
         end
       else 
        begin 
         if(wr_en && !full)
          mem[wr_ptr] <= din;
         if(rd_en && !empty)
          dataout <= mem[rd_ptr];
         else
          begin
           if (!full && wr_en)
            wr_ptr <= wr_ptr + 1;
           else if (!empty && rd_en)
           rd_ptr <= rd_ptr + 1;
          end
        end
     end
    assign dout = dataout;    
endmodule
