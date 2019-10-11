set_property -dict { PACKAGE_PIN Y6  IOSTANDARD LVCMOS33 }              [get_ports { clk }];
set_property -dict { PACKAGE_PIN J22 IOSTANDARD LVCMOS33 }              [get_ports { prop_clk }];
set_property -dict { PACKAGE_PIN J21 IOSTANDARD LVCMOS33 }              [get_ports { prop_clk_locked }];
set_property -dict { PACKAGE_PIN L22 IOSTANDARD LVCMOS33 }              [get_ports { agc_clk }];
set_property -dict { PACKAGE_PIN L21 IOSTANDARD LVCMOS33 PULLUP true}   [get_ports { rst_n }];