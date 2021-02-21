`default_nettype none

module rgbmixer(clk, reset, knoba, knobb, led);
   parameter width = 4;
   input  wire clk, reset;
   input  wire [2:0] knoba, knobb;
   output wire [2:0] led;

`ifdef COCOTB_SIM
   initial begin
      $dumpfile("rgbmixer.vcd");
      $dumpvars(0, rgbmixer);
      #1;
   end
`endif

   wire [2:0] knoba_debounced, knobb_debounced;
   wire [width-1:0] value;
   wire             error;

   debounce debouncea(clk, reset, knoba[0], knoba_debounced[0]);
   debounce debounceb(clk, reset, knobb[0], knobb_debounced[0]);
   encoder #(width) encoder(clk, reset, knoba_debounced[0], knobb_debounced[0], value, error);
   pdm #(width) pdm_inst(clk, reset, value, led[0]);
endmodule
