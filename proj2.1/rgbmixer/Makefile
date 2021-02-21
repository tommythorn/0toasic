# cocotb setup
MODULE = test
TOPLEVEL = rgbmixer
VERILOG_SOURCES = rgbmixer.v ../debounce/debounce.v ../encoder/encoder.v ../pdm/pdm.v

include $(shell cocotb-config --makefiles)/Makefile.sim

gtkwave: rgbmixer.vcd
	gtkwave rgbmixer.vcd rgbmixer.gtkw

formal:
	sby -f properties.sby

show_rgbmixer:
	yosys -p "read_verilog rgbmixer.v ../debounce/debounce.v ../encoder/encoder.v ../pdm/pdm.v; proc; opt; show -colors 2 -width -signed rgbmixer"

# Blatently stole this
test_rgbmixer:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s rgbmixer -s dump -g2012 rgbmixer.v dump_rgbmixer.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
