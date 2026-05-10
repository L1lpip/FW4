vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/axis_infrastructure_v1_1_1
vlib questa_lib/msim/axis_data_fifo_v2_0_11
vlib questa_lib/msim/xil_defaultlib

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap axis_infrastructure_v1_1_1 questa_lib/msim/axis_infrastructure_v1_1_1
vmap axis_data_fifo_v2_0_11 questa_lib/msim/axis_data_fifo_v2_0_11
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xilinx_vip -64 -incr -mfcu  -sv -L axi_vip_v1_1_15 -L xilinx_vip "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work axis_infrastructure_v1_1_1 -64 -incr -mfcu  "+incdir+../../../ipstatic/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" \
"../../../ipstatic/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_data_fifo_v2_0_11 -64 -incr -mfcu  "+incdir+../../../ipstatic/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" \
"../../../ipstatic/hdl/axis_data_fifo_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../ipstatic/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" \
"../../../../FireWall_ver_4.gen/sources_1/ip/axis_data_fifo_0/sim/axis_data_fifo_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

