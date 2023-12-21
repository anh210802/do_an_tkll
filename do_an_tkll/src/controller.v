/*
    Module điều kiển các chức năng của hệ thống ở mode 0
*/

module controller (
    // Host Side
    input clk,
    input rst,
    // Kết nối button
    input button2, button3, button4,
    // Kết nối Switch
    input [6:0] switch,
    // Kết nối hiện thị LED 7 đoạn
    input wire mode,
    output reg[6:0] trans,
    output reg[6:0] led7seg,
    output reg[6:0] single_led_sp
);

    // Khai báo các biến truyền module 
    wire eff_btn_flag;
    wire fre_btn_flag;
    wire stop_btn_flag;
    wire[6:0] switch_flag;
    wire[3:0] check_index;
    wire[6:0] index;
    
    // Khai báo các biến nhớ
    reg[3:0] effect;
    reg[6:0] led7seg_0, led7seg_1, led7seg_2, led7seg_3, led7seg_4, led7seg_5, led7seg_6;
    reg[6:0] trans_0, trans_1, trans_2, trans_3, trans_4, trans_5, trans_6;
    reg[2:0] ENABLE;
    reg[34:0] timer0_counter, timer1_counter, timer2_counter, timer3_counter, timer4_counter, timer5_counter, timer6_counter;
    reg[34:0] counter;
    reg[1:0] frequency;

    reg[6:0] trans_mode2;
    reg[6:0] led7seg_mode2;
    reg[6:0] single_led_sp_mode2;   
    reg stop_flag;
    reg[3:0] check;
    reg[6:0] text_index;

    ///////////////////////////////////////////////////
    /*
        Liên kết các biến truyền module với biến nhớ
        "check" vị trí các led
        "text_index" vị trí các ký tự trong bảng ký tự
    */
    assign check = check_index;
    assign text_index = index;
    /////////////////////////////////////////////////////
    
    // Trạng thái của máy trạng thái trình diễn hiệu ứng (mode 0)
    localparam reg[3:0] INIT = 4'd0;
    localparam reg[3:0] STATE_EFFECT_1 = 4'd1;
    localparam reg[3:0] STATE_EFFECT_2 = 4'd2;
    localparam reg[3:0] STATE_EFFECT_3 = 4'd3;
    localparam reg[3:0] STATE_EFFECT_4 = 4'd4;
    localparam reg[3:0] STATE_EFFECT_5 = 4'd5;
    localparam reg[3:0] STATE_EFFECT_6 = 4'd6;
    localparam reg[3:0] STATE_EFFECT_7 = 4'd7;

    // Máy trạng thái hiện thị hiệu ứng led
    always @(posedge clk) begin
        if (mode == 1'b0) begin // Điều kiện để máy trạng thái hoạt động
            /* 
                Tạo cờ chế độ chỉ hiển thị 1 hiệu ứng
                Nếu hệ thống đang tình diễn hiệu ứng nếu có cờ thì hệ thống chỉ trình diễn hiệu ứng đó
            */
            if (stop_btn_flag == 1'b1) begin
                stop_flag = ~stop_flag;
            end
        // Bắt đầu máy trạng thái
            case (effect) 
                INIT: begin
                    frequency <= 2'd0;
                    counter <= 35'd0;
                    stop_flag <= 1'b0; 
                    single_led_sp = single_led_sp_mode2;
                    trans = trans_mode2;
                    led7seg = led7seg_mode2;
                    effect = STATE_EFFECT_1;
                end
                STATE_EFFECT_1: begin 
                    single_led_sp = 7'b1111110;
                    trans = trans_0;
                    led7seg = led7seg_0;
                    ENABLE = 3'b000;
                    // Tạo delay cho hiệu ứng 1
                    if (counter >= timer0_counter) begin
                        counter <= 35'd0;
                        effect = STATE_EFFECT_2; // Chuyển hiệu ứng
                    end else begin 
                        // Nếu có cờ được bật lên thì counter được đưa về 0
                        if (stop_flag == 1'b1) begin
                            counter = 35'd0;
                        end else begin
                            counter = counter + 35'd1;
                        end
                    end
                    // Nhấn nút chuyển hiệu ứng 
                    if (eff_btn_flag) begin
                        effect = STATE_EFFECT_2;  
                    end
                    // Điều chỉnh tần số 
                    if (fre_btn_flag == 1'b1) begin 
                        if (frequency == 2'd3) begin
                            frequency <= 2'd0;
                        end else begin
                            frequency <= frequency + 2'd1;
                        end
                    end
                end
                
                STATE_EFFECT_2: begin
                    single_led_sp = 7'b1111101;
                    trans = trans_1;
                    led7seg = led7seg_1;
                    ENABLE = 3'b001;
                    // Tạo delay cho hiệu ứng 2
                    if (counter >= timer1_counter) begin
                        counter <= 35'd0;
                        effect = STATE_EFFECT_3; // Chuyển hiệu ứng
                    end
                    else begin
                        // Nếu có cờ được bật lên thì counter được đưa về 0
                        if (stop_flag == 1'b1) begin
                            counter = 35'd0;
                        end else begin
                            counter = counter + 35'd1;
                        end
                    end
                    // Nhấn nút chuyển hiệu ứng
                    if (eff_btn_flag) begin
                        effect = STATE_EFFECT_3;  
                    end
                    // Điều chỉnh tần số
                    if (fre_btn_flag == 1'b1) begin 
                        if (frequency == 2'd3) begin
                            frequency <= 2'd0;
                        end else begin
                            frequency <= frequency + 2'd1;
                        end
                    end
                end

                STATE_EFFECT_3: begin
                    single_led_sp = 7'b1111011;
                    trans = trans_2;
                    led7seg = led7seg_2;
                    ENABLE = 3'b010;
                    // Tạo delay cho hiệu ứng 3
                    if (counter >= timer2_counter) begin
                        counter <= 35'd0;
                        effect = STATE_EFFECT_4; // Chuyển hiệu ứng
                    end
                    else begin
                        // Nếu có cờ được bật lên thì counter được đưa về 0
                        if (stop_flag == 1'b1) begin
                            counter = 35'd0;
                        end else begin
                            counter = counter + 35'd1;
                        end
                    end
                    // Nhấn nút chuyển hiệu ứng
                    if (eff_btn_flag) begin
                        effect = STATE_EFFECT_4;  
                    end
                    // Điều chỉnh tần số
                    if (fre_btn_flag == 1'b1) begin 
                        if (frequency == 2'd3) begin
                            frequency <= 2'd0;
                        end else begin
                            frequency <= frequency + 2'd1;
                        end
                    end
                end

                STATE_EFFECT_4: begin
                    single_led_sp = 7'b1110111;
                    trans = trans_3;
                    led7seg = led7seg_3;
                    ENABLE = 3'b011;
                    // Tạo delay cho hiệu ứng 4
                    if (counter >= timer3_counter) begin
                        counter <= 35'd0;
                        effect = STATE_EFFECT_5; // Chuyển hiệu ứng
                    end
                    else begin
                        // Nếu có cờ được bật lên thì counter được đưa về 0 
                        if (stop_flag == 1'b1) begin
                            counter = 35'd0;
                        end else begin
                            counter = counter + 35'd1;
                        end
                    end
                    // Nhấn nút chuyển hiệu ứng
                    if (eff_btn_flag) begin
                        effect = STATE_EFFECT_5;  
                    end
                    // Điều chỉnh tần số
                    if (fre_btn_flag >= 1'b1) begin 
                        if (frequency == 2'd3) begin
                            frequency <= 2'd0;
                        end else begin
                            frequency <= frequency + 2'd1;
                        end
                    end
                end

                STATE_EFFECT_5: begin
                    single_led_sp = 7'b1101111;
                    trans = trans_4;
                    led7seg = led7seg_4;
                    ENABLE = 3'b100;
                    // Tạo delay cho hiệu ứng 5
                    if (counter >= timer4_counter) begin
                        counter <= 35'd0;
                        effect = STATE_EFFECT_6; // Chuyển hiệu ứng
                    end
                    else begin
                        // Nếu có cờ được bật lên thì counter được đưa về 0
                        if (stop_flag == 1'b1) begin
                            counter = 35'd0;
                        end else begin
                            counter = counter + 35'd1;
                        end
                    end
                    // Nhấn nút chuyển hiệu ứng
                    if (eff_btn_flag) begin
                        effect = STATE_EFFECT_6;  
                    end
                    // Điều chỉnh tần số
                    if (fre_btn_flag == 1'b1) begin 
                        if (frequency == 2'd3) begin
                            frequency <= 2'd0;
                        end else begin
                            frequency <= frequency + 2'd1;
                        end
                    end
                end

                STATE_EFFECT_6: begin
                    single_led_sp = 7'b1011111;
                    trans = trans_5;
                    led7seg = led7seg_5;
                    ENABLE = 3'b101;
                    // Tạo delay cho hiệu ứng 6
                    if (counter >= timer5_counter) begin
                        counter <= 35'd0;
                        effect = STATE_EFFECT_7; // Chuyển hiệu ứng
                    end
                    else begin
                        // Nếu có cờ được báo lên thì counter là 0
                        if (stop_flag == 1'b1) begin
                            counter = 35'd0;
                        end else begin
                            counter = counter + 35'd1;
                        end
                    end
                    // Nhấn nút chuyển hiệu ứng
                    if (eff_btn_flag) begin
                        effect = STATE_EFFECT_7;  
                    end
                    // Điều chỉnh tần số
                    if (fre_btn_flag == 1'b1) begin 
                        if (frequency == 2'd3) begin
                            frequency <= 2'd0;
                        end else begin
                            frequency <= frequency + 2'd1;
                        end
                    end
                end

                STATE_EFFECT_7: begin
                    single_led_sp = 7'b0111111;
                    trans = trans_6;
                    led7seg = led7seg_6;
                    ENABLE = 3'b110;
                    // Tạo delay cho hiệu ứng 7
                    if (counter >= timer6_counter) begin
                        counter <= 35'd0;
                        effect = STATE_EFFECT_1; // Chuyển hiệu ứng
                    end
                    else begin
                        // Nếu có cờ được báo lên thì counter là 0
                        if (stop_flag == 1'b1) begin
                            counter = 35'd0;
                        end else begin
                            counter = counter + 35'd1;
                        end
                    end
                    // Nhấn nút chuyển hiệu ứng
                    if (eff_btn_flag) begin
                        effect = STATE_EFFECT_1;  
                    end
                    // Điều chỉnh tần số
                    if (fre_btn_flag == 1'b1) begin 
                        if (frequency == 2'd3) begin
                            frequency <= 2'd0;
                        end else begin
                            frequency <= frequency + 2'd1;
                        end
                    end
                end
            endcase
        end else begin
            // Khi mode = 1 thì các giá trị quay về ban đầu
            effect = INIT;
            frequency <= 2'd0;
            counter <= 35'd0;
            stop_flag <= 1'b0; 
            single_led_sp = single_led_sp_mode2;
            trans = trans_mode2;
            led7seg = led7seg_mode2;
        end
    end
    /*
        Tạo thời gian cho trình diễn hiệu ứng theo từng tần số
        Cài đặt chức năng cho các nút gạt: 
            Khi nút gạt tắt thì thời gian trình diễn của các hiệu ứng là 0
    */
    always @(posedge clk) begin
        // Nút gạt trình diễn hiệu ứng 1
        if (switch_flag[0] == 1'b1) begin
            case (frequency)
                2'b00: timer0_counter = 35'd2400000000; //F = 0,5HZ
                2'b01: timer0_counter = 35'd1200000000; //F = 1HZ
                2'b10: timer0_counter = 35'd600000000;  //F = 2HZ
                2'b11: timer0_counter = 35'd300000000;  //F = 4HZ
            endcase
        end else begin
            timer0_counter = 35'd0;
        end
        // Nút gạt trình diễn hiệu ứng 2
        if (switch_flag[1] == 1'b1) begin
            case (frequency)
                2'b00: timer1_counter = 35'd700000000; //F = 0,5HZ
                2'b01: timer1_counter = 35'd350000000; //F = 1HZ
                2'b10: timer1_counter = 35'd175000000; //F = 2HZ
                2'b11: timer1_counter = 35'd87500000;  //F = 4HZ
            endcase
        end else begin
            timer1_counter = 35'd0;
        end
        // Nút gạt trình diễn hiệu ứng 3
        if (switch_flag[2] == 1'b1) begin
            case (frequency)
                2'b00: timer2_counter = 35'd700000000;  //F = 0,5HZ
                2'b01: timer2_counter = 35'd350000000;  //F = 1HZ
                2'b10: timer2_counter = 35'd175000000;  //F = 2HZ
                2'b11: timer2_counter = 35'd87500000;   //F = 4HZ
            endcase
        end else begin
            timer2_counter = 35'd0;
        end
        // Nút gạt trình diễn hiệu ứng 4
        if (switch_flag[3] == 1'b1) begin
            case (frequency)
                2'b00: timer3_counter = 35'd1100000000; //F = 0,5HZ
                2'b01: timer3_counter = 35'd550000000;  //F = 1HZ
                2'b10: timer3_counter = 35'd275000000;  //F = 2HZ
                2'b11: timer3_counter = 35'd137500000;  //F = 4HZ
            endcase
        end else begin
            timer3_counter = 35'd0;
        end
        // Nút gạt trình diễn hiệu ứng 5
        if (switch_flag[4] == 1'b1) begin
            case (frequency)
                2'b00: timer4_counter = 35'd1600000000; //F = 0,5HZ
                2'b01: timer4_counter = 35'd800000000;  //F = 1HZ
                2'b10: timer4_counter = 35'd400000000;  //F = 2HZ
                2'b11: timer4_counter = 35'd200000000;  //F = 4HZ
            endcase
        end else begin
            timer4_counter = 35'd0;
        end
        // Nút gạt trình diễn hiệu ứng 6
        if (switch_flag[5] == 1'b1) begin
            case (frequency)
                2'b00: timer5_counter = 35'd3300000000; //F = 0,5HZ
                2'b01: timer5_counter = 35'd1650000000; //F = 1HZ
                2'b10: timer5_counter = 35'd825000000;  //F = 2HZ
                2'b11: timer5_counter = 35'd412500000;  //F = 4HZ
            endcase
        end else begin
            timer5_counter = 35'd0;
        end
        // Nút gạt trình diễn hiệu ứng 7
        if (switch_flag[6] == 1'b1) begin
            case (frequency)
                2'b00: timer6_counter = 35'd3400000000; //F = 0,5HZ
                2'b01: timer6_counter = 35'd1700000000; //F = 1HZ
                2'b10: timer6_counter = 35'd850000000;  //F = 2HZ
                2'b11: timer6_counter = 35'd425000000;  //F = 4HZ
            endcase
        end else begin
            timer6_counter = 35'd0;
        end
    end

    /**************************************************************************/
    // Gọi các module con:
    // Nút nhấn chuyển hiệu ứng
    button EFFECT_NEXT (.clk(clk), .rst(rst), .btn(button2), .debounced(eff_btn_flag));
    // Nút nhấn thay đổi tần số
    button FREQUENCY_NEXT (.clk(clk), .rst(rst), .btn(button3), .debounced(fre_btn_flag));
    // Nút nhấn chỉ trình diễn 1 hiệu ứng
    button STOP (.clk(clk), .rst(rst), .btn(button4), .debounced(stop_btn_flag));
    // Các nút gạt trình diễn hiệu ứng
    switch S0 (.clk(clk), .switch(switch[0]), .debounced(switch_flag[0]));
    switch S1 (.clk(clk), .switch(switch[1]), .debounced(switch_flag[1]));
    switch S2 (.clk(clk), .switch(switch[2]), .debounced(switch_flag[2]));
    switch S3 (.clk(clk), .switch(switch[3]), .debounced(switch_flag[3]));
    switch S4 (.clk(clk), .switch(switch[4]), .debounced(switch_flag[4]));
    switch S5 (.clk(clk), .switch(switch[5]), .debounced(switch_flag[5]));
    switch S6 (.clk(clk), .switch(switch[6]), .debounced(switch_flag[6]));
    // Các module con cho trình diễn hiệu ứng
    effect0 E0 (.clk(clk), .trans(trans_0), .led7seg(led7seg_0), .enable(ENABLE), .frequency(frequency), .check(check), .text_index(text_index));
    effect1 E1 (.clk(clk), .trans(trans_1), .led7seg(led7seg_1), .enable(ENABLE), .frequency(frequency), .check(check), .text_index(text_index));
    effect2 E2 (.clk(clk), .trans(trans_2), .led7seg(led7seg_2), .enable(ENABLE), .frequency(frequency), .check(check), .text_index(text_index));
    effect3 E3 (.clk(clk), .trans(trans_3), .led7seg(led7seg_3), .enable(ENABLE), .frequency(frequency), .check(check), .text_index(text_index));
    effect4 E4 (.clk(clk), .trans(trans_4), .led7seg(led7seg_4), .enable(ENABLE), .frequency(frequency), .check(check), .text_index(text_index));
    effect5 E5 (.clk(clk), .trans(trans_5), .led7seg(led7seg_5), .enable(ENABLE), .frequency(frequency), .check(check), .text_index(text_index));
    effect6 E6 (.clk(clk), .trans(trans_6), .led7seg(led7seg_6), .enable(ENABLE), .frequency(frequency), .check(check), .text_index(text_index));
    // Module con cho mode = 1: Cho phép người dùng thay đổi/ thêm/ xóa ký tự
    setting SET (// Host Side
                 .clk(clk), 
                 .rst(rst), 
                 // Chế độ
                 .mode(mode),
                 // Kết nối nút nhấn
                 .button2(button2),
                 .button3(button3),
                 .button4(button4),
                 // Kết nối hiển thị LED 7 đoạn
                 .trans(trans_mode2), 
                 .led7seg(led7seg_mode2),
                 .single_led_sp(single_led_sp_mode2),
                 // Dữ liệu thay đổi ký tự
                 .check_index(check_index),
                 .index(index));
endmodule