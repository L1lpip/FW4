transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xilinx_vip
vlib activehdl/axis_infrastructure_v1_1_1
vlib activehdl/axis_data_fifo_v2_0_11
vlib activehdl/xil_defaultlib

vmap xilinx_vip activehdl/xilinx_vip
vmap axis_infrastructure_v1_1_1 activehdl/axis_infrastructure_v1_1_1
vmap axis_data_fifo_v2_0_11 activehdl/axis_data_fifo_v2_0_11
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xilinx_vip  -sv2k12 "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l axis_infrastructure_v1_1_1 -l axis_data_fifo_v2_0_11 -l xil_defaultlib \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work axis_infrastructure_v1_1_1  -v2k5 "+incdir+../../../ipstatic/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l axis_infrastructure_v1_1_1 -l axis_data_fifo_v2_0_11 -l xil_defaultlib \
"../../../ipstatic/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_data_fifo_v2_0_11  -v2k5 "+incdir+../../../ipstatic/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l axis_infrastructure_v1_1_1 -l axis_data_fifo_v2_0_11 -l xil_defaultlib \
"../../../ipstatic/hdl/axis_data_fifo_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l axis_infrastructure_v1_1_1 -l axis_data_fifo_v2_0_11 -l xil_defaultlib \
"../../../../FireWall_ver_4.gen/sources_1/ip/axis_data_fifo_0/sim/axis_data_fifo_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

