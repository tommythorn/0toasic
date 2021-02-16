import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

@cocotb.test()
async def test(dut):
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    dut.reset <= 1;
    await ClockCycles(dut.clk, 5)
    dut.reset <= 0;
    dut.level <= 33;
    await ClockCycles(dut.clk, 600)
    dut.level <= 80;
    await ClockCycles(dut.clk, 600)
    dut.level <= 255;
    await ClockCycles(dut.clk, 600)
