# cocotb setup
MODULE = test
TOPLEVEL = encoder
VERILOG_SOURCES = encoder.v

include $(shell cocotb-config --makefiles)/Makefile.sim

gtkwave:
	gtkwave encoder.vcd encoder.gtkw

formal:
	sby -f properties.sby

show_encoder:
	yosys -p "read_verilog encoder.v; proc; opt; show -colors 2 -width -signed encoder"

# Blatently stole this
test_encoder:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s encoder -s dump -g2012 encoder.v dump_encoder.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
