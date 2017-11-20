module Dice_Top
    (input i_Clk,
     input i_Switch_1,
     input i_Switch_2,
     input i_Switch_3,
     input i_Switch_4,
     output o_Segment2_A,
     output o_Segment2_B,
     output o_Segment2_C,
     output o_Segment2_D,
     output o_Segment2_E,
     output o_Segment2_F,
     output o_Segment2_G,
     output o_Segment1_A,
     output o_Segment1_B, 
     output o_Segment1_C, 
     output o_Segment1_D, 
     output o_Segment1_E, 
     output o_Segment1_F, 
     output o_Segment1_G);

    wire w_Switch_1;  
    wire w_Switch_2;  
    wire w_Switch_3;  
    wire w_Switch_4;  
    
    reg r_switch_1 = 1'b0;
    reg r_switch_2 = 1'b0;
    reg r_switch_3 = 1'b0;
    reg r_switch_4 = 1'b0;

    reg [4:0] r_Count_1 = 5'b00000;
    reg [3:0] r_Count_2 = 4'b0000; 

    wire w_Segment2_A;
    wire w_Segment2_B;
    wire w_Segment2_C;
    wire w_Segment2_D;
    wire w_Segment2_E;
    wire w_Segment2_F;
    wire w_Segment2_G;


    //Debounce each button, four instantiations
    Debounce_Switch switch1_inst
        (.i_Clk(i_Clk),
         .i_Switch(i_Switch_1),
         .o_Switch(w_Switch_1));
    Debounce_Switch switch2_inst
        (.i_Clk(i_Clk),
         .i_Switch(i_Switch_2),
         .o_Switch(w_Switch_2));
    Debounce_Switch switch3_inst
        (.i_Clk(i_Clk),
         .i_Switch(i_Switch_3),
         .o_Switch(w_Switch_3));
    Debounce_Switch switch4_inst
        (.i_Clk(i_Clk),
         .i_Switch(i_Switch_4),
         .o_Switch(w_Switch_4));
    
    lfsr_4bit d8_inst
        (.i_Clk(i_Clk),
         .i_Switch(w_Switch_1),
         .number(r_Count_2));

    Binary_to_7Segment seven_Inst
        (.i_Clk(i_Clk),
         .i_Binary_Num(r_Count_2),
         .o_Segment_A(w_Segment2_A),
         .o_Segment_B(w_Segment2_B),
         .o_Segment_C(w_Segment2_C),
         .o_Segment_D(w_Segment2_D),
         .o_Segment_E(w_Segment2_E),
         .o_Segment_F(w_Segment2_F),
         .o_Segment_G(w_Segment2_G)
        );

    assign o_Segment2_A = ~w_Segment2_A;
    assign o_Segment2_B = ~w_Segment2_B;
    assign o_Segment2_C = ~w_Segment2_C;
    assign o_Segment2_D = ~w_Segment2_D;
    assign o_Segment2_E = ~w_Segment2_E;
    assign o_Segment2_F = ~w_Segment2_F;
    assign o_Segment2_G = ~w_Segment2_G;

endmodule
                      
    
