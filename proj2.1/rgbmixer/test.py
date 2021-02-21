import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

@cocotb.test()
async def test(dut):
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    dut.reset <= 1;
    dut.knoba <= 0;
    dut.knobb <= 0;
    await ClockCycles(dut.clk, 5)
    dut.reset <= 0;
    assert dut.value == 0;


    await ClockCycles(dut.clk, 100)
    assert dut.value == 0;

    dut.knoba[0] <= 1;
    await ClockCycles(dut.clk, 200)
    assert dut.value == 1;

    dut.knobb[0] <= 1;
    await ClockCycles(dut.clk, 200)
    assert dut.value == 2;

    dut.knoba[0] <= 0;
    await ClockCycles(dut.clk, 200)
    assert dut.value == 3;

    dut.knobb[0] <= 0;
    await ClockCycles(dut.clk, 200)
    assert dut.value == 4;

    dut.knoba[0] <= 1;
    await ClockCycles(dut.clk, 200)
    assert dut.value == 5;

    dut.knoba[0] <= 0;
    await ClockCycles(dut.clk, 200)
    assert dut.value == 4;

    dut.knobb[0] <= 1;
    await ClockCycles(dut.clk, 200)
    assert dut.value == 3;
