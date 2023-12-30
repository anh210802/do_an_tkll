/*
    Module xử lý tín hiệu nút nhấn
*/

module button (
   input clk,
   input rst,
   input btn,
   output reg debounced
);

    reg [20:0] cnt21;
    wire en100hz;

    assign en100hz = (cnt21 == 21'd250000) ? 1'b1 : 1'b0;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            cnt21 <= 21'd0;
        end else if (en100hz) begin
            cnt21 <= 21'd0;
        end else begin
            cnt21 <= cnt21 + 21'd1;
        end
    end
    
    reg ff1, ff2;

    always @(posedge clk) begin
        if (!rst) begin
            ff1 <= 1'b0;
            ff2 <= 1'b0;
        end else if (en100hz) begin
            ff2 <= ff1;
            ff1 <= btn;
        end
    end

    wire temp = ff1 & ~ff2 & en100hz;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            debounced <= 1'b0;
        end else begin
            debounced <= temp;
        end
    end

endmodule   
