module LED_Blink
    #(parameter g_COUNT_10HZ = 1250000,
      parameter g_COUNT_5HZ = 2500000,
      parameter g_COUNT_2HZ = 6250000,
      parameter g_COUNT_1HZ = 12500000)
    (input i_Clk,
     output reg o_LED_1 = 1'b0,
     output reg o_LED_2 = 1'b0,
     output reg o_LED_3 = 1'b0,
     output reg o_LED_4 = 1'b0);

    // Counters for LEDs
    reg [31:0] r_Count_10HZ = 0;
    reg [31:0] r_Count_5HZ = 0;
    reg [31:0] r_Count_2HZ = 0;
    reg [31:0] r_Count_1HZ = 0;

    // Toggle each one at a different frequency

    always @(posedge i_Clk)
    begin
        if (r_Count_10HZ == g_COUNT_10HZ)
        begin
            o_LED_1      <= ~o_LED_1;
            r_Count_10HZ <= 0;
        end
        else
            r_Count_10HZ <= r_Count_10HZ + 1;
    end
    always @(posedge i_Clk)
    begin
        if (r_Count_5HZ == g_COUNT_5HZ)
        begin
            o_LED_2      <= ~o_LED_2;
            r_Count_5HZ <= 0;
        end
        else
            r_Count_5HZ <= r_Count_5HZ + 1;
    end
    always @(posedge i_Clk)
    begin
        if (r_Count_2HZ == g_COUNT_2HZ)
        begin
            o_LED_3      <= ~o_LED_3;
            r_Count_2HZ <= 0;
        end
        else
            r_Count_2HZ <= r_Count_2HZ + 1;
    end
    always @(posedge i_Clk)
    begin
        if (r_Count_1HZ == g_COUNT_1HZ)
        begin
            o_LED_4      <= ~o_LED_4;
            r_Count_1HZ <= 0;
        end
        else
            r_Count_1HZ <= r_Count_1HZ + 1;
    end
endmodule
