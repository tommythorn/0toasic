import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

@cocotb.test()
async def test(dut):
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    dut.button <= 1;
    dut.reset <= 1;
    await ClockCycles(dut.clk, 5)
    dut.reset <= 0;
    assert dut.debounced == 0;


    # Capturing exactly when it transitions in the test bench is
    # haunted by edge conditions.  AFAICT, because the way the
    # simulation is set up, it takes a cycle to see the effect of the
    # reset
    await ClockCycles(dut.clk, 1)

    # DEBUG: Now we see an event shifted in
    await ClockCycles(dut.clk, 1)
    assert dut.events == 1;

    # DEBUG: then another 7 to fill the register
    await ClockCycles(dut.clk, 7)
    assert dut.events == 255;

    # Finally, one more transition to reach the output FF
    await ClockCycles(dut.clk, 1)
    assert dut.debounced == 1;

    # Let's check that it doesn't change right away
    dut.button <= 0;
    await ClockCycles(dut.clk, 7)
    assert dut.debounced == 1;

    # but eventually does
    await ClockCycles(dut.clk, 7)
    assert dut.debounced == 0;
