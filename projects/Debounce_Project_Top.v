module Debounce_Project_Top
    (input i_Clk,
     input i_Switch_1,
     output o_LED_1);

    reg r_LED_1 = 1'b0;
    reg r_Switch_1 = 1'b0;
    wire w_Switch_1;

    // Instantiate debounce module
    Debounce_Switch Debounce_Inst
    (.i_Clk(i_Clk),
     .i_Switch(i_Switch_1),
     .o_Switch(w_Switch_1));

    // Toggle LED when w_Switch_1 toggles
    always @(posedge i_Clk)
    begin
        r_Switch_1 <= w_Switch_1;   //creates register from output of debounce

        // Looks for the falling edge on w_Switch
        if (w_Switch_1 == 1'b0 && r_Switch_1 == 1'b1)
        begin
            r_LED_1 <= ~r_LED_1;    // swaps LED register
        end
    end

    assign o_LED_1 = r_LED_1;   // led output to led register

endmodule
