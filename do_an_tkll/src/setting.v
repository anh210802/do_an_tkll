/*
    Module setting: mode 1
    Cho phép ngưon dùng thay đổi/ thêm/ xóa ký tự
*/

module setting (
    // Host Side
    input clk,
    input rst,
    // Kết nối button
    input button2, button3, button4,
    // MODE
    input mode,
    // Kết nối hiện thị LED 7 đoạn
    output reg[6:0] trans,
    output reg[6:0] led7seg,
    output reg[6:0] single_led_sp,
    // Dữ liệu thay đổi ký tự
    output reg[3:0] check_index,
    output reg[6:0] index
);

    // Khai báo biến truyền module
    wire left_flag;
    wire right_flag;
    wire change_flag;

    // Khai báo biến dữ liệu
    reg[6:0] index0, index1, index2, index3, index4, index5, index6;
    reg[6:0] text0, text1, text2, text3, text4, text5, text6;
    reg[6:0] counter_char;
    reg[27:0] counter_timer;
    reg[27:0] counter;
    reg[2:0] state_setting;
    reg blink;
    reg[3:0] state_led7seg;
    reg[3:0] state_trans;
    reg[3:0] led_next;

    // Tạo liên kết biến dữ liệu với biến truyền dữ liệu
    assign check_index = led_next;

    localparam reg[6:0] led_null = 7'b1111111;

    // Tạo liên kết biến truyền dữ liệu với biến dữ liệu
    always @(posedge clk) begin
        case (check_index) 
            4'd0 : index = index0;
            4'd1 : index = index1;
            4'd2 : index = index2;
            4'd3 : index = index3;
            4'd4 : index = index4;
            4'd5 : index = index5;
            4'd6 : index = index6;
        endcase
    end

    // Trạng thái của máy trạng thái cài đặt ký tự
    localparam reg[3:0] INIT = 4'd0;
    localparam reg[3:0] SETUP_LED0 = 4'd1;
    localparam reg[3:0] SETUP_LED1 = 4'd2;
    localparam reg[3:0] SETUP_LED2 = 4'd3;
    localparam reg[3:0] SETUP_LED3 = 4'd4;
    localparam reg[3:0] SETUP_LED4 = 4'd5;
    localparam reg[3:0] SETUP_LED5 = 4'd6;
    localparam reg[3:0] SETUP_LED6 = 4'd7;
    reg[3:0] state_machine;
    // Máy trạng trái cài đặt ký tự
    always @(posedge clk) begin
        // Điều kiện hoạt động của máy trạng thái
        if (mode == 1'b1) begin
            case (state_machine)
                INIT : begin
                    led_next = 4'd0;
                    state_machine = SETUP_LED0;
                end

                SETUP_LED0: begin
                    // Nhấn nút chuyển sang trái
                    if (left_flag == 1'b1) begin
                        led_next <= 4'd6;
                        state_machine = SETUP_LED6;
                    end
                    // Nhấn nút chuyển san phải
                    if (right_flag == 1'b1) begin
                        led_next <= 4'd1;
                        state_machine = SETUP_LED1;
                    end
                    // Nhấn nút đổi ký tự
                    if (change_flag == 1'b1) begin
                        if (index0 == 7'd62) begin
                            index0 <= 7'd0;
                        end else begin
                            index0 <= index0 + 7'd1;
                        end
                    end
                end

                SETUP_LED1: begin
                    // Nhấn nút chuyển sang trái
                    if (left_flag == 1'b1) begin
                        led_next <= 4'd0;
                        state_machine = SETUP_LED0;
                    end
                    // Nhấn nút chuyển san phải
                    if (right_flag == 1'b1) begin
                        led_next <= 4'd2;
                        state_machine = SETUP_LED2;
                    end
                    // Nhấn nút đổi ký tự
                    if (change_flag == 1'b1) begin
                        if (index1 == 7'd62) begin
                            index1 <= 7'd0;
                        end else begin
                            index1 <= index1 + 7'd1;
                        end
                    end
                end

                SETUP_LED2: begin
                    // Nhấn nút chuyển sang trái
                    if (left_flag == 1'b1) begin
                        led_next <= 4'd1;
                        state_machine = SETUP_LED1;
                    end
                    // Nhấn nút chuyển san phải
                    if (right_flag == 1'b1) begin
                        led_next <= 4'd3;
                        state_machine = SETUP_LED3;
                    end
                    // Nhấn nút đổi ký tự
                    if (change_flag == 1'b1) begin
                        if (index2 == 7'd62) begin
                            index2 <= 7'd0;
                        end else begin
                            index2 <= index2 + 7'd1;
                        end
                    end
                end
                
                SETUP_LED3: begin
                    // Nhấn nút chuyển sang trái
                    if (left_flag == 1'b1) begin
                        led_next <= 4'd2;
                        state_machine = SETUP_LED2;
                    end
                    // Nhấn nút chuyển san phải
                    if (right_flag == 1'b1) begin
                        led_next <= 4'd4;
                        state_machine = SETUP_LED4;
                    end
                    // Nhấn nút đổi ký tự
                    if (change_flag == 1'b1) begin
                        if (index3 == 7'd62) begin
                            index3 <= 7'd0;
                        end else begin
                            index3 <= index3 + 7'd1;
                        end
                    end
                end

                SETUP_LED4: begin
                    // Nhấn nút chuyển sang trái
                    if (left_flag == 1'b1) begin
                        led_next <= 4'd3;
                        state_machine = SETUP_LED3;
                    end
                    // Nhấn nút chuyển san phải
                    if (right_flag == 1'b1) begin
                        led_next <= 4'd5;
                        state_machine = SETUP_LED5;
                    end
                    // Nhấn nút đổi ký tự
                    if (change_flag == 1'b1) begin
                        if (index4 == 7'd62) begin
                            index4 <= 7'd0;
                        end else begin
                            index4 <= index4 + 7'd1;
                        end
                    end
                end

                SETUP_LED5: begin
                    // Nhấn nút chuyển sang trái
                    if (left_flag == 1'b1) begin
                        led_next <= 4'd4;
                        state_machine = SETUP_LED4;
                    end
                    // Nhấn nút chuyển san phải
                    if (right_flag == 1'b1) begin
                        led_next <= 4'd6;
                        state_machine = SETUP_LED6;
                    end
                    // Nhấn nút đổi ký tự
                    if (change_flag == 1'b1) begin
                        if (index5 == 7'd62) begin
                            index5 <= 7'd0;
                        end else begin
                            index5 <= index5 + 7'd1;
                        end
                    end
                end

                SETUP_LED6: begin
                    // Nhấn nút chuyển sang trái
                    if (left_flag == 1'b1) begin
                        led_next <= 4'd5;
                        state_machine = SETUP_LED5;
                    end
                    // Nhấn nút chuyển san phải
                    if (right_flag == 1'b1) begin
                        led_next <= 4'd0;
                        state_machine = SETUP_LED0;
                    end
                    // Nhấn nút đổi ký tự
                    if (change_flag == 1'b1) begin
                        if (index6 == 7'd62) begin
                            index6 <= 7'd0;
                        end else begin
                            index6 <= index6 + 7'd1;
                        end
                    end
                end

            endcase
        end else begin
            // Máy trạng thái khi không hoạt động
            led_next = 4'd0;
            state_machine = INIT;
        end
    end

    // Cài đặt hiển thị cho máy trạng thái
    always @(posedge clk) begin
        if (mode == 1'b1) begin // Điều kiện hiển thị
            // Hoạt động của transistor
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
            // Hoạt động của led đơn bổ trợ
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
        // Trạng thái của transistor
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
        /*  
            Cài đặt hiển thị của led 7 đoạn và led đơn 
            Khi led 7 đoạn được chọn sẽ nhấp nháy với tần số 2Hz
            LED đơn tương ứng nhấp nháy với tần số 2Hz
        */
        case (led_next)
            4'd0: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1111110;
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
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = led_null;
                            4'd1: led7seg = text1;
                            4'd2: led7seg = text2;
                            4'd3: led7seg = text3;
                            4'd4: led7seg = text4;
                            4'd5: led7seg = text5;
                            4'd6: led7seg = text6;
                        endcase
                    end
                endcase
            end

            4'd1: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1111101;
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
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = text0;
                            4'd1: led7seg = led_null;
                            4'd2: led7seg = text2;
                            4'd3: led7seg = text3;
                            4'd4: led7seg = text4;
                            4'd5: led7seg = text5;
                            4'd6: led7seg = text6;
                        endcase
                    end
                endcase
            end

            4'd2: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1111011;
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
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = text0;
                            4'd1: led7seg = text1;
                            4'd2: led7seg = led_null;
                            4'd3: led7seg = text3;
                            4'd4: led7seg = text4;
                            4'd5: led7seg = text5;
                            4'd6: led7seg = text6;
                        endcase
                    end
                endcase
            end

            4'd3: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1110111;
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
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = text0;
                            4'd1: led7seg = text1;
                            4'd2: led7seg = text2;
                            4'd3: led7seg = led_null;
                            4'd4: led7seg = text4;
                            4'd5: led7seg = text5;
                            4'd6: led7seg = text6;
                        endcase
                    end
                endcase
            end

            4'd4: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1101111;
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
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = text0;
                            4'd1: led7seg = text1;
                            4'd2: led7seg = text2;
                            4'd3: led7seg = text3;
                            4'd4: led7seg = led_null;
                            4'd5: led7seg = text5;
                            4'd6: led7seg = text6;
                        endcase
                    end
                endcase
            end

            4'd5: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b1011111;
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
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = text0;
                            4'd1: led7seg = text1;
                            4'd2: led7seg = text2;
                            4'd3: led7seg = text3;
                            4'd4: led7seg = text4;
                            4'd5: led7seg = led_null;
                            4'd6: led7seg = text6;
                        endcase
                    end
                endcase
            end

            4'd6: begin
                case (blink)
                    1'b0: begin
                        single_led_sp <= 7'b0111111;
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
                    1'b1: begin
                        single_led_sp <= 7'b1111111;
                        case (state_led7seg)
                            4'd0: led7seg = text0;
                            4'd1: led7seg = text1;
                            4'd2: led7seg = text2;
                            4'd3: led7seg = text3;
                            4'd4: led7seg = text4;
                            4'd5: led7seg = text5;
                            4'd6: led7seg = led_null;
                        endcase
                    end
                endcase
            end
        endcase
    end
    /**************************************************************************************/
    // Gọi các module con
    // Lấy các ký tự từ bảng ký tự
    table_char WRITE0 (.clk(clk), .text(text0), .index(index0));
    table_char WRITE1 (.clk(clk), .text(text1), .index(index1));
    table_char WRITE2 (.clk(clk), .text(text2), .index(index2));
    table_char WRITE3 (.clk(clk), .text(text3), .index(index3));
    table_char WRITE4 (.clk(clk), .text(text4), .index(index4));
    table_char WRITE5 (.clk(clk), .text(text5), .index(index5));
    table_char WRITE6 (.clk(clk), .text(text6), .index(index6));
    // Nút nhấn chuyển sang led 7 đoạn bên trái
    button LEFT (.clk(clk), .rst(rst), .btn(button2), .debounced(left_flag));
    // Nút nhấn chuyển sang led 7 đoạn bên phải
    button RIGHT (.clk(clk), .rst(rst), .btn(button3), .debounced(right_flag));
    // Nút nhấn thay đổi ký tự
    button CHANGE (.clk(clk), .rst(rst), .btn(button4), .debounced(change_flag));

endmodule