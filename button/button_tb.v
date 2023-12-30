module button_tb;

   reg clk;
   reg rst;
   reg btn;
   wire debounced;

   button dut (
      .clk(clk),
      .rst(rst),
      .btn(btn),
      .debounced(debounced)
   );

   always #5 clk = ~clk;

   initial begin
      clk = 0;
      rst = 1;
      btn = 0;

      #10 rst = 0; // Deassert reset
      #20 btn = 1; // Simulate button press
      #100 btn = 0; // Simulate button release
      #200 btn = 1; // Simulate button press again

      #500 $finish; // End simulation
   end

endmodule