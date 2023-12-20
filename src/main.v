module main (
    input CLK, 
    input RST,
    input BUTTON1, BUTTON2, BUTTON3, BUTTON4,
    input [6:0] SWITCH,    
    output reg[6:0] TRANS, 
    output reg[6:0] LED7SEG,
    output reg[1:0] LED_MODE,
    output reg[6:0] SINGLE_LED_SP
);
    
    reg MODE;
    wire[6:0] cTRANS;
    wire[6:0] cLED7SEG;
    wire button1_flag;

    reg state_single_led_mode;
    reg[27:0] counter;
     
    always @(posedge CLK) begin
        if (button1_flag == 1'b1) begin
            MODE = ~MODE;
        end 
        TRANS = cTRANS;
        LED7SEG = cLED7SEG;
    end

    always @(posedge CLK) begin
        if (counter >= 28'd12500000) begin
            counter <= 28'd0;
            state_single_led_mode <= ~state_single_led_mode;
        end
        else begin
            counter <= counter + 28'd1;
        end

        if (MODE == 1'b0) begin
            case (state_single_led_mode)
                1'b0: LED_MODE = 2'b10;
                1'b1: LED_MODE = 2'b11;
            endcase
        end else begin
            case (state_single_led_mode)
                1'b0: LED_MODE = 2'b01;
                1'b1: LED_MODE = 2'b11;
            endcase
        end
    end
    
    controller CRL (.clk(CLK),
                  .rst(RST),
                  .button2(BUTTON2),
                  .button3(BUTTON3),
                  .button4(BUTTON4),
                  .switch(SWITCH),
                  .mode(MODE),
                  .trans(cTRANS),
                  .led7seg(cLED7SEG),
                  .single_led_sp(SINGLE_LED_SP));


    button CHANGE_MODE (.clk(CLK), .rst(RST), .btn(BUTTON1), .debounced(button1_flag));
     

endmodule