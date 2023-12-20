module switch (
    input clk,
    input switch,
    output reg debounced
);

    always @(posedge clk) begin
        if (switch == 1'b0) begin
            debounced <= 1'b1;
        end else begin
            debounced <= 1'b0;
        end
    end
endmodule