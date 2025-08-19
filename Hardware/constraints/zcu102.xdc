set_property PACKAGE_PIN C7 [get_ports gt_ref_clk_0_clk_n]
set_property PACKAGE_PIN C8 [get_ports gt_ref_clk_0_clk_p]

set_property LOC GTHE4_CHANNEL_X1Y15 [get_cells {usxgmii_only_i/usxgmii/usxgmii_0/inst/i_usxgmii_only_usxgmii_0_0_gt/inst/gen_gtwizard_gthe4_top.usxgmii_only_usxgmii_0_0_gt_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_channel_container[1].gen_enabled_channel.gthe4_channel_wrapper_inst/channel_inst/gthe4_channel_gen.gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]
#set_property PACKAGE_PIN A4 [get_ports gt_rx_0_gt_port_0_p]
#set_property PACKAGE_PIN A3 [get_ports gt_rx_0_gt_port_0_n]
#set_property PACKAGE_PIN A8 [get_ports gt_tx_0_gt_port_0_p]
set_property PACKAGE_PIN E4 [get_ports gt_tx_0_gt_port_0_p]

create_clock -period 6.400 [get_ports gt_ref_clk_0_clk_p]

#create_clock -name clk_pl_0 -period 8.000 [get_pins "PS8_i/PLCLK[0]"]
#create_clock -name clk_pl_1 -period 10.000 [get_pins "PS8_i/PLCLK[1]"]
#set_property PACKAGE_PIN AL8 [get_ports user_si570_sysclk_clk_p]
#create_clock -period 3.333 [get_ports user_si570_sysclk_clk_p]


#create_clock -period 3.200 [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]]
#create_clock -period 3.200 [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]]

#================================================== USXGMII related constraints ===================================================
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks clk_pl_0] 3.200
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks clk_pl_0] 3.200
set_max_delay -datapath_only -from [get_clocks clk_pl_0] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] 3.200
set_max_delay -datapath_only -from [get_clocks clk_pl_0] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] 3.200

set_property PACKAGE_PIN A12 [get_ports {SFP_TX_DIS[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SFP_TX_DIS[0]}]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports user_si570_sysclk_clk_p]
set_property PACKAGE_PIN AL8 [get_ports user_si570_sysclk_clk_p]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
