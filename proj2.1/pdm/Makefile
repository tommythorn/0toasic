# cocotb setup
MODULE = test
TOPLEVEL = pdm
VERILOG_SOURCES = pdm.v

include $(shell cocotb-config --makefiles)/Makefile.sim

gtkwave:
	gtkwave pdm.vcd pdm.gtkw

formal:
	sby -f properties.sby

show_pdm:
	yosys -p "read_verilog pdm.v; proc; opt; show -colors 2 -width -signed pdm"
