# create modelsim working library
vlib work

set src ../../verilog/*.sv
set tb  ../../testbench/*.sv

# compile all the Verilog sources
vlog $src $tb

# open the testbench module for simulation
#
vsim work.operation_testbench
#
#add wave -recursive *
add wave /operation_testbench/*
add wave /operation_testbench/dut/A
add wave /operation_testbench/dut/B
add wave /operation_testbench/C
add wave /operation_testbench/C_out
add wave /operation_testbench/dut_1/state
add wave /operation_testbench/dut_1/next_state

# run the simulation
run -all

# expand the signals time diagram
wave zoom full