-makelib xcelium_lib/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../agc_clock.srcs/sources_1/ip/prop_clock_divisor/prop_clock_divisor_clk_wiz.v" \
  "../../../../agc_clock.srcs/sources_1/ip/prop_clock_divisor/prop_clock_divisor.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

