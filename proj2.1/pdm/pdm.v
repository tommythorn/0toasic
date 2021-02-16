`default_nettype none

module pdm(clk, reset, level, out);

   parameter width = 8;  /* The resolution in bits */


   input     wire             clk;
   input     wire             reset;
   input     wire [width-1:0] level;
   output    wire             out;

`ifdef COCOTB_SIM
   initial begin
      $dumpfile("pdm.vcd");
      $dumpvars(0, pdm);
      $display("Cocotb was here");
      #1;
   end
`endif

   /*
    * A completely ridiculous side project.  Pulse Density Modulation
    * for controlling led intensity.  The theory is pretty simple:
    * given a desired target level 0 <= T <= 1, control the output out
    * in {1,0}, such that out on on average is T.  Do this by
    * integrating the error T - out over time and switching out such that
    * the sum of (T - out) is finite.
    *
    * S = 0, out = 0
    * forever
    *   S = S + (T - out)
    *   if (S >= 0)
    *      out = 1
    *   else
    *      out = 0
    *
    * Check: T=0, out is never turned on; T=1, out is always on; T=0.5, out toggles
    *
    * In fixed point arithmetic this becomes even simpler (assume width-bit arith)
    * S = Sf * 2^width = Sf << width.  As |S| <= 1, width+2 bits is sufficient
    *
    * S = 0, out = 0
    * forever
    *   D = T + (~out + 1) << width === T + (out << width) + (out << (width+1))
    *   S = S + D
    *   out = 1 & ~(S >> (width+1))
    */

   reg [width+1:0] sigma = 0;
   assign out = ~sigma[width+1];
   always @(posedge clk) sigma <= reset ? -1 : sigma + {out,out,level};
endmodule
