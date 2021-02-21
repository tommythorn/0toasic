// Yes, I stole this also.  I have no shame.
`timescale 1ns/10ps
module dump();
    initial begin
        $dumpfile ("rgbmixer.vcd");
        $dumpvars (0, rgbmixer);
        #1;
    end
endmodule
