module Clocked_Logic
    (input i_Clk,
     input i_Switch_1,
     output o_LED_1);

    reg r_LED_1 = 1'b0;
    reg r_Switch_1 = 1'b0;

    // Toggle LED when i_Switch_1 released
    always @(posedge i_Clk)
    begin
        r_Switch_1 <= i_Switch_1; //Creates the register
        
        if (i_Switch_1 == 1'b0 && r_Switch_1 == 1'b1)
        begin
            r_LED_1 <= ~r_LED_1; //Toggles LED output if register
        end                      //sees the switch change above
    end
    
    assign o_LED_1 = ~r_LED_1;

endmodule


