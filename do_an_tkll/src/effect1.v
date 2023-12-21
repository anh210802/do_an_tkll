/*
    Hiệu ứng 2: 
        Hiển thị toàn bộ ký tự, các ký tự di chuyển sang phải được lặp đi lặp lại
*/
module effect1(
    input clk,
    output reg[6:0] trans,
    output reg[6:0] led7seg,
    input wire[2:0] enable,
    input wire[1:0] frequency,
    input [3:0] check,
    input [6:0] text_index
);

    localparam reg[27:0] FREQUENCY_05HZ = 28'd50000000; // 0.5Hz
    localparam reg[27:0] FREQUENCY_1HZ = 28'd25000000;  // 1Hz
    localparam reg[27:0] FREQUENCY_2HZ = 28'd12500000;  // 2Hz
    localparam reg[27:0] FREQUENCY_4HZ = 28'd6250000;   // 4Hz
    localparam reg[6:0] led_null = 7'b1111111;

    wire[6:0] TEXT0, TEXT1, TEXT2, TEXT3, TEXT4, TEXT5, TEXT6;

    reg[6:0] text0, text1, text2, text3, text4, text5, text6;
    reg [6:0] index0, index1, index2, index3, index4, index5, index6;
    reg[27:0] counter;
    reg[27:0] timer;
    reg[3:0] state_trans;
    reg[3:0] state_led7seg;
    reg[3:0] state_led7seg_check;
    reg[6:0] cycle;
    reg[27:0] FREQUENCY;

    assign text0 = TEXT0;
    assign text1 = TEXT1;
    assign text2 = TEXT2;
    assign text3 = TEXT3;
    assign text4 = TEXT4;
    assign text5 = TEXT5;
    assign text6 = TEXT6;


    always @(posedge clk) begin
        case (check) 
            4'd0 : index0 = text_index;
            4'd1 : index1 = text_index;
            4'd2 : index2 = text_index;
            4'd3 : index3 = text_index;
            4'd4 : index4 = text_index;
            4'd5 : index5 = text_index;
            4'd6 : index6 = text_index;
        endcase
    end

    always @(posedge clk) begin
        if (enable == 3'b001) begin
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
                if (cycle == 7'd6) begin
                    cycle <= 7'd0;
                end else begin
                    cycle <= cycle + 7'd1;
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
                    4'd0: led7seg = text0;
                    4'd1: led7seg = text1;
                    4'd2: led7seg = text2;
                    4'd3: led7seg = text3;
                    4'd4: led7seg = text4;
                    4'd5: led7seg = text5;
                    4'd6: led7seg = text6;
                endcase
            end
            7'd1: begin
                case (state_led7seg)
                    4'd0: led7seg = text1;
                    4'd1: led7seg = text2;
                    4'd2: led7seg = text3;
                    4'd3: led7seg = text4;
                    4'd4: led7seg = text5;
                    4'd5: led7seg = text6;
                    4'd6: led7seg = text0;
                endcase
            end
            7'd2: begin
                case (state_led7seg)
                    4'd0: led7seg = text2;
                    4'd1: led7seg = text3;
                    4'd2: led7seg = text4;
                    4'd3: led7seg = text5;
                    4'd4: led7seg = text6;
                    4'd5: led7seg = text0;
                    4'd6: led7seg = text1;
                endcase
            end
            7'd3: begin
                case (state_led7seg)
                    4'd0: led7seg = text3;
                    4'd1: led7seg = text4;
                    4'd2: led7seg = text5;
                    4'd3: led7seg = text6;
                    4'd4: led7seg = text0;
                    4'd5: led7seg = text1;
                    4'd6: led7seg = text2;
                endcase
            end
            7'd4: begin
                case (state_led7seg)
                    4'd0: led7seg = text4;
                    4'd1: led7seg = text5;
                    4'd2: led7seg = text6;
                    4'd3: led7seg = text0;
                    4'd4: led7seg = text1;
                    4'd5: led7seg = text2;
                    4'd6: led7seg = text3;
                endcase
            end
            7'd5: begin
                case (state_led7seg)
                    4'd0: led7seg = text5;
                    4'd1: led7seg = text6;
                    4'd2: led7seg = text0;
                    4'd3: led7seg = text1;
                    4'd4: led7seg = text2;
                    4'd5: led7seg = text3;
                    4'd6: led7seg = text4;
                endcase
            end
            7'd6: begin
                case (state_led7seg)
                    4'd0: led7seg = text6;
                    4'd1: led7seg = text0;
                    4'd2: led7seg = text1;
                    4'd3: led7seg = text2;
                    4'd4: led7seg = text3;
                    4'd5: led7seg = text4;
                    4'd6: led7seg = text5;
                endcase
            end
            default: led7seg = 7'b1111111;
        endcase
    end
    /*******************************************************************/
    table_char READ0 (.clk(clk), .text(TEXT0), .index(index0));
    table_char READ1 (.clk(clk), .text(TEXT1), .index(index1));
    table_char READ2 (.clk(clk), .text(TEXT2), .index(index2));
    table_char READ3 (.clk(clk), .text(TEXT3), .index(index3));
    table_char READ4 (.clk(clk), .text(TEXT4), .index(index4));
    table_char READ5 (.clk(clk), .text(TEXT5), .index(index5));
    table_char READ6 (.clk(clk), .text(TEXT6), .index(index6));
    
endmodule