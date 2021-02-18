# cocotb setup
MODULE = test
TOPLEVEL = debounce
VERILOG_SOURCES = debounce.v

include $(shell cocotb-config --makefiles)/Makefile.sim

gtkwave:
	gtkwave debounce.vcd debounce.gtkw

formal:
	sby -f properties.sby

show_debounce:
	yosys -p "read_verilog debounce.v; proc; opt; show -colors 2 -width -signed debounce"

# Blatently stole this
test_debounce:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s debounce -s dump -g2012 debounce.v dump_debounce.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
