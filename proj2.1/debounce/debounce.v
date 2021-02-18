`default_nettype none

/* This is not the cheapest way to debounce a signal, but it is simple */

module debounce(clk, reset, button, debounced);
   input  wire clk, reset;
   input  wire button;
   output reg debounced;
   reg [7:0] events;

`ifdef COCOTB_SIM
   initial begin
      $dumpfile("debounce.vcd");
      $dumpvars(0, debounce);
      #1;
   end
`endif

   wire all0 = events == 8 'h 00;
   wire all1 = events == 8 'h FF;
   wire pointless_mux = all1 ? 1 'b 1 : 1 'b 0;
   wire en = all0 | all1;
   always @(posedge clk) begin
     if (reset)
       events <= 0;
     else
       events <= {events[6:0],button};

     if (reset)
       debounced <= 0;
     else if (en)
       debounced <= pointless_mux;
   end
endmodule
