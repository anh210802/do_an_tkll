module setting (
    input clk,
    input rst,
    input button2, button3, button4,
    input mode,
    output reg[6:0] trans,
    output reg[6:0] led7seg,
    output reg[6:0] single_led_sp,
    output reg[6:0] counter_char0, counter_char1, counter_char2, counter_char3, counter_char4, counter_char5, counter_char6 
);

    wire[6:0] index0, index1, index2, index3, index4, index5, index6;
    reg[27:0] counter_timer;
    reg[27:0] counter;
    wire left_flag;
    wire right_flag;
    wire change_flag;
    reg[2:0] state_setting;
    reg[3:0] led_next;
    reg blink;
    reg[3:0] state_led7seg;
    reg[3:0] state_trans;

    localparam reg[6:0] led_null = 7'b1111111;

    always @(posedge clk) begin
        if (mode == 1'b1) begin
            if (left_flag == 1'b1) begin
                if (led_next == 4'd0) begin
                    led_next = 4'd6;
                end else begin
                    led_next = led_next - 4'd1;
                end
            end

            if (right_flag == 1'b1) begin
                if (led_next == 4'd6) begin
                    led_next = 4'd0;
                end else begin
                    led_next = led_next + 4'd1;
                end
            end

            if (change_flag == 1'b1) begin
                case (led_next)
                    4'd0: begin
                        if (counter_char0 == 7'd62) begin
                            counter_char0 <= 7'd0;
                        end else begin
                            counter_char0 <= counter_char0 + 7'd1;
                        end
                    end
                    4'd1: begin
                        if (counter_char1 == 7'd62) begin
                            counter_char1 <= 7'd0;
                        end else begin
                            counter_char1 <= counter_char1 + 7'd1;
                        end
                    end
                    4'd2: begin
                        if (counter_char2 == 7'd62) begin
                            counter_char2 <= 7'd0;
                        end else begin
                            counter_char2 <= counter_char2 + 7'd1;
                        end
                    end
                    4'd3: begin
                        if (counter_char3 == 7'd62) begin
                            counter_char3 <= 7'd0;
                        end else begin
                            counter_char3 <= counter_char3 + 7'd1;
                        end
                    end
                    4'd4: begin
                        if (counter_char4 == 7'd62) begin
                            counter_char4 <= 7'd0;
                        end else begin
                            counter_char4 <= counter_char4 + 7'd1;
                        end
                    end
                    4'd5: begin
                        if (counter_char5 == 7'd62) begin
                            counter_char5 <= 7'd0;
                        end else begin
                            counter_char5 <= counter_char5 + 7'd1;
                        end
                    end
                    4'd6: begin
                        if (counter_char6 == 7'd62) begin
                            counter_char6 <= 7'd0;
                        end else begin
                            counter_char6 <= counter_char6 + 7'd1;
                        end
                    end
                endcase
            end
        end else begin
            led_next = 4'd0;
        end
    end

    always @(posedge clk) begin
        if (mode == 1'b1) begin
            if (counter == 28'd25000) begin
                counter <= 0;
                if (state_trans == 4'd6) begin
                    state_trans <= 4'd0;
                end else begin
                    state_trans <= state_trans + 4'd1;
                end
            end else begin
                counter <= counter + 28'd1;
            end

            if (counter_timer == 28'd12500000) begin
                blink = ~blink;
                counter_timer <= 0;
            end else begin
                counter_timer <= counter_timer + 28'd1;
            end
        end else begin
            counter <= 0;
            counter_timer <= 0; 
        end
        case (state_trans)
            4'd0: begin
                trans = 7'b0111111;
                state_led7seg = 4'd0;
            end
            4'd1: begin
                trans = 7'b1011111;
                state_led7seg = 4'd1;
            end
            4'd2: begin
                trans = 7'b1101111;
                state_led7seg = 4'd2;
            end
            4'd3: begin
                trans = 7'b1110111;
                state_led7seg = 4'd3;
            end
            4'd4: begin
                trans = 7'b1111011;
                state_led7seg = 4'd4;
            end
            4'd5: begin
                trans = 7'b1111101;
                state_led7seg = 4'd5;
            end
            4'd6: begin
                trans = 7'b1111110;
                state_led7seg = 4'd6;
            end
            default: trans = 7'b1111111;
        endcase

        case (led_next)
            4'd0: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1111110;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = led_null;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                endcase
            end
            4'd1: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1111101;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = led_null;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                endcase
            end
            
            4'd2: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1111011;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = led_null;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                endcase
            end
            4'd3: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1110111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = led_null;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                endcase
            end
            4'd4: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1101111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = led_null;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                endcase
            end
            4'd5: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1011111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = led_null;
                            4'd6: led7seg = index6;
                        endcase
                    end
                endcase
            end
            4'd6: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b0111111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = index6;
                        endcase
                    end
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = index0;
                            4'd1: led7seg = index1;
                            4'd2: led7seg = index2;
                            4'd3: led7seg = index3;
                            4'd4: led7seg = index4;
                            4'd5: led7seg = index5;
                            4'd6: led7seg = led_null;
                        endcase
                    end
                endcase
            end
        endcase
    end

    table_char L0 (.clk(clk), .index(index0), .index_check(counter_char0));
    table_char L1 (.clk(clk), .index(index1), .index_check(counter_char1));
    table_char L2 (.clk(clk), .index(index2), .index_check(counter_char2));
    table_char L3 (.clk(clk), .index(index3), .index_check(counter_char3));
    table_char L4 (.clk(clk), .index(index4), .index_check(counter_char4));
    table_char L5 (.clk(clk), .index(index5), .index_check(counter_char5));
    table_char L6 (.clk(clk), .index(index6), .index_check(counter_char6));

    button LEFT (.clk(clk), .rst(rst), .btn(button2), .debounced(left_flag));
    button RIGHT (.clk(clk), .rst(rst), .btn(button3), .debounced(right_flag));
    button CHANGE (.clk(clk), .rst(rst), .btn(button4), .debounced(change_flag));

endmodule