# cocotb setup
MODULE = test
TOPLEVEL = pwm
VERILOG_SOURCES = pwm.v

include $(shell cocotb-config --makefiles)/Makefile.sim

gtkwave:
	gtkwave pwm.vcd pwm.gtkw

formal:
	sby -f properties.sby

show_pwm:
	yosys -p "read_verilog pwm.v; proc; opt; show -colors 2 -width -signed pwm"

# Blatently stole this
test_pwm:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s pwm -s dump -g2012 pwm.v dump_pwm.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
