/*
        ĐỒ ÁN THIẾT KẾ LUẬN LÝ - HK 231

    HỆ THỐNG TRANG TRÍ SỬ DỤNG LED 7 ĐOẠN

        Sử dụng ngôn ngữ đặc tả phần cứng verilog để thiết kế mạch

        Coder:  Lê Xuân Anh - 2012592
                Phan Ngọc Trâm - 2014815 

        Tháng 12/2023

*/

module main (
    //Host Side
    input CLK, 
    input RST,
    // Kết nối button
    input BUTTON1, BUTTON2, BUTTON3, BUTTON4,
    // Kết nối Switch
    input [6:0] SWITCH,
    // Kết nối hiển thị LED 7 đoạn    
    output reg[6:0] TRANS, 
    output reg[6:0] LED7SEG,
    // Kết nối LED đơn
    output reg[1:0] LED_MODE,
    output reg[6:0] SINGLE_LED_SP
);
    
    wire[6:0] cTRANS; // Khai báo biến truyền module cho transistor
    wire[6:0] cLED7SEG; // Khai báo biến truyền module cho LED 7 đoạn
    wire button1_flag; // Khai báo cờ cho button 1

    // Khai báo biến lưu trữ dữ liệu
    reg MODE; 
    reg state_single_led_mode;
    reg[27:0] counter;

    ///////////////////////////////////////////////
    // Liên kết với các biến hiển thị led 7 đoạn
    assign TRANS = cTRANS;
    assign LED7SEG = cLED7SEG;
     /////////////////////////////////////////////

    /* 
        Thay đổi trạng thái khi nhấn nút button1
        Trạng thái 0: LED ở trạng thái trình diễn
        Trạng thái 1: LED ở trạng thái cho người dùng chỉnh sửa, thêm bớt ký tự
    */
    always @(posedge CLK) begin
        if (button1_flag == 1'b1) begin
            MODE = ~MODE;
        end 
    end
    
    // Điều chỉnh LED đơn hỗ trợ thông báo trạng thái của hệ thống
    always @(posedge CLK) begin
        if (counter >= 28'd12500000) begin
            counter <= 28'd0;
            state_single_led_mode <= ~state_single_led_mode;
        end
        else begin
            counter <= counter + 28'd1;
        end
        // Trạng thái 0: LED xanh nhấp nháy với tần số 2Hz
        // Trạng thái 1: LED vàng nhấp nháy với tần số 2Hz
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

    ///////////////////////////////////////////////////////////////////////

    // Gọi module controller để điều kiển
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

    // Gọi module xử lý tín hiệu nút nhấn
    button CHANGE_MODE (.clk(CLK), .rst(RST), .btn(BUTTON1), .debounced(button1_flag));
     

endmodule