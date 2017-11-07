// Debouncing module called in Top
module Debounce_Switch (input i_Clk, input i_Switch, output o_Switch);

    parameter c_DEBOUNCE_LIMIT = 250000; //10ms @ 25MHz

    reg [17:0] r_Count = 0;
    reg r_state = 1'b0;

    always @(posedge i_Clk)
    begin
        //Switch input changes, start counting till it is stable
        if (i_Switch !== r_State && r_Count < c_DEBOUNCE_LIMIT)
            r_Count <= r_Count + 1;

        // when counter ends, register i_Switch and reset counter
        else if (r_Count ==  c_DEBOUNCE_LIMIT)
        begin
            r_State <= i_Switch;
            r_Count = 0;
        end

        //Switches are the same, just reset counter
        else
            r_Count <= 0;
    end
    //Assign register to output
    assign o_Switch = r_State;
endmodule

