module effect6(
    input clk,
    output reg[6:0] trans,
    output reg[6:0] led7seg,
    input wire[2:0] enable,
    input wire[1:0] frequency,
    input [6:0] char0, char1, char2, char3, char4, char5, char6
);

    localparam reg[27:0] FREQUENCY_05HZ = 28'd50000000;
    localparam reg[27:0] FREQUENCY_1HZ = 28'd25000000;
    localparam reg[27:0] FREQUENCY_2HZ = 28'd12500000;
    localparam reg[27:0] FREQUENCY_4HZ = 28'd6250000;
    reg[27:0] FREQUENCY;

    wire [6:0] index0;
    wire [6:0] index1;
    wire [6:0] index2;
    wire [6:0] index3;
    wire [6:0] index4;
    wire [6:0] index5;
    wire [6:0] index6;
    
    localparam reg[6:0] led_null = 7'b1111111;
    localparam reg[6:0] ball = 7'b0111000;
    reg[27:0] counter;
    reg[27:0] timer;
    reg[3:0] state_trans;
    reg[3:0] state_led7seg;
    reg[3:0] state_led7seg_check;
    reg[6:0] cycle;
    always @(posedge clk) begin
        if (enable == 3'b110) begin
            case (frequency)
                2'b00: FREQUENCY = FREQUENCY_05HZ;
                2'b01: FREQUENCY = FREQUENCY_1HZ;
                2'b10: FREQUENCY = FREQUENCY_2HZ;
                2'b11: FREQUENCY = FREQUENCY_4HZ;
            endcase

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
            if (timer >= FREQUENCY) begin
                timer <= 0;
                if (cycle == 7'd33) begin
                    cycle <= 7'd0;
                end else begin
                    cycle <= cycle + 4'd1;
                end
            end else begin
                timer <= timer + 28'd1;
            end
        end else begin
            cycle <= 7'd0;
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
    end

    always @(posedge clk) begin
        case (cycle) 
            7'd0: begin
                case (state_led7seg)
                4'd0: led7seg = 7'b1111101;
                4'd1: led7seg = 7'b1111101;
                4'd2: led7seg = 7'b1111101;
                4'd3: led7seg = 7'b1111101;
                4'd4: led7seg = 7'b1111101;
                4'd5: led7seg = 7'b1111101;
                4'd6: led7seg = 7'b1111101;
                endcase
            end
            7'd1: begin
                case (state_led7seg)
                4'd0: led7seg = 7'b1111101;
                4'd1: led7seg = 7'b1111101;
                4'd2: led7seg = 7'b1111101;
                4'd3: led7seg = 7'b1111101;
                4'd4: led7seg = 7'b1111101;
                4'd5: led7seg = 7'b1111101;
                4'd6: led7seg = ball;
                endcase
            end
            7'd2: begin
                case (state_led7seg)
                4'd0: led7seg = 7'b1111101;
                4'd1: led7seg = 7'b1111101;
                4'd2: led7seg = 7'b1111101;
                4'd3: led7seg = 7'b1111101;
                4'd4: led7seg = 7'b1111101;
                4'd5: led7seg = ball;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd3: begin
                case (state_led7seg)
                4'd0: led7seg = 7'b1111101;
                4'd1: led7seg = 7'b1111101;
                4'd2: led7seg = 7'b1111101;
                4'd3: led7seg = 7'b1111101;
                4'd4: led7seg = ball;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd4: begin
                case (state_led7seg)
                4'd0: led7seg = 7'b1111101;
                4'd1: led7seg = 7'b1111101;
                4'd2: led7seg = 7'b1111101;
                4'd3: led7seg = ball;
                4'd4: led7seg = led_null;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd5: begin
                case (state_led7seg)
                4'd0: led7seg = 7'b1111101;
                4'd1: led7seg = 7'b1111101;
                4'd2: led7seg = ball;
                4'd3: led7seg = led_null;
                4'd4: led7seg = led_null;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd6: begin
                case (state_led7seg)
                4'd0: led7seg = 7'b1111101;
                4'd1: led7seg = ball;
                4'd2: led7seg = led_null;
                4'd3: led7seg = led_null;
                4'd4: led7seg = led_null;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd7: begin
                case (state_led7seg)
                4'd0: led7seg = ball;
                4'd1: led7seg = led_null;
                4'd2: led7seg = led_null;
                4'd3: led7seg = led_null;
                4'd4: led7seg = led_null;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd8: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = led_null;
                4'd2: led7seg = led_null;
                4'd3: led7seg = led_null;
                4'd4: led7seg = led_null;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd9: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b1001100;
                4'd2: led7seg = led_null;
                4'd3: led7seg = led_null;
                4'd4: led7seg = led_null;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd10: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b1001100;
                4'd3: led7seg = led_null;
                4'd4: led7seg = led_null;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd11: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b1001100;
                4'd4: led7seg = led_null;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd12: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b0111111;
                4'd4: led7seg = 7'b1001100;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd13: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b0111111;
                4'd4: led7seg = 7'b0111111;
                4'd5: led7seg = 7'b1001100;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd14: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b0111111;
                4'd4: led7seg = 7'b0111111;
                4'd5: led7seg = 7'b0111111;
                4'd6: led7seg = 7'b1001100;
                endcase
            end
            7'd15: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b0111111;
                4'd4: led7seg = 7'b0111111;
                4'd5: led7seg = 7'b0111111;
                4'd6: led7seg = 7'b0111111;
                endcase
            end
            7'd16: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b0111111;
                4'd4: led7seg = 7'b0111111;
                4'd5: led7seg = 7'b0111111;
                4'd6: led7seg = 7'b1001100;
                endcase
            end
            7'd17: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b0111111;
                4'd4: led7seg = 7'b0111111;
                4'd5: led7seg = 7'b1001100;
                4'd6: led7seg = index1;
                endcase
            end
            7'd18: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b0111111;
                4'd4: led7seg = 7'b1001100;
                4'd5: led7seg = index1;
                4'd6: led7seg = index2;
                endcase
            end
            7'd19: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b1001100;
                4'd4: led7seg = index1;
                4'd5: led7seg = index2;
                4'd6: led7seg = index3;
                endcase
            end
            7'd20: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b1001100;
                4'd3: led7seg = index1;
                4'd4: led7seg = index2;
                4'd5: led7seg = index3;
                4'd6: led7seg = index4;
                endcase
            end
            7'd21: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b1001100;
                4'd2: led7seg = index1;
                4'd3: led7seg = index2;
                4'd4: led7seg = index3;
                4'd5: led7seg = index4;
                4'd6: led7seg = index5;
                endcase
            end
            7'd22: begin
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
            7'd23: begin
                case (state_led7seg)
                4'd0: led7seg = led_null;
                4'd1: led7seg = led_null;
                4'd2: led7seg = led_null;
                4'd3: led7seg = led_null;
                4'd4: led7seg = led_null;
                4'd5: led7seg = led_null;
                4'd6: led7seg = led_null;
                endcase
            end
            7'd24: begin
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
            7'd25: begin
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
            7'd26: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = index1;
                4'd2: led7seg = index2;
                4'd3: led7seg = index3;
                4'd4: led7seg = index4;
                4'd5: led7seg = index5;
                4'd6: led7seg = 7'b0111111;
                endcase
            end
            7'd27: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = index1;
                4'd2: led7seg = index2;
                4'd3: led7seg = index3;
                4'd4: led7seg = index4;
                4'd5: led7seg = 7'b0111111;
                4'd6: led7seg = 7'b1111101;
                endcase
            end
            7'd28: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = index1;
                4'd2: led7seg = index2;
                4'd3: led7seg = index3;
                4'd4: led7seg = 7'b0111111;
                4'd5: led7seg = 7'b1111101;
                4'd6: led7seg = 7'b1111101;
                endcase
            end
            7'd29: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = index1;
                4'd2: led7seg = index2;
                4'd3: led7seg = 7'b0111111;
                4'd4: led7seg = 7'b1111101;
                4'd5: led7seg = 7'b1111101;
                4'd6: led7seg = 7'b1111101;
                endcase
            end
            7'd30: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = index1;
                4'd2: led7seg = 7'b0111111;
                4'd3: led7seg = 7'b1111101;
                4'd4: led7seg = 7'b1111101;
                4'd5: led7seg = 7'b1111101;
                4'd6: led7seg = 7'b1111101;
                endcase
            end
            7'd31: begin
                case (state_led7seg)
                4'd0: led7seg = index0;
                4'd1: led7seg = 7'b0111111;
                4'd2: led7seg = 7'b1111101;
                4'd3: led7seg = 7'b1111101;
                4'd4: led7seg = 7'b1111101;
                4'd5: led7seg = 7'b1111101;
                4'd6: led7seg = 7'b1111101;
                endcase
            end
            7'd32: begin
                case (state_led7seg)
                4'd0: led7seg = 7'b0111111;
                4'd1: led7seg = 7'b1111101;
                4'd2: led7seg = 7'b1111101;
                4'd3: led7seg = 7'b1111101;
                4'd4: led7seg = 7'b1111101;
                4'd5: led7seg = 7'b1111101;
                4'd6: led7seg = 7'b1111101;
                endcase
            end
            7'd33: begin
                case (state_led7seg)
                4'd0: led7seg = 7'b1111101;
                4'd1: led7seg = 7'b1111101;
                4'd2: led7seg = 7'b1111101;
                4'd3: led7seg = 7'b1111101;
                4'd4: led7seg = 7'b1111101;
                4'd5: led7seg = 7'b1111101;
                4'd6: led7seg = 7'b1111101;
                endcase
            end
            default: led7seg = 7'b1111111;
        endcase
        
    end
    
    table_char I0 (.clk(clk), .index(index0), .index_check(char0));
    table_char I1 (.clk(clk), .index(index1), .index_check(char1));
    table_char I2 (.clk(clk), .index(index2), .index_check(char2));
    table_char I3 (.clk(clk), .index(index3), .index_check(char3));
    table_char I4 (.clk(clk), .index(index4), .index_check(char4));
    table_char I5 (.clk(clk), .index(index5), .index_check(char5));
    table_char I6 (.clk(clk), .index(index6), .index_check(char6));
        
endmodule