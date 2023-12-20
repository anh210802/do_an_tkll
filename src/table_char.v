module table_char(
    input clk,
    output reg[6:0] index,
    input wire[6:0] index_check
);

    localparam reg[6:0] text0 = 7'b1111111; //null
    localparam reg[6:0] text1 = 7'b1000000; //0
    localparam reg[6:0] text2 = 7'b1110011; //1
    localparam reg[6:0] text3 = 7'b0100100; //2
    localparam reg[6:0] text4 = 7'b0100001; //3
    localparam reg[6:0] text5 = 7'b0010011; //4
    localparam reg[6:0] text6 = 7'b0001001; //5
    localparam reg[6:0] text7 = 7'b0001000; //6
    localparam reg[6:0] text8 = 7'b1100011; //7
    localparam reg[6:0] text9 = 7'b0000000; //8
    localparam reg[6:0] text10 = 7'b0000001; //9    
    localparam reg[6:0] text11 = 7'b0000010; //A
    localparam reg[6:0] text12 = 7'b0011000; //B
    localparam reg[6:0] text13 = 7'b1001100; //C
    localparam reg[6:0] text14 = 7'b0111100; //c
    localparam reg[6:0] text15 = 7'b0110000; //d
    localparam reg[6:0] text16 = 7'b0001100; //E
    localparam reg[6:0] text17 = 7'b0001110; //F
    localparam reg[6:0] text18 = 7'b1001000; //G
    localparam reg[6:0] text19 = 7'b0010010; //H
    localparam reg[6:0] text20 = 7'b0011010; //h
    localparam reg[6:0] text21 = 7'b1011110; //I
    localparam reg[6:0] text22 = 7'b1101011; //i
    localparam reg[6:0] text23 = 7'b1110000; //J
    localparam reg[6:0] text24 = 7'b1011100; //L
    localparam reg[6:0] text25 = 7'b1000010; //N
    localparam reg[6:0] text26 = 7'b0111010; //n
    localparam reg[6:0] text27 = 7'b1000000; //O
    localparam reg[6:0] text28 = 7'b0111000; //o
    localparam reg[6:0] text29 = 7'b0000110; //P
    localparam reg[6:0] text30 = 7'b0000011; //q
    localparam reg[6:0] text31 = 7'b0111110; //r
    localparam reg[6:0] text32 = 7'b0001001; //S
    localparam reg[6:0] text33 = 7'b0011100; //t
    localparam reg[6:0] text34 = 7'b1010000; //U
    localparam reg[6:0] text35 = 7'b1111000; //u
    localparam reg[6:0] text36 = 7'b0010001; //y
    localparam reg[6:0] text37 = 7'b0100100; //Z
    localparam reg[6:0] text38 = 7'b0111111; //-
    localparam reg[6:0] text39 = 7'b0000101; //!
    localparam reg[6:0] text40 = 7'b0100101; //?
    localparam reg[6:0] text41 = 7'b1111101; //_
    localparam reg[6:0] text42 = 7'b1110111; //{'}(open)
    localparam reg[6:0] text43 = 7'b1011111; //{'}(close)
    localparam reg[6:0] text44 = 7'b0000111; //(degree)
    localparam reg[6:0] text45 = 7'b1000111; //^
    localparam reg[6:0] text46 = 7'b1001100; //{(}(open)
    localparam reg[6:0] text47 = 7'b1100001; //{)}(close)
    localparam reg[6:0] text48 = 7'b1010111; //"
    localparam reg[6:0] text49 = 7'b0111101; //=
    localparam reg[6:0] text50 = 7'b0101101; //==
    localparam reg[6:0] text51 = 7'b1111110; //. or ,

    // Charcter 2 led
    localparam reg[6:0] text52_1 = 7'b1000110; //M (left)
    localparam reg[6:0] text52_2 = 7'b1000001; //M (right)

    localparam reg[6:0] text53_1 = 7'b1011000; //W (left)
    localparam reg[6:0] text53_2 = 7'b1110000; //W (right)

    localparam reg[6:0] led0_char = 7'b0111111; //indexG
    localparam reg[6:0] led1_char = 7'b1011111; //indexF
    localparam reg[6:0] led2_char = 7'b1101111; //indexA
    localparam reg[6:0] led3_char = 7'b1110111; //indexB
    localparam reg[6:0] led4_char = 7'b1111011; //indexC
    localparam reg[6:0] led5_char = 7'b1111101; //indexD
    localparam reg[6:0] led6_char = 7'b1111110; //indexE

    always @(posedge clk) begin
        case (index_check)
            7'd0: index = text0;
            7'd1: index = text1;
            7'd2: index = text2;
            7'd3: index = text3;
            7'd4: index = text4;
            7'd5: index = text5;
            7'd6: index = text6;
            7'd7: index = text7;
            7'd8: index = text8;
            7'd9: index = text9;
            7'd10: index = text10;
            7'd11: index = text11;
            7'd12: index = text12;
            7'd13: index = text13;
            7'd14: index = text14;
            7'd15: index = text15;
            7'd16: index = text16;
            7'd17: index = text17;
            7'd18: index = text18;
            7'd19: index = text19;
            7'd20: index = text20;
            7'd21: index = text21;
            7'd22: index = text22;
            7'd23: index = text23;
            7'd24: index = text24;
            7'd25: index = text25;
            7'd26: index = text26;
            7'd27: index = text27;
            7'd28: index = text28;
            7'd29: index = text29;
            7'd30: index = text30;
            7'd31: index = text31;
            7'd32: index = text32;
            7'd33: index = text33;
            7'd34: index = text34;
            7'd35: index = text35;
            7'd36: index = text36;
            7'd37: index = text37;
            7'd38: index = text38;
            7'd39: index = text39;
            7'd40: index = text40;
            7'd41: index = text41;
            7'd42: index = text42;
            7'd43: index = text43;
            7'd44: index = text44;
            7'd45: index = text45;
            7'd46: index = text46;
            7'd47: index = text47;
            7'd48: index = text48;
            7'd49: index = text49;
            7'd50: index = text50;
            7'd51: index = text51;
            7'd52: index = text52_1;
            7'd53: index = text52_2;
            7'd54: index = text53_1;
            7'd55: index = text53_2;
            7'd56: index = led0_char;
            7'd57: index = led1_char;
            7'd58: index = led2_char;
            7'd59: index = led3_char;
            7'd60: index = led4_char;
            7'd61: index = led5_char;
            7'd62: index = led6_char;
            default: index = text0;
        endcase
    end
endmodule