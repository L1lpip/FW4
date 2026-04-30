transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/lib_pkg_v1_0_3
vlib riviera/axi_apb_bridge_v3_0_19
vlib riviera/xil_defaultlib
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_15

vmap xilinx_vip riviera/xilinx_vip
vmap lib_pkg_v1_0_3 riviera/lib_pkg_v1_0_3
vmap axi_apb_bridge_v3_0_19 riviera/axi_apb_bridge_v3_0_19
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_15 riviera/axi_vip_v1_1_15

vlog -work xilinx_vip  -incr "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l lib_pkg_v1_0_3 -l axi_apb_bridge_v3_0_19 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/Vivado/2023.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vcom -work lib_pkg_v1_0_3 -93  -incr \
"../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/56d9/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work axi_apb_bridge_v3_0_19 -93  -incr \
"../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/41ea/hdl/axi_apb_bridge_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_axi_apb_bridge_0_0/sim/design_1_axi_apb_bridge_0_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l lib_pkg_v1_0_3 -l axi_apb_bridge_v3_0_19 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 \
"../../../bd/design_1/ip/design_1_Fire_wall_top_0_0/sim/design_1_Fire_wall_top_0_0.v" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l lib_pkg_v1_0_3 -l axi_apb_bridge_v3_0_19 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 \
"../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l lib_pkg_v1_0_3 -l axi_apb_bridge_v3_0_19 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 \
"../../../bd/design_1/ip/design_1_axi_vip_0_0/sim/design_1_axi_vip_0_0_pkg.sv" \

vlog -work axi_vip_v1_1_15  -incr "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l lib_pkg_v1_0_3 -l axi_apb_bridge_v3_0_19 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 \
"../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/5753/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l lib_pkg_v1_0_3 -l axi_apb_bridge_v3_0_19 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 \
"../../../bd/design_1/ip/design_1_axi_vip_0_0/sim/design_1_axi_vip_0_0.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../FireWall_ver_4.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/opt/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l lib_pkg_v1_0_3 -l axi_apb_bridge_v3_0_19 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

