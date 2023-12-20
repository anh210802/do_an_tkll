module controller (
    input clk,
    input rst,
    input button2, button3, button4,
    input [6:0] switch,
    input wire mode,
    output reg[6:0] trans,
    output reg[6:0] led7seg,
    output reg[6:0] single_led_sp
);


    wire eff_btn_flag;
    wire fre_btn_flag;
    wire stop_btn_flag;
    wire[6:0] switch_flag;
    

    reg[3:0] effect;
    reg[6:0] led7seg_0, led7seg_1, led7seg_2, led7seg_3, led7seg_4, led7seg_5, led7seg_6;
    reg[6:0] trans_0, trans_1, trans_2, trans_3, trans_4, trans_5, trans_6;
    reg[2:0] ENABLE;
    reg[34:0] timer0_counter, timer1_counter, timer2_counter, timer3_counter, timer4_counter, timer5_counter, timer6_counter;
    reg[34:0] counter;
    reg[1:0] frequency;
    reg[6:0] char0, char1, char2, char3, char4, char5, char6;

    reg[6:0] trans_mode2;
    reg[6:0] led7seg_mode2;
    reg[6:0] single_led_sp_mode2;

    reg stop_flag;

    always @(posedge clk) begin
        if (mode == 1'b0) begin
            if (fre_btn_flag == 1) begin 
                if (frequency == 2'b11) begin
                    frequency <= 2'b00;
                end else begin
                    frequency <= frequency + 2'b01;
                end
            end
        end else begin
            frequency <= 2'b00;
        end
    end
    always @(posedge clk) begin
        if (switch_flag[0] == 1) begin
            case (frequency)
                2'b00: timer0_counter = 35'd2400000000;
                2'b01: timer0_counter = 35'd1200000000;
                2'b10: timer0_counter = 35'd600000000;
                2'b11: timer0_counter = 35'd300000000;
            endcase
        end else begin
            timer0_counter = 35'd0;
        end

        if (switch_flag[1] == 1) begin
            case (frequency)
                2'b00: timer1_counter = 35'd700000000;
                2'b01: timer1_counter = 35'd350000000;
                2'b10: timer1_counter = 35'd175000000;
                2'b11: timer1_counter = 35'd87500000;
            endcase
        end else begin
            timer1_counter = 35'd0;
        end

        if (switch_flag[2] == 1) begin
            case (frequency)
                2'b00: timer2_counter = 35'd700000000;
                2'b01: timer2_counter = 35'd350000000;
                2'b10: timer2_counter = 35'd175000000;
                2'b11: timer2_counter = 35'd87500000;
            endcase
        end else begin
            timer2_counter = 35'd0;
        end

        if (switch_flag[3] == 1) begin
            case (frequency)
                2'b00: timer3_counter = 35'd1100000000;
                2'b01: timer3_counter = 35'd550000000;
                2'b10: timer3_counter = 35'd275000000;
                2'b11: timer3_counter = 35'd137500000;
            endcase
        end else begin
            timer3_counter = 35'd0;
        end

        if (switch_flag[4] == 1) begin
            case (frequency)
                2'b00: timer4_counter = 35'd1600000000;
                2'b01: timer4_counter = 35'd800000000;
                2'b10: timer4_counter = 35'd400000000;
                2'b11: timer4_counter = 35'd200000000;
            endcase
        end else begin
            timer4_counter = 35'd0;
        end

        if (switch_flag[5] == 1) begin
            case (frequency)
                2'b00: timer5_counter = 35'd3300000000;
                2'b01: timer5_counter = 35'd1650000000;
                2'b10: timer5_counter = 35'd825000000;
                2'b11: timer5_counter = 35'd412500000;
            endcase
        end else begin
            timer5_counter = 35'd0;
        end

        if (switch_flag[6] == 1) begin
            case (frequency)
                2'b00: timer6_counter = 35'd3400000000;
                2'b01: timer6_counter = 35'd1700000000;
                2'b10: timer6_counter = 35'd850000000;
                2'b11: timer6_counter = 35'd425000000;
            endcase
        end else begin
            timer6_counter = 35'd0;
        end
    end
    
    always @(posedge clk) begin
        if (stop_btn_flag == 1'b1) begin
            stop_flag = ~stop_flag;
        end
    end

    always @(posedge clk) begin
        if (mode == 1'b0) begin
            if (effect == 4'd0) begin
                if (counter >= timer0_counter) begin
                    counter <= 35'd0;
                    effect = effect + 4'd1;
                end else begin
                    if (stop_flag == 1'b1) begin
                        counter <= 35'd0;
                    end else begin
                        counter <= counter + 35'd1;
                    end
                end
                if (eff_btn_flag == 1) begin
                    effect = effect + 4'd1;
                    counter <= 35'd0;
                end
            end else if (effect == 4'd1) begin
                if (counter >= timer1_counter) begin
                    counter <= 0;
                    effect = effect + 4'd1;
                end else begin
                    if (stop_flag == 1'b1) begin
                        counter <= 35'd0;
                    end else begin
                        counter <= counter + 35'd1;
                    end
                end
                if (eff_btn_flag == 1) begin
                    effect = effect + 4'd1;
                    counter <= 35'd0;
                end
            end else if (effect == 4'd2) begin
                if (counter >= timer2_counter) begin
                    counter <= 0;
                    effect = effect + 4'd1;
                end else begin
                    if (stop_flag == 1'b1) begin
                        counter <= 35'd0;
                    end else begin
                        counter <= counter + 35'd1;
                    end
                end
                if (eff_btn_flag == 1) begin
                    effect = effect + 4'd1;
                    counter <= 35'd0;
                end
            end else if (effect == 4'd3) begin
                if (counter >= timer3_counter) begin
                    counter <= 0;
                    effect = effect + 4'd1;
                end else begin
                    if (stop_flag == 1'b1) begin
                        counter <= 35'd0;
                    end else begin
                        counter <= counter + 35'd1;
                    end
                end
                if (eff_btn_flag == 1) begin
                    effect = effect + 4'd1;
                    counter <= 35'd0;
                end
            end else if (effect == 4'd4) begin
                if (counter >= timer4_counter) begin
                    counter <= 0;
                    effect = effect + 4'd1;
                end else begin
                    if (stop_flag == 1'b1) begin
                        counter <= 35'd0;
                    end else begin
                        counter <= counter + 35'd1;
                    end
                end
                if (eff_btn_flag == 1) begin
                    effect = effect + 4'd1;
                    counter <= 35'd0;
                end
            end else if (effect == 4'd5) begin
                if (counter >= timer5_counter) begin
                    counter <= 0;
                    effect = effect + 4'd1;
                end else begin
                    if (stop_flag == 1'b1) begin
                        counter <= 35'd0;
                    end else begin
                        counter <= counter + 35'd1;
                    end
                end
                if (eff_btn_flag == 1) begin
                    effect = effect + 4'd1;
                    counter <= 35'd0;
                end
            end else if (effect == 4'd6) begin
                if (counter >= timer6_counter) begin
                    counter <= 0;
                    effect = 4'd0;
                end else begin
                    if (stop_flag == 1'b1) begin
                        counter <= 35'd0;
                    end else begin
                        counter <= counter + 35'd1;
                    end
                end
                if (eff_btn_flag == 1) begin
                    effect = effect + 4'd1;
                    counter <= 35'd0;
                end
            end
        end else begin
            effect = 4'd0;
            counter <= 0;
        end
    end

    always @(posedge clk) begin
        if (mode == 1'b0) begin
            case (effect)
                4'd0: begin
                    single_led_sp = 7'b1111110;
                    trans = trans_0;
                    led7seg = led7seg_0;
                    ENABLE = 3'b000;
                end
                4'd1: begin
                    single_led_sp = 7'b1111101;
                    trans = trans_1;
                    led7seg = led7seg_1;
                    ENABLE = 3'b001;
                end
                4'd2: begin
                    single_led_sp = 7'b1111011;
                    trans = trans_2;
                    led7seg = led7seg_2;
                    ENABLE = 3'b010;
                end
                4'd3: begin
                    single_led_sp = 7'b1110111;
                    trans = trans_3;
                    led7seg = led7seg_3;
                    ENABLE = 3'b011;
                end
                4'd4: begin
                    single_led_sp = 7'b1101111;
                    trans = trans_4;
                    led7seg = led7seg_4;
                    ENABLE = 3'b100;
                end
                4'd5: begin
                    single_led_sp = 7'b1011111;
                    trans = trans_5;
                    led7seg = led7seg_5;
                    ENABLE = 3'b101;
                end
                4'd6: begin
                    single_led_sp = 7'b0111111;
                    trans = trans_6;
                    led7seg = led7seg_6;
                    ENABLE = 3'b110;
                end
            endcase
        end else begin
            single_led_sp = single_led_sp_mode2;
            trans <= trans_mode2;
            led7seg <= led7seg_mode2;
        end
    end
    /**************************************************************************/

    button EFFECT_NEXT (.clk(clk), .rst(rst), .btn(button2), .debounced(eff_btn_flag));
    button FREQUENCY_NEXT (.clk(clk), .rst(rst), .btn(button3), .debounced(fre_btn_flag));
    button STOP (.clk(clk), .rst(rst), .btn(button4), .debounced(stop_btn_flag));

    switch S0 (.clk(clk), .switch(switch[0]), .debounced(switch_flag[0]));
    switch S1 (.clk(clk), .switch(switch[1]), .debounced(switch_flag[1]));
    switch S2 (.clk(clk), .switch(switch[2]), .debounced(switch_flag[2]));
    switch S3 (.clk(clk), .switch(switch[3]), .debounced(switch_flag[3]));
    switch S4 (.clk(clk), .switch(switch[4]), .debounced(switch_flag[4]));
    switch S5 (.clk(clk), .switch(switch[5]), .debounced(switch_flag[5]));
    switch S6 (.clk(clk), .switch(switch[6]), .debounced(switch_flag[6]));

    effect0 E0 (.clk(clk), .trans(trans_0), .led7seg(led7seg_0), .enable(ENABLE), .frequency(frequency),
                .char0(char0), .char1(char1), .char2(char2), .char3(char3), .char4(char4), .char5(char5), .char6(char6));
    effect1 E1 (.clk(clk), .trans(trans_1), .led7seg(led7seg_1), .enable(ENABLE), .frequency(frequency),
                .char0(char0), .char1(char1), .char2(char2), .char3(char3), .char4(char4), .char5(char5), .char6(char6));
    effect2 E2 (.clk(clk), .trans(trans_2), .led7seg(led7seg_2), .enable(ENABLE), .frequency(frequency),
                .char0(char0), .char1(char1), .char2(char2), .char3(char3), .char4(char4), .char5(char5), .char6(char6));
    effect3 E3 (.clk(clk), .trans(trans_3), .led7seg(led7seg_3), .enable(ENABLE), .frequency(frequency),
                .char0(char0), .char1(char1), .char2(char2), .char3(char3), .char4(char4), .char5(char5), .char6(char6));
    effect4 E4 (.clk(clk), .trans(trans_4), .led7seg(led7seg_4), .enable(ENABLE), .frequency(frequency),
                .char0(char0), .char1(char1), .char2(char2), .char3(char3), .char4(char4), .char5(char5), .char6(char6));
    effect5 E5 (.clk(clk), .trans(trans_5), .led7seg(led7seg_5), .enable(ENABLE), .frequency(frequency),
                .char0(char0), .char1(char1), .char2(char2), .char3(char3), .char4(char4), .char5(char5), .char6(char6));
    effect6 E6 (.clk(clk), .trans(trans_6), .led7seg(led7seg_6), .enable(ENABLE), .frequency(frequency),
                .char0(char0), .char1(char1), .char2(char2), .char3(char3), .char4(char4), .char5(char5), .char6(char6));
    
    setting SET (.clk(clk), 
                 .rst(rst), 
                 .mode(mode),
                 .button2(button2),
                 .button3(button3),
                 .button4(button4),
                 .trans(trans_mode2), 
                 .led7seg(led7seg_mode2),
                 .single_led_sp(single_led_sp_mode2),
                 .counter_char0(char0),
                 .counter_char1(char1),
                 .counter_char2(char2),
                 .counter_char3(char3),
                 .counter_char4(char4),
                 .counter_char5(char5),
                 .counter_char6(char6));
endmodule