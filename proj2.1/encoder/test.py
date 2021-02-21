import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

@cocotb.test()
async def test(dut):
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    dut.reset <= 1;
    dut.a <= 0;
    dut.b <= 0;
    await ClockCycles(dut.clk, 5)
    dut.reset <= 0;
    assert dut.value == 0;


    await ClockCycles(dut.clk, 1)
    assert dut.value == 0;

    dut.a <= 1;
    await ClockCycles(dut.clk, 2)
    assert dut.value == 1;

    dut.b <= 1;
    await ClockCycles(dut.clk, 2)
    assert dut.value == 2;

    dut.a <= 0;
    await ClockCycles(dut.clk, 2)
    assert dut.value == 3;

    dut.b <= 0;
    await ClockCycles(dut.clk, 2)
    assert dut.value == 4;

    dut.a <= 1;
    await ClockCycles(dut.clk, 2)
    assert dut.value == 5;

    dut.a <= 0;
    await ClockCycles(dut.clk, 2)
    assert dut.value == 4;

    dut.b <= 1;
    await ClockCycles(dut.clk, 2)
    assert dut.value == 3;
