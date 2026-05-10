transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/axis_infrastructure_v1_1_1
vlib riviera/axis_data_fifo_v2_0_11
vlib riviera/xil_defaultlib

vmap xilinx_vip riviera/xilinx_vip
vmap axis_infrastructure_v1_1_1 riviera/axis_infrastructure_v1_1_1
vmap axis_data_fifo_v2_0_11 riviera/axis_data_fifo_v2_0_11
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xilinx_vip  -incr -l axi_vip_v1_1_15 "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l axis_infrastructure_v1_1_1 -l axis_data_fifo_v2_0_11 -l xil_defaultlib \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work axis_infrastructure_v1_1_1  -incr -v2k5 "+incdir+../../../ipstatic/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l axis_infrastructure_v1_1_1 -l axis_data_fifo_v2_0_11 -l xil_defaultlib \
"../../../ipstatic/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_data_fifo_v2_0_11  -incr -v2k5 "+incdir+../../../ipstatic/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l axis_infrastructure_v1_1_1 -l axis_data_fifo_v2_0_11 -l xil_defaultlib \
"../../../ipstatic/hdl/axis_data_fifo_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../ipstatic/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l axis_infrastructure_v1_1_1 -l axis_data_fifo_v2_0_11 -l xil_defaultlib \
"../../../../FireWall_ver_4.gen/sources_1/ip/axis_data_fifo_0/sim/axis_data_fifo_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

