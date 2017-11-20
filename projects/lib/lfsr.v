module lfsr_4bit
    #(parameter BITS = 4)
    (input i_Clk,
     input i_Switch,
     output reg [3:0] number);

    reg [3:0] next_num;
    always @* begin 
        next_num[3] = number[3]^number[1];
        next_num[2] = number[2]^number[0];
        next_num[1] = number[3]^next_num[3];
        next_num[0] = number[3]^next_num[2];
    end
    
    always @(posedge i_Clk)
    begin
        if(!i_Switch)
            number <= 4'b0000;
        else
            number <= next_num;
    end
endmodule
