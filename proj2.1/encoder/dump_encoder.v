// Yes, I stole this also.  I have no shame.
`timescale 1ns/10ps
module dump();
    initial begin
        $dumpfile ("encoder.vcd");
        $dumpvars (0, encoder);
        #1;
    end
endmodule
