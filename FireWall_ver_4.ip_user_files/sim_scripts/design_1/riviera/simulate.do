transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+design_1  -L xilinx_vip -L lib_pkg_v1_0_3 -L axi_apb_bridge_v3_0_19 -L xil_defaultlib -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_15 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.design_1 xil_defaultlib.glbl

do {design_1.udo}

run 1000ns

endsim

quit -force
