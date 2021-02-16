`default_nettype none

module pwm(clk, reset, level, out);
   parameter width = 8;
   input  wire             clk, reset;
   input  wire [width-1:0] level;
   output wire             out;
   reg [width-1:0] counter;

`ifdef COCOTB_SIM
   initial begin
      $dumpfile("pwm.vcd");
      $dumpvars(0, pwm);
      $display("Cocotb was here");
      #1;
   end
`endif

   assign out = reset ? 1'd 0 : counter < level;
   always @(posedge clk) counter <= reset ? 0 : counter + 1'd 1;
endmodule
