vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/lib_pkg_v1_0_3
vlib modelsim_lib/msim/axi_apb_bridge_v3_0_19
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_15

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap lib_pkg_v1_0_3 modelsim_lib/msim/lib_pkg_v1_0_3
vmap axi_apb_bridge_v3_0_19 modelsim_lib/msim/axi_apb_bridge_v3_0_19
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_15 modelsim_lib/msim/axi_vip_v1_1_15

vlog -work xilinx_vip -64 -incr -mfcu  -sv -L axi_vip_v1_1_15 -L xilinx_vip "+incdir+/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/include" \
"/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vcom -work lib_pkg_v1_0_3 -64 -93  \
"../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/56d9/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work axi_apb_bridge_v3_0_19 -64 -93  \
"../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/41ea/hdl/axi_apb_bridge_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/design_1/ip/design_1_axi_apb_bridge_0_0/sim/design_1_axi_apb_bridge_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_Fire_wall_top_0_0/sim/design_1_Fire_wall_top_0_0.v" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr -mfcu  "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/include" \
"../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_15 -L xilinx_vip "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_vip_0_0/sim/design_1_axi_vip_0_0_pkg.sv" \

vlog -work axi_vip_v1_1_15 -64 -incr -mfcu  -sv -L axi_vip_v1_1_15 -L xilinx_vip "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/include" \
"../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/5753/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_15 -L xilinx_vip "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_vip_0_0/sim/design_1_axi_vip_0_0.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/include" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

