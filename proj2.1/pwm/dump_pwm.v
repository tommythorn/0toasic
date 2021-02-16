// Yes, I stole this also.  I have no shame.
`timescale 1ns/10ps
module dump();
    initial begin
        $dumpfile ("pwm.vcd");
        $dumpvars (0, pwm);
        #1;
    end
endmodule
