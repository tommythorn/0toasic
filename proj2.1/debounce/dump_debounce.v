// Yes, I stole this also.  I have no shame.
`timescale 1ns/10ps
module dump();
    initial begin
        $dumpfile ("debounce.vcd");
        $dumpvars (0, debounce);
        #1;
    end
endmodule