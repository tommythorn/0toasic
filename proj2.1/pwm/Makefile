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
