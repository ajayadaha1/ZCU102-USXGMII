
################################################################
# This is a generated script based on design: usxgmii_only
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2024.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   if { [string compare $scripts_vivado_version $current_vivado_version] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2042 -severity "ERROR" " This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Sourcing the script failed since it was created with a future version of Vivado."}

   } else {
     catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   }

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source usxgmii_only_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu9eg-ffvb1156-2-e
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name pl_eth_usxgmii

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir ./bd

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2030 -severity "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_gid_msg -ssname BD::TCL -id 2031 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_gid_msg -ssname BD::TCL -id 2032 -severity "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2033 -severity "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2034 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files -quiet */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2035 -severity "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_gid_msg -ssname BD::TCL -id 2036 -severity "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2037 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_gid_msg -ssname BD::TCL -id 2038 -severity "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:zynq_ultra_ps_e:3.5\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:usxgmii:1.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:system_ila:1.1\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: usxgmii
proc create_hier_cell_usxgmii { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_usxgmii() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 gt_ref_clk_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_usxgmii:gt_ports:2.0 gt_tx_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_usxgmii:gt_ports:2.0 gt_rx_0


  # Create pins
  create_bd_pin -dir O -type intr mcdma_tx_introut
  create_bd_pin -dir O -type intr mcdma_rx_introut
  create_bd_pin -dir I -type rst ext_reset_in_0
  create_bd_pin -dir I -type clk dclk_0
  create_bd_pin -dir O -from 0 -to 0 dout_0

  # Create instance: tx_rst_n, and set properties
  set tx_rst_n [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 tx_rst_n ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $tx_rst_n


  # Create instance: axis_10g0_tx_fifo, and set properties
  set axis_10g0_tx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_10g0_tx_fifo ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {4096} \
    CONFIG.FIFO_MODE {2} \
  ] $axis_10g0_tx_fifo


  # Create instance: rx_rst_n, and set properties
  set rx_rst_n [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 rx_rst_n ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $rx_rst_n


  # Create instance: axi_dma_0, and set properties
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [list \
    CONFIG.c_include_mm2s_dre {1} \
    CONFIG.c_include_s2mm_dre {1} \
    CONFIG.c_m_axi_mm2s_data_width {64} \
    CONFIG.c_m_axis_mm2s_tdata_width {32} \
    CONFIG.c_mm2s_burst_size {64} \
    CONFIG.c_s2mm_burst_size {8} \
    CONFIG.c_sg_include_stscntrl_strm {0} \
    CONFIG.c_sg_length_width {16} \
  ] $axi_dma_0


  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property CONFIG.CONST_VAL {0} $xlconstant_0


  # Create instance: usxgmii_0, and set properties
  set usxgmii_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:usxgmii:1.2 usxgmii_0 ]
  set_property -dict [list \
    CONFIG.ADD_GT_CNTRL_STS_PORTS {0} \
    CONFIG.GT_GROUP_SELECT {Quad_X0Y1} \
    CONFIG.GT_LOCATION {1} \
    CONFIG.GT_REF_CLK_FREQ {156.25} \
    CONFIG.INCLUDE_AXI4_INTERFACE {1} \
    CONFIG.INCLUDE_SHARED_LOGIC {1} \
    CONFIG.INCLUDE_STATISTICS_COUNTERS {1} \
    CONFIG.LANE1_GT_LOC {X0Y4} \
  ] $usxgmii_0


  # Create instance: axis_10g0_rx_fifo, and set properties
  set axis_10g0_rx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_10g0_rx_fifo ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {4096} \
    CONFIG.FIFO_MODE {2} \
  ] $axis_10g0_rx_fifo


  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {1} \
    CONFIG.CONST_WIDTH {1} \
  ] $xlconstant_1


  # Create instance: util_vector_logic_2, and set properties
  set util_vector_logic_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_2 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_2


  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {56} \
  ] $xlconstant_2


  # Create instance: util_vector_logic_4, and set properties
  set util_vector_logic_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_4 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_4


  # Create instance: util_vector_logic_5, and set properties
  set util_vector_logic_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_5 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_5


  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [list \
    CONFIG.M00_HAS_DATA_FIFO {2} \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {3} \
  ] $axi_interconnect_0


  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [list \
    CONFIG.C_MON_TYPE {NATIVE} \
    CONFIG.C_NUM_MONITOR_SLOTS {2} \
    CONFIG.C_NUM_OF_PROBES {2} \
  ] $system_ila_0


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins usxgmii_0/gt_ref_clk] [get_bd_intf_pins gt_ref_clk_0]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins M00_AXI_0]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins S_AXI_LITE_0]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins usxgmii_0/gt_tx] [get_bd_intf_pins gt_tx_0]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins usxgmii_0/gt_rx] [get_bd_intf_pins gt_rx_0]
  connect_bd_intf_net -intf_net S01_AXI_2 [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net S02_AXI_1 [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_0/S02_AXI]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_10g0_tx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_SG [get_bd_intf_pins axi_dma_0/M_AXI_SG] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins usxgmii_0/s_axi_0]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins axi_interconnect_1/M01_AXI] [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axis_10g0_tx_fifo_M_AXIS [get_bd_intf_pins axis_10g0_tx_fifo/M_AXIS] [get_bd_intf_pins usxgmii_0/axis_tx_0]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM] [get_bd_intf_pins axis_10g0_rx_fifo/M_AXIS]
  connect_bd_intf_net -intf_net usxgmii_0_axis_rx_0 [get_bd_intf_pins axis_10g0_rx_fifo/S_AXIS] [get_bd_intf_pins usxgmii_0/axis_rx_0]

  # Create port connections
  connect_bd_net -net axi_dma_0_mm2s_introut  [get_bd_pins axi_dma_0/mm2s_introut] \
  [get_bd_pins mcdma_tx_introut]
  connect_bd_net -net axi_dma_0_mm2s_prmry_reset_out_n  [get_bd_pins axi_dma_0/mm2s_prmry_reset_out_n] \
  [get_bd_pins util_vector_logic_4/Op1]
  connect_bd_net -net axi_dma_0_s2mm_introut  [get_bd_pins axi_dma_0/s2mm_introut] \
  [get_bd_pins mcdma_rx_introut]
  connect_bd_net -net axi_dma_0_s2mm_prmry_reset_out_n  [get_bd_pins axi_dma_0/s2mm_prmry_reset_out_n] \
  [get_bd_pins util_vector_logic_2/Op1]
  connect_bd_net -net dclk_0_1  [get_bd_pins dclk_0] \
  [get_bd_pins axi_dma_0/s_axi_lite_aclk] \
  [get_bd_pins axi_dma_0/m_axi_sg_aclk] \
  [get_bd_pins axi_interconnect_0/ACLK] \
  [get_bd_pins axi_interconnect_0/S00_ACLK] \
  [get_bd_pins axi_interconnect_0/M00_ACLK] \
  [get_bd_pins axi_interconnect_1/ACLK] \
  [get_bd_pins axi_interconnect_1/S00_ACLK] \
  [get_bd_pins axi_interconnect_1/M00_ACLK] \
  [get_bd_pins axi_interconnect_1/M01_ACLK] \
  [get_bd_pins proc_sys_reset_1/slowest_sync_clk] \
  [get_bd_pins usxgmii_0/dclk] \
  [get_bd_pins usxgmii_0/s_axi_aclk_0] \
  [get_bd_pins system_ila_0/clk]
  connect_bd_net -net ext_reset_in_0_1  [get_bd_pins ext_reset_in_0] \
  [get_bd_pins proc_sys_reset_1/ext_reset_in] \
  [get_bd_pins util_vector_logic_5/Op1]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn  [get_bd_pins proc_sys_reset_1/interconnect_aresetn] \
  [get_bd_pins axi_dma_0/axi_resetn] \
  [get_bd_pins axi_interconnect_0/ARESETN] \
  [get_bd_pins axi_interconnect_0/S00_ARESETN] \
  [get_bd_pins axi_interconnect_0/M00_ARESETN] \
  [get_bd_pins axi_interconnect_1/ARESETN] \
  [get_bd_pins axi_interconnect_1/S00_ARESETN] \
  [get_bd_pins axi_interconnect_1/M00_ARESETN] \
  [get_bd_pins axi_interconnect_1/M01_ARESETN]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn  [get_bd_pins proc_sys_reset_1/peripheral_aresetn] \
  [get_bd_pins usxgmii_0/s_axi_aresetn_0]
  connect_bd_net -net proc_sys_reset_1_peripheral_reset  [get_bd_pins proc_sys_reset_1/peripheral_reset] \
  [get_bd_pins usxgmii_0/sys_reset]
  connect_bd_net -net usxgmii_0_gtpowergood_out_0  [get_bd_pins usxgmii_0/gtpowergood_out_0] \
  [get_bd_pins system_ila_0/probe1]
  connect_bd_net -net usxgmii_0_stat_rx_block_lock_0  [get_bd_pins usxgmii_0/stat_rx_block_lock_0] \
  [get_bd_pins system_ila_0/probe0]
  connect_bd_net -net usxgmii_0_user_rx_reset_0  [get_bd_pins usxgmii_0/user_rx_reset_0] \
  [get_bd_pins rx_rst_n/Op1]
  connect_bd_net -net usxgmii_0_user_tx_reset_0  [get_bd_pins usxgmii_0/user_tx_reset_0] \
  [get_bd_pins tx_rst_n/Op1]
  connect_bd_net -net util_vector_logic_0_Res1  [get_bd_pins util_vector_logic_2/Res] \
  [get_bd_pins usxgmii_0/rx_reset_0]
  connect_bd_net -net util_vector_logic_1_Res1  [get_bd_pins util_vector_logic_4/Res] \
  [get_bd_pins usxgmii_0/tx_reset_0]
  connect_bd_net -net util_vector_logic_2_Res  [get_bd_pins tx_rst_n/Res] \
  [get_bd_pins axi_interconnect_0/S01_ARESETN] \
  [get_bd_pins axis_10g0_tx_fifo/s_axis_aresetn]
  connect_bd_net -net util_vector_logic_3_Res1  [get_bd_pins rx_rst_n/Res] \
  [get_bd_pins axi_interconnect_0/S02_ARESETN] \
  [get_bd_pins axis_10g0_rx_fifo/s_axis_aresetn]
  connect_bd_net -net util_vector_logic_5_Res  [get_bd_pins util_vector_logic_5/Res] \
  [get_bd_pins usxgmii_0/gtwiz_reset_tx_datapath_0] \
  [get_bd_pins usxgmii_0/gtwiz_reset_rx_datapath_0]
  connect_bd_net -net xlconstant_0_dout1  [get_bd_pins xlconstant_0/dout] \
  [get_bd_pins usxgmii_0/ctl_tx_send_rfi_0] \
  [get_bd_pins usxgmii_0/ctl_tx_send_lfi_0] \
  [get_bd_pins usxgmii_0/ctl_tx_send_idle_0] \
  [get_bd_pins usxgmii_0/ctl_tx_send_umii_lfi_0] \
  [get_bd_pins usxgmii_0/ctl_tx_send_umii_rfi_0]
  connect_bd_net -net xlconstant_1_dout  [get_bd_pins xlconstant_1/dout] \
  [get_bd_pins dout_0]
  connect_bd_net -net xlconstant_2_dout  [get_bd_pins xlconstant_2/dout] \
  [get_bd_pins usxgmii_0/tx_preamblein_0]
  connect_bd_net -net xxv_ethernet_0_rx_clk_out_0  [get_bd_pins usxgmii_0/rx_clk_out_0] \
  [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] \
  [get_bd_pins axi_interconnect_0/S02_ACLK] \
  [get_bd_pins axis_10g0_rx_fifo/s_axis_aclk] \
  [get_bd_pins usxgmii_0/rx_core_clk_0]
  connect_bd_net -net xxv_ethernet_0_tx_clk_out_0  [get_bd_pins usxgmii_0/tx_clk_out_0] \
  [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] \
  [get_bd_pins axi_interconnect_0/S01_ACLK] \
  [get_bd_pins axis_10g0_tx_fifo/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set gt_ref_clk_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 gt_ref_clk_0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $gt_ref_clk_0

  set gt_rx_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_usxgmii:gt_ports:2.0 gt_rx_0 ]

  set gt_tx_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_usxgmii:gt_ports:2.0 gt_tx_0 ]


  # Create ports
  set SFP_TX_DIS [ create_bd_port -dir O -from 0 -to 0 SFP_TX_DIS ]

  # Create instance: usxgmii
  create_hier_cell_usxgmii [current_bd_instance .] usxgmii

  # Create instance: zusp_ps, and set properties
  set zusp_ps [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.5 zusp_ps ]
  set_property -dict [list \
    CONFIG.CAN0_BOARD_INTERFACE {custom} \
    CONFIG.CAN1_BOARD_INTERFACE {custom} \
    CONFIG.CSU_BOARD_INTERFACE {custom} \
    CONFIG.DP_BOARD_INTERFACE {custom} \
    CONFIG.GEM0_BOARD_INTERFACE {custom} \
    CONFIG.GEM1_BOARD_INTERFACE {custom} \
    CONFIG.GEM2_BOARD_INTERFACE {custom} \
    CONFIG.GEM3_BOARD_INTERFACE {custom} \
    CONFIG.GPIO_BOARD_INTERFACE {custom} \
    CONFIG.IIC0_BOARD_INTERFACE {custom} \
    CONFIG.IIC1_BOARD_INTERFACE {custom} \
    CONFIG.NAND_BOARD_INTERFACE {custom} \
    CONFIG.PCIE_BOARD_INTERFACE {custom} \
    CONFIG.PJTAG_BOARD_INTERFACE {custom} \
    CONFIG.PMU_BOARD_INTERFACE {custom} \
    CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS33} \
    CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS33} \
    CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS33} \
    CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS33} \
    CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
    CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
    CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
    CONFIG.PSU_DYNAMIC_DDR_CONFIG_EN {0} \
    CONFIG.PSU_IMPORT_BOARD_PRESET {} \
    CONFIG.PSU_MIO_0_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_0_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_10_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_10_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_10_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_10_SLEW {slow} \
    CONFIG.PSU_MIO_11_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_11_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_11_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_11_SLEW {slow} \
    CONFIG.PSU_MIO_12_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_12_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_12_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_12_SLEW {slow} \
    CONFIG.PSU_MIO_13_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_13_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_13_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_13_SLEW {slow} \
    CONFIG.PSU_MIO_14_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_14_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_14_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_14_SLEW {slow} \
    CONFIG.PSU_MIO_15_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_15_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_15_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_15_SLEW {slow} \
    CONFIG.PSU_MIO_16_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_16_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_16_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_16_SLEW {slow} \
    CONFIG.PSU_MIO_17_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_17_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_17_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_17_SLEW {slow} \
    CONFIG.PSU_MIO_18_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_18_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_19_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_19_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_19_SLEW {slow} \
    CONFIG.PSU_MIO_1_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_1_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_1_SLEW {slow} \
    CONFIG.PSU_MIO_20_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_20_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_20_SLEW {slow} \
    CONFIG.PSU_MIO_21_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_21_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_22_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_22_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_22_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_22_SLEW {slow} \
    CONFIG.PSU_MIO_23_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_23_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_23_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_23_SLEW {slow} \
    CONFIG.PSU_MIO_24_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_24_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_24_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_24_SLEW {slow} \
    CONFIG.PSU_MIO_25_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_25_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_25_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_25_SLEW {slow} \
    CONFIG.PSU_MIO_26_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_26_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_26_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_26_SLEW {slow} \
    CONFIG.PSU_MIO_27_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_27_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_27_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_27_SLEW {slow} \
    CONFIG.PSU_MIO_28_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_28_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_28_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_28_SLEW {slow} \
    CONFIG.PSU_MIO_29_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_29_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_29_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_29_SLEW {slow} \
    CONFIG.PSU_MIO_2_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_2_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_30_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_30_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_30_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_30_SLEW {slow} \
    CONFIG.PSU_MIO_31_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_31_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_31_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_31_SLEW {slow} \
    CONFIG.PSU_MIO_32_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_32_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_32_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_32_SLEW {slow} \
    CONFIG.PSU_MIO_33_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_33_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_33_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_33_SLEW {slow} \
    CONFIG.PSU_MIO_34_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_34_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_34_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_34_SLEW {slow} \
    CONFIG.PSU_MIO_35_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_35_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_35_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_35_SLEW {slow} \
    CONFIG.PSU_MIO_36_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_36_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_36_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_36_SLEW {slow} \
    CONFIG.PSU_MIO_37_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_37_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_37_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_37_SLEW {slow} \
    CONFIG.PSU_MIO_38_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_38_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_38_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_38_SLEW {slow} \
    CONFIG.PSU_MIO_39_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_39_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_39_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_39_SLEW {slow} \
    CONFIG.PSU_MIO_3_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_3_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_3_SLEW {slow} \
    CONFIG.PSU_MIO_40_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_40_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_40_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_40_SLEW {slow} \
    CONFIG.PSU_MIO_41_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_41_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_41_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_41_SLEW {slow} \
    CONFIG.PSU_MIO_42_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_42_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_42_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_42_SLEW {slow} \
    CONFIG.PSU_MIO_43_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_43_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_43_SLEW {slow} \
    CONFIG.PSU_MIO_44_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_44_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_45_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_45_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_46_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_46_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_SLEW {slow} \
    CONFIG.PSU_MIO_47_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_47_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_47_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_47_SLEW {slow} \
    CONFIG.PSU_MIO_48_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_48_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_48_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_48_SLEW {slow} \
    CONFIG.PSU_MIO_49_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_49_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_49_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_49_SLEW {slow} \
    CONFIG.PSU_MIO_4_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_4_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_50_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_50_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_50_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_50_SLEW {slow} \
    CONFIG.PSU_MIO_51_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_51_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_51_SLEW {slow} \
    CONFIG.PSU_MIO_52_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_52_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_52_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_52_SLEW {slow} \
    CONFIG.PSU_MIO_53_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_53_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_53_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_53_SLEW {slow} \
    CONFIG.PSU_MIO_54_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_54_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_54_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_54_SLEW {slow} \
    CONFIG.PSU_MIO_55_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_55_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_55_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_55_SLEW {slow} \
    CONFIG.PSU_MIO_56_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_56_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_56_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_56_SLEW {slow} \
    CONFIG.PSU_MIO_57_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_57_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_57_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_57_SLEW {slow} \
    CONFIG.PSU_MIO_58_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_58_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_58_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_58_SLEW {slow} \
    CONFIG.PSU_MIO_59_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_59_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_59_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_59_SLEW {slow} \
    CONFIG.PSU_MIO_5_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_5_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_5_SLEW {slow} \
    CONFIG.PSU_MIO_60_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_60_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_60_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_60_SLEW {slow} \
    CONFIG.PSU_MIO_61_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_61_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_61_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_61_SLEW {slow} \
    CONFIG.PSU_MIO_62_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_62_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_62_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_62_SLEW {slow} \
    CONFIG.PSU_MIO_63_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_63_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_63_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_63_SLEW {slow} \
    CONFIG.PSU_MIO_64_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_64_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_64_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_64_SLEW {slow} \
    CONFIG.PSU_MIO_65_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_65_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_65_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_65_SLEW {slow} \
    CONFIG.PSU_MIO_66_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_66_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_66_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_66_SLEW {slow} \
    CONFIG.PSU_MIO_67_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_67_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_67_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_67_SLEW {slow} \
    CONFIG.PSU_MIO_68_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_68_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_68_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_68_SLEW {slow} \
    CONFIG.PSU_MIO_69_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_69_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_69_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_69_SLEW {slow} \
    CONFIG.PSU_MIO_6_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_6_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_70_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_70_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_70_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_70_SLEW {slow} \
    CONFIG.PSU_MIO_71_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_71_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_71_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_71_SLEW {slow} \
    CONFIG.PSU_MIO_72_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_72_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_72_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_72_SLEW {slow} \
    CONFIG.PSU_MIO_73_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_73_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_73_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_73_SLEW {slow} \
    CONFIG.PSU_MIO_74_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_74_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_74_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_74_SLEW {slow} \
    CONFIG.PSU_MIO_75_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_75_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_75_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_75_SLEW {slow} \
    CONFIG.PSU_MIO_76_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_76_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_76_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_76_SLEW {slow} \
    CONFIG.PSU_MIO_77_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_77_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_77_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_77_SLEW {slow} \
    CONFIG.PSU_MIO_7_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_7_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_7_SLEW {slow} \
    CONFIG.PSU_MIO_8_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_8_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_8_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_8_SLEW {slow} \
    CONFIG.PSU_MIO_9_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_9_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_9_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_9_SLEW {slow} \
    CONFIG.PSU_MIO_TREE_PERIPHERALS {TTC 3#TTC 3#TTC 2#TTC 2#TTC 1#TTC 1#TTC 0#TTC 0#######I2C 0#I2C 0#I2C 1#I2C 1#UART 0#UART 0#UART 1#UART 1##################SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD\
1#SD 1#SD 1#SD 1#SD 1##########################} \
    CONFIG.PSU_MIO_TREE_SIGNALS {clk_in#wave_out#clk_in#wave_out#clk_in#wave_out#clk_in#wave_out#######scl_out#sda_out#scl_out#sda_out#rxd#txd#txd#rxd##################sdio1_data_out[4]#sdio1_data_out[5]#sdio1_data_out[6]#sdio1_data_out[7]#sdio1_bus_pow#sdio1_wp#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out##########################}\
\
    CONFIG.PSU_PERIPHERAL_BOARD_PRESET {} \
    CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {8} \
    CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {8} \
    CONFIG.PSU_SMC_CYCLE_T0 {NA} \
    CONFIG.PSU_SMC_CYCLE_T1 {NA} \
    CONFIG.PSU_SMC_CYCLE_T2 {NA} \
    CONFIG.PSU_SMC_CYCLE_T3 {NA} \
    CONFIG.PSU_SMC_CYCLE_T4 {NA} \
    CONFIG.PSU_SMC_CYCLE_T5 {NA} \
    CONFIG.PSU_SMC_CYCLE_T6 {NA} \
    CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {0} \
    CONFIG.PSU_VALUE_SILVERSION {3} \
    CONFIG.PSU__ACPU0__POWER__ON {1} \
    CONFIG.PSU__ACPU1__POWER__ON {1} \
    CONFIG.PSU__ACPU2__POWER__ON {1} \
    CONFIG.PSU__ACPU3__POWER__ON {1} \
    CONFIG.PSU__ACTUAL__IP {1} \
    CONFIG.PSU__ACT_DDR_FREQ_MHZ {1066.656006} \
    CONFIG.PSU__AUX_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__CAN0_LOOP_CAN1__ENABLE {0} \
    CONFIG.PSU__CAN0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1099.989014} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1100} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__ACPU__FRAC_ENABLED {0} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI0_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI1_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI2_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI3_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI4_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI5_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__APM_CTRL__ACT_FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__DIVISOR0 {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {533.328003} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {533.328003} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {25} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__FREQMHZ {25} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {VPLL} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {27} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__FREQMHZ {27} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {VPLL} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {320} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__FREQMHZ {320} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {533.328003} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {533.328003} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__ACT_FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__DIVISOR0 {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__SRCSEL {NA} \
    CONFIG.PSU__CRF_APB__GTGREF0__ENABLE {NA} \
    CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {533.328003} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.994995} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6__ENABLE {0} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {51.723621} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__FREQMHZ {52} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.994995} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__ACT_FREQMHZ {180} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__SRCSEL {SysOsc} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__ACT_FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__DIVISOR0 {6} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.984985} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__FREQMHZ {1500} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {266.664001} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {267} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.994995} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {166.664993} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {167} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__PL2_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__PL3_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {300} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {300} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {199.998001} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__ACT_FREQMHZ {214} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__ACT_FREQMHZ {214} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {33.333000} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {20} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3__ENABLE {0} \
    CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_0__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_10__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_11__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_12__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_1__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_2__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_3__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_4__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_5__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_6__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_7__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_8__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_9__ENABLE {0} \
    CONFIG.PSU__CSU__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__DDRC__AL {0} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {2} \
    CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
    CONFIG.PSU__DDRC__CL {16} \
    CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
    CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
    CONFIG.PSU__DDRC__CWL {11} \
    CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {1} \
    CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
    CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
    CONFIG.PSU__DDRC__DDR4_MAXPWR_SAVING_EN {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
    CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {8 Bits} \
    CONFIG.PSU__DDRC__ECC {Disabled} \
    CONFIG.PSU__DDRC__ECC_SCRUB {0} \
    CONFIG.PSU__DDRC__ENABLE {1} \
    CONFIG.PSU__DDRC__ENABLE_2T_TIMING {0} \
    CONFIG.PSU__DDRC__ENABLE_DP_SWITCH {0} \
    CONFIG.PSU__DDRC__EN_2ND_CLK {0} \
    CONFIG.PSU__DDRC__FGRM {1X} \
    CONFIG.PSU__DDRC__FREQ_MHZ {1} \
    CONFIG.PSU__DDRC__LPDDR3_DUALRANK_SDP {0} \
    CONFIG.PSU__DDRC__LP_ASR {manual normal} \
    CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
    CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
    CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
    CONFIG.PSU__DDRC__PLL_BYPASS {0} \
    CONFIG.PSU__DDRC__PWR_DOWN_EN {0} \
    CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
    CONFIG.PSU__DDRC__RD_DQS_CENTER {0} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
    CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
    CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
    CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
    CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
    CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
    CONFIG.PSU__DDRC__T_FAW {30.0} \
    CONFIG.PSU__DDRC__T_RAS_MIN {33} \
    CONFIG.PSU__DDRC__T_RC {47.06} \
    CONFIG.PSU__DDRC__T_RCD {15} \
    CONFIG.PSU__DDRC__T_RP {15} \
    CONFIG.PSU__DDRC__VIDEO_BUFFER_SIZE {0} \
    CONFIG.PSU__DDRC__VREF {1} \
    CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
    CONFIG.PSU__DDR_QOS_ENABLE {0} \
    CONFIG.PSU__DDR_QOS_HP0_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP0_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_WRQOS {} \
    CONFIG.PSU__DDR_SW_REFRESH_ENABLED {1} \
    CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.500} \
    CONFIG.PSU__DEVICE_TYPE {EG} \
    CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__DLL__ISUSED {1} \
    CONFIG.PSU__ENABLE__DDR__REFRESH__SIGNALS {0} \
    CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET2__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__EN_AXI_STATUS_PORTS {0} \
    CONFIG.PSU__EN_EMIO_TRACE {0} \
    CONFIG.PSU__EP__IP {0} \
    CONFIG.PSU__EXPAND__CORESIGHT {0} \
    CONFIG.PSU__EXPAND__FPD_SLAVES {0} \
    CONFIG.PSU__EXPAND__GIC {0} \
    CONFIG.PSU__EXPAND__LOWER_LPS_SLAVES {1} \
    CONFIG.PSU__EXPAND__UPPER_LPS_SLAVES {0} \
    CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {100} \
    CONFIG.PSU__FPD_SLCR__WDT1__FREQMHZ {100} \
    CONFIG.PSU__FPGA_PL0_ENABLE {1} \
    CONFIG.PSU__FPGA_PL1_ENABLE {0} \
    CONFIG.PSU__FPGA_PL2_ENABLE {0} \
    CONFIG.PSU__FPGA_PL3_ENABLE {0} \
    CONFIG.PSU__FP__POWER__ON {1} \
    CONFIG.PSU__FTM__CTI_IN_0 {0} \
    CONFIG.PSU__FTM__CTI_IN_1 {0} \
    CONFIG.PSU__FTM__CTI_IN_2 {0} \
    CONFIG.PSU__FTM__CTI_IN_3 {0} \
    CONFIG.PSU__FTM__CTI_OUT_0 {0} \
    CONFIG.PSU__FTM__CTI_OUT_1 {0} \
    CONFIG.PSU__FTM__CTI_OUT_2 {0} \
    CONFIG.PSU__FTM__CTI_OUT_3 {0} \
    CONFIG.PSU__FTM__GPI {0} \
    CONFIG.PSU__FTM__GPO {0} \
    CONFIG.PSU__GEN_IPI_0__MASTER {APU} \
    CONFIG.PSU__GEN_IPI_10__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_1__MASTER {RPU0} \
    CONFIG.PSU__GEN_IPI_2__MASTER {RPU1} \
    CONFIG.PSU__GEN_IPI_3__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_4__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_5__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_6__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_7__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_8__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_9__MASTER {NONE} \
    CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__GPIO_EMIO_WIDTH {95} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {95} \
    CONFIG.PSU__GPIO_EMIO__WIDTH {[94:0]} \
    CONFIG.PSU__GPU_PP0__POWER__ON {1} \
    CONFIG.PSU__GPU_PP1__POWER__ON {1} \
    CONFIG.PSU__GT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__HPM0_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__I2C0_LOOP_I2C1__ENABLE {0} \
    CONFIG.PSU__I2C0__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
    CONFIG.PSU__I2C1__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC0__FREQMHZ {100} \
    CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC1__FREQMHZ {100} \
    CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC2__FREQMHZ {100} \
    CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC3__FREQMHZ {100} \
    CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {100} \
    CONFIG.PSU__IOU_SLCR__WDT0__FREQMHZ {100} \
    CONFIG.PSU__IRQ_P2F_ADMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_AIB_AXI__INT {0} \
    CONFIG.PSU__IRQ_P2F_AMS__INT {0} \
    CONFIG.PSU__IRQ_P2F_APM_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_COMM__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CPUMNT__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CTI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_EXTERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_L2ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_PMU__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_REGS__INT {0} \
    CONFIG.PSU__IRQ_P2F_ATB_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_CLKMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_DDR_SS__INT {0} \
    CONFIG.PSU__IRQ_P2F_DPDMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_EFUSE__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_ATB_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_FP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_GDMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPIO__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPU__INT {0} \
    CONFIG.PSU__IRQ_P2F_I2C0__INT {0} \
    CONFIG.PSU__IRQ_P2F_I2C1__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APM__INT {0} \
    CONFIG.PSU__IRQ_P2F_LP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_OCM_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_DMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_LEGACY__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSC__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSI__INT {0} \
    CONFIG.PSU__IRQ_P2F_PL_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE0_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE1_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_PERMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_ALARM__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_SECONDS__INT {0} \
    CONFIG.PSU__IRQ_P2F_SATA__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1_WAKE__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1__INT {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_UART0__INT {0} \
    CONFIG.PSU__IRQ_P2F_UART1__INT {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_PMU_WAKEUP__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_FPD_SMMU__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_PPD_CCI__INT {0} \
    CONFIG.PSU__L2_BANK0__POWER__ON {1} \
    CONFIG.PSU__LPDMA0_COHERENCY {0} \
    CONFIG.PSU__LPDMA1_COHERENCY {0} \
    CONFIG.PSU__LPDMA2_COHERENCY {0} \
    CONFIG.PSU__LPDMA3_COHERENCY {0} \
    CONFIG.PSU__LPDMA4_COHERENCY {0} \
    CONFIG.PSU__LPDMA5_COHERENCY {0} \
    CONFIG.PSU__LPDMA6_COHERENCY {0} \
    CONFIG.PSU__LPDMA7_COHERENCY {0} \
    CONFIG.PSU__LPD_SLCR__CSUPMU_WDT_CLK_SEL__SELECT {APB} \
    CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100} \
    CONFIG.PSU__LPD_SLCR__CSUPMU__FREQMHZ {100} \
    CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
    CONFIG.PSU__M_AXI_GP0_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP1_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP2_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__NAND__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__NAND__READY_BUSY__ENABLE {0} \
    CONFIG.PSU__NUM_FABRIC_RESETS {1} \
    CONFIG.PSU__OCM_BANK0__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK1__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK2__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK3__POWER__ON {1} \
    CONFIG.PSU__OVERRIDE_HPX_QOS {0} \
    CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
    CONFIG.PSU__PCIE__ACS_VIOLAION {0} \
    CONFIG.PSU__PCIE__AER_CAPABILITY {0} \
    CONFIG.PSU__PCIE__CLASS_CODE_BASE {} \
    CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {} \
    CONFIG.PSU__PCIE__CLASS_CODE_SUB {} \
    CONFIG.PSU__PCIE__DEVICE_ID {} \
    CONFIG.PSU__PCIE__INTX_GENERATION {0} \
    CONFIG.PSU__PCIE__MSIX_CAPABILITY {0} \
    CONFIG.PSU__PCIE__MSI_CAPABILITY {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {1} \
    CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {0} \
    CONFIG.PSU__PCIE__RESET__POLARITY {Active Low} \
    CONFIG.PSU__PCIE__REVISION_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {} \
    CONFIG.PSU__PCIE__VENDOR_ID {} \
    CONFIG.PSU__PJTAG__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PL_CLK0_BUF {TRUE} \
    CONFIG.PSU__PL__POWER__ON {1} \
    CONFIG.PSU__PMU__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PRESET_APPLIED {0} \
    CONFIG.PSU__PROTECTION__DDR_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__ENABLE {0} \
    CONFIG.PSU__PROTECTION__FPD_SEGMENTS {SA:0xFD1A0000 ;SIZE:1280;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD000000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU\
Firmware  |  SA:0xFD010000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD020000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware\
 |  SA:0xFD030000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD040000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |\
 SA:0xFD050000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD610000 ;SIZE:512;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD5D0000\
;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware} \
    CONFIG.PSU__PROTECTION__LPD_SEGMENTS {SA:0xFF980000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF5E0000 ;SIZE:2560;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU\
Firmware|SA:0xFFCC0000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF180000 ;SIZE:768;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF410000\
;SIZE:640;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFFA70000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF9A0000 ;SIZE:64;UNIT:KB\
;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware} \
    CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;0|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;0|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;0|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;1|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;0|SATA1:NonSecure;0|SATA0:NonSecure;0|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;0|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;0|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;0|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1}\
\
    CONFIG.PSU__PROTECTION__MASTERS_TZ {GEM0:NonSecure|SD1:NonSecure|GEM2:NonSecure|GEM1:NonSecure|GEM3:NonSecure|PCIe:NonSecure|DP:NonSecure|NAND:NonSecure|GPU:NonSecure|USB1:NonSecure|USB0:NonSecure|LDMA:NonSecure|FDMA:NonSecure|QSPI:NonSecure|SD0:NonSecure}\
\
    CONFIG.PSU__PROTECTION__OCM_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__PRESUBSYSTEMS {NONE} \
    CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;0|LPD;USB3_0;FF9D0000;FF9DFFFF;0|LPD;UART1;FF010000;FF01FFFF;1|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;0|LPD;SWDT0;FF150000;FF15FFFF;0|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;0|FPD;SATA;FD0C0000;FD0CFFFF;0|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;0|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;1|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;0|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display\
Port;FD4A0000;FD4AFFFF;0|FPD;DPDMA;FD4C0000;FD4CFFFF;0|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1}\
\
    CONFIG.PSU__PROTECTION__SUBSYSTEMS {PMU Firmware:PMU} \
    CONFIG.PSU__PSS_ALT_REF_CLK__ENABLE {0} \
    CONFIG.PSU__PSS_ALT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__REPORT__DBGLOG {0} \
    CONFIG.PSU__RPU_COHERENCY {0} \
    CONFIG.PSU__RPU__POWER__ON {1} \
    CONFIG.PSU__SATA__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
    CONFIG.PSU__SD0__CLK_100_SDR_OTAP_DLY {0x00} \
    CONFIG.PSU__SD0__CLK_200_SDR_OTAP_DLY {0x00} \
    CONFIG.PSU__SD0__CLK_50_DDR_ITAP_DLY {0x00} \
    CONFIG.PSU__SD0__CLK_50_DDR_OTAP_DLY {0x00} \
    CONFIG.PSU__SD0__CLK_50_SDR_ITAP_DLY {0x00} \
    CONFIG.PSU__SD0__CLK_50_SDR_OTAP_DLY {0x00} \
    CONFIG.PSU__SD0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SD0__RESET__ENABLE {0} \
    CONFIG.PSU__SD1_COHERENCY {0} \
    CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__SD1__CLK_100_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD1__CLK_200_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD1__CLK_50_DDR_ITAP_DLY {0x3D} \
    CONFIG.PSU__SD1__CLK_50_DDR_OTAP_DLY {0x4} \
    CONFIG.PSU__SD1__CLK_50_SDR_ITAP_DLY {0x15} \
    CONFIG.PSU__SD1__CLK_50_SDR_OTAP_DLY {0x5} \
    CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
    CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
    CONFIG.PSU__SD1__GRP_POW__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_POW__IO {MIO 43} \
    CONFIG.PSU__SD1__GRP_WP__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_WP__IO {MIO 44} \
    CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
    CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
    CONFIG.PSU__SPI0_LOOP_SPI1__ENABLE {0} \
    CONFIG.PSU__SPI0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SPI1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SWDT0__PERIPHERAL__IO {NA} \
    CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SWDT1__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TCM0A__POWER__ON {1} \
    CONFIG.PSU__TCM0B__POWER__ON {1} \
    CONFIG.PSU__TCM1A__POWER__ON {1} \
    CONFIG.PSU__TCM1B__POWER__ON {1} \
    CONFIG.PSU__TESTSCAN__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRACE__INTERNAL_WIDTH {32} \
    CONFIG.PSU__TRACE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRISTATE__INVERTED {1} \
    CONFIG.PSU__TTC0__CLOCK__ENABLE {1} \
    CONFIG.PSU__TTC0__CLOCK__IO {MIO 6} \
    CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC0__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC0__WAVEOUT__ENABLE {1} \
    CONFIG.PSU__TTC0__WAVEOUT__IO {MIO 7} \
    CONFIG.PSU__TTC1__CLOCK__ENABLE {1} \
    CONFIG.PSU__TTC1__CLOCK__IO {MIO 4} \
    CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC1__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC1__WAVEOUT__ENABLE {1} \
    CONFIG.PSU__TTC1__WAVEOUT__IO {MIO 5} \
    CONFIG.PSU__TTC2__CLOCK__ENABLE {1} \
    CONFIG.PSU__TTC2__CLOCK__IO {MIO 2} \
    CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC2__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC2__WAVEOUT__ENABLE {1} \
    CONFIG.PSU__TTC2__WAVEOUT__IO {MIO 3} \
    CONFIG.PSU__TTC3__CLOCK__ENABLE {1} \
    CONFIG.PSU__TTC3__CLOCK__IO {MIO 0} \
    CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC3__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC3__WAVEOUT__ENABLE {1} \
    CONFIG.PSU__TTC3__WAVEOUT__IO {MIO 1} \
    CONFIG.PSU__UART0_LOOP_UART1__ENABLE {0} \
    CONFIG.PSU__UART0__BAUD_RATE {115200} \
    CONFIG.PSU__UART0__MODEM__ENABLE {0} \
    CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \
    CONFIG.PSU__UART1__BAUD_RATE {115200} \
    CONFIG.PSU__UART1__MODEM__ENABLE {0} \
    CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__UART1__PERIPHERAL__IO {MIO 20 .. 21} \
    CONFIG.PSU__USB0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__USB0__RESET__ENABLE {0} \
    CONFIG.PSU__USB1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__USB1__RESET__ENABLE {0} \
    CONFIG.PSU__USE_DIFF_RW_CLK_GP2 {0} \
    CONFIG.PSU__USE__ADMA {0} \
    CONFIG.PSU__USE__APU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__AUDIO {0} \
    CONFIG.PSU__USE__CLK {0} \
    CONFIG.PSU__USE__CLK0 {0} \
    CONFIG.PSU__USE__CLK1 {0} \
    CONFIG.PSU__USE__CLK2 {0} \
    CONFIG.PSU__USE__CLK3 {0} \
    CONFIG.PSU__USE__CROSS_TRIGGER {0} \
    CONFIG.PSU__USE__DDR_INTF_REQUESTED {0} \
    CONFIG.PSU__USE__DEBUG__TEST {0} \
    CONFIG.PSU__USE__EVENT_RPU {0} \
    CONFIG.PSU__USE__FABRIC__RST {1} \
    CONFIG.PSU__USE__FTM {0} \
    CONFIG.PSU__USE__GDMA {0} \
    CONFIG.PSU__USE__IRQ {0} \
    CONFIG.PSU__USE__IRQ0 {1} \
    CONFIG.PSU__USE__IRQ1 {0} \
    CONFIG.PSU__USE__M_AXI_GP0 {1} \
    CONFIG.PSU__USE__M_AXI_GP1 {0} \
    CONFIG.PSU__USE__M_AXI_GP2 {0} \
    CONFIG.PSU__USE__PROC_EVENT_BUS {0} \
    CONFIG.PSU__USE__RPU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__RST0 {0} \
    CONFIG.PSU__USE__RST1 {0} \
    CONFIG.PSU__USE__RST2 {0} \
    CONFIG.PSU__USE__RST3 {0} \
    CONFIG.PSU__USE__RTC {0} \
    CONFIG.PSU__USE__STM {0} \
    CONFIG.PSU__USE__S_AXI_ACE {0} \
    CONFIG.PSU__USE__S_AXI_ACP {0} \
    CONFIG.PSU__USE__S_AXI_GP0 {0} \
    CONFIG.PSU__USE__S_AXI_GP1 {0} \
    CONFIG.PSU__USE__S_AXI_GP2 {1} \
    CONFIG.PSU__USE__S_AXI_GP3 {0} \
    CONFIG.PSU__USE__S_AXI_GP4 {0} \
    CONFIG.PSU__USE__S_AXI_GP5 {0} \
    CONFIG.PSU__USE__S_AXI_GP6 {0} \
    CONFIG.PSU__USE__USB3_0_HUB {0} \
    CONFIG.PSU__USE__USB3_1_HUB {0} \
    CONFIG.PSU__USE__VIDEO {0} \
    CONFIG.PSU__VIDEO_REF_CLK__ENABLE {0} \
    CONFIG.PSU__VIDEO_REF_CLK__FREQMHZ {33.333} \
    CONFIG.QSPI_BOARD_INTERFACE {custom} \
    CONFIG.SATA_BOARD_INTERFACE {custom} \
    CONFIG.SD0_BOARD_INTERFACE {custom} \
    CONFIG.SD1_BOARD_INTERFACE {custom} \
    CONFIG.SPI0_BOARD_INTERFACE {custom} \
    CONFIG.SPI1_BOARD_INTERFACE {custom} \
    CONFIG.SUBPRESET1 {Custom} \
    CONFIG.SUBPRESET2 {Custom} \
    CONFIG.SWDT0_BOARD_INTERFACE {custom} \
    CONFIG.SWDT1_BOARD_INTERFACE {custom} \
    CONFIG.TRACE_BOARD_INTERFACE {custom} \
    CONFIG.TTC0_BOARD_INTERFACE {custom} \
    CONFIG.TTC1_BOARD_INTERFACE {custom} \
    CONFIG.TTC2_BOARD_INTERFACE {custom} \
    CONFIG.TTC3_BOARD_INTERFACE {custom} \
    CONFIG.UART0_BOARD_INTERFACE {custom} \
    CONFIG.UART1_BOARD_INTERFACE {custom} \
    CONFIG.USB0_BOARD_INTERFACE {custom} \
    CONFIG.USB1_BOARD_INTERFACE {custom} \
  ] $zusp_ps


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_LITE_0_1 [get_bd_intf_pins usxgmii/S_AXI_LITE_0] [get_bd_intf_pins zusp_ps/M_AXI_HPM0_FPD]
  connect_bd_intf_net -intf_net gt_ref_clk_0_1 [get_bd_intf_ports gt_ref_clk_0] [get_bd_intf_pins usxgmii/gt_ref_clk_0]
  connect_bd_intf_net -intf_net gt_rx_0_1 [get_bd_intf_ports gt_rx_0] [get_bd_intf_pins usxgmii/gt_rx_0]
  connect_bd_intf_net -intf_net usxgmii_M00_AXI_0 [get_bd_intf_pins usxgmii/M00_AXI_0] [get_bd_intf_pins zusp_ps/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net usxgmii_gt_tx_0 [get_bd_intf_ports gt_tx_0] [get_bd_intf_pins usxgmii/gt_tx_0]

  # Create port connections
  connect_bd_net -net Net  [get_bd_pins zusp_ps/pl_clk0] \
  [get_bd_pins zusp_ps/maxihpm0_fpd_aclk] \
  [get_bd_pins zusp_ps/saxihp0_fpd_aclk] \
  [get_bd_pins usxgmii/dclk_0]
  connect_bd_net -net usxgmii_dout_0  [get_bd_pins usxgmii/dout_0] \
  [get_bd_ports SFP_TX_DIS]
  connect_bd_net -net usxgmii_mcdma_rx_introut  [get_bd_pins usxgmii/mcdma_rx_introut] \
  [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net usxgmii_mcdma_tx_introut  [get_bd_pins usxgmii/mcdma_tx_introut] \
  [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net xlconcat_0_dout  [get_bd_pins xlconcat_0/dout] \
  [get_bd_pins zusp_ps/pl_ps_irq0]
  connect_bd_net -net zusp_ps_pl_resetn0  [get_bd_pins zusp_ps/pl_resetn0] \
  [get_bd_pins usxgmii/ext_reset_in_0]

  # Create address segments
  assign_bd_address -offset 0xA0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zusp_ps/Data] [get_bd_addr_segs usxgmii/axi_dma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zusp_ps/Data] [get_bd_addr_segs usxgmii/usxgmii_0/s_axi_0/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xFFFC0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_OCM] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xFFFC0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_OCM] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xFFFC0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_OCM] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -offset 0xFF9B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_AFIFM6]
  exclude_bd_addr_seg -offset 0xFFA50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_AMS]
  exclude_bd_addr_seg -offset 0xFFA00000 -range 0x00040000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_APM]
  exclude_bd_addr_seg -offset 0xFF500000 -range 0x00100000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_CRL_APB]
  exclude_bd_addr_seg -offset 0xFFCA0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_CSU]
  exclude_bd_addr_seg -offset 0xFFC80000 -range 0x00020000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_CSUDMA]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFFCC0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_EFUSE]
  exclude_bd_addr_seg -offset 0xFF020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_I2C0]
  exclude_bd_addr_seg -offset 0xFF030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_I2C1]
  exclude_bd_addr_seg -offset 0xFF180000 -range 0x00080000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOUSLCR]
  exclude_bd_addr_seg -offset 0xFF250000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOU_SCNTR]
  exclude_bd_addr_seg -offset 0xFF260000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOU_SCNTRS]
  exclude_bd_addr_seg -offset 0xFF240000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOU_SECURE_SLCR]
  exclude_bd_addr_seg -offset 0xFF300000 -range 0x00100000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IPI]
  exclude_bd_addr_seg -offset 0xFF990000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IPI_BUFFERS]
  exclude_bd_addr_seg -offset 0xFFA80000 -range 0x00080000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LDMA]
  exclude_bd_addr_seg -offset 0xFF400000 -range 0x00100000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LPD_SLCR]
  exclude_bd_addr_seg -offset 0xFF980000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LPD_XPPU]
  exclude_bd_addr_seg -offset 0xFF9C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LPD_XPPU_SINK]
  exclude_bd_addr_seg -offset 0xFFCF0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_MBISTJTAG]
  exclude_bd_addr_seg -offset 0xFF960000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_OCM_CTRL]
  exclude_bd_addr_seg -offset 0xFFA70000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_OCM_XMPU_CFG]
  exclude_bd_addr_seg -offset 0xFFD80000 -range 0x00040000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_PMU_GLOBAL]
  exclude_bd_addr_seg -offset 0xFF9A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_RPU]
  exclude_bd_addr_seg -offset 0xFFCE0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_RSA]
  exclude_bd_addr_seg -offset 0xFFA60000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_RTC]
  exclude_bd_addr_seg -offset 0xFF170000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_SD1]
  exclude_bd_addr_seg -offset 0xFF110000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC0]
  exclude_bd_addr_seg -offset 0xFF120000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC1]
  exclude_bd_addr_seg -offset 0xFF130000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC2]
  exclude_bd_addr_seg -offset 0xFF140000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC3]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_UART0]
  exclude_bd_addr_seg -offset 0xFF010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_MM2S] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_UART1]
  exclude_bd_addr_seg -offset 0xFF9B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_AFIFM6]
  exclude_bd_addr_seg -offset 0xFFA50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_AMS]
  exclude_bd_addr_seg -offset 0xFFA00000 -range 0x00040000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_APM]
  exclude_bd_addr_seg -offset 0xFF500000 -range 0x00100000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_CRL_APB]
  exclude_bd_addr_seg -offset 0xFFCA0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_CSU]
  exclude_bd_addr_seg -offset 0xFFC80000 -range 0x00020000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_CSUDMA]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFFCC0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_EFUSE]
  exclude_bd_addr_seg -offset 0xFF020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_I2C0]
  exclude_bd_addr_seg -offset 0xFF030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_I2C1]
  exclude_bd_addr_seg -offset 0xFF180000 -range 0x00080000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOUSLCR]
  exclude_bd_addr_seg -offset 0xFF250000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOU_SCNTR]
  exclude_bd_addr_seg -offset 0xFF260000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOU_SCNTRS]
  exclude_bd_addr_seg -offset 0xFF240000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOU_SECURE_SLCR]
  exclude_bd_addr_seg -offset 0xFF300000 -range 0x00100000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IPI]
  exclude_bd_addr_seg -offset 0xFF990000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IPI_BUFFERS]
  exclude_bd_addr_seg -offset 0xFFA80000 -range 0x00080000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LDMA]
  exclude_bd_addr_seg -offset 0xFF400000 -range 0x00100000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LPD_SLCR]
  exclude_bd_addr_seg -offset 0xFF980000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LPD_XPPU]
  exclude_bd_addr_seg -offset 0xFF9C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LPD_XPPU_SINK]
  exclude_bd_addr_seg -offset 0xFFCF0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_MBISTJTAG]
  exclude_bd_addr_seg -offset 0xFF960000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_OCM_CTRL]
  exclude_bd_addr_seg -offset 0xFFA70000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_OCM_XMPU_CFG]
  exclude_bd_addr_seg -offset 0xFFD80000 -range 0x00040000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_PMU_GLOBAL]
  exclude_bd_addr_seg -offset 0xFF9A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_RPU]
  exclude_bd_addr_seg -offset 0xFFCE0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_RSA]
  exclude_bd_addr_seg -offset 0xFFA60000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_RTC]
  exclude_bd_addr_seg -offset 0xFF170000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_SD1]
  exclude_bd_addr_seg -offset 0xFF110000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC0]
  exclude_bd_addr_seg -offset 0xFF120000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC1]
  exclude_bd_addr_seg -offset 0xFF130000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC2]
  exclude_bd_addr_seg -offset 0xFF140000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC3]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_UART0]
  exclude_bd_addr_seg -offset 0xFF010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_S2MM] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_UART1]
  exclude_bd_addr_seg -offset 0xFF9B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_AFIFM6]
  exclude_bd_addr_seg -offset 0xFFA50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_AMS]
  exclude_bd_addr_seg -offset 0xFFA00000 -range 0x00040000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_APM]
  exclude_bd_addr_seg -offset 0xFF500000 -range 0x00100000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_CRL_APB]
  exclude_bd_addr_seg -offset 0xFFCA0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_CSU]
  exclude_bd_addr_seg -offset 0xFFC80000 -range 0x00020000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_CSUDMA]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFFCC0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_EFUSE]
  exclude_bd_addr_seg -offset 0xFF020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_I2C0]
  exclude_bd_addr_seg -offset 0xFF030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_I2C1]
  exclude_bd_addr_seg -offset 0xFF180000 -range 0x00080000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOUSLCR]
  exclude_bd_addr_seg -offset 0xFF250000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOU_SCNTR]
  exclude_bd_addr_seg -offset 0xFF260000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOU_SCNTRS]
  exclude_bd_addr_seg -offset 0xFF240000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IOU_SECURE_SLCR]
  exclude_bd_addr_seg -offset 0xFF300000 -range 0x00100000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IPI]
  exclude_bd_addr_seg -offset 0xFF990000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_IPI_BUFFERS]
  exclude_bd_addr_seg -offset 0xFFA80000 -range 0x00080000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LDMA]
  exclude_bd_addr_seg -offset 0xFF400000 -range 0x00100000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LPD_SLCR]
  exclude_bd_addr_seg -offset 0xFF980000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LPD_XPPU]
  exclude_bd_addr_seg -offset 0xFF9C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_LPD_XPPU_SINK]
  exclude_bd_addr_seg -offset 0xFFCF0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_MBISTJTAG]
  exclude_bd_addr_seg -offset 0xFF960000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_OCM_CTRL]
  exclude_bd_addr_seg -offset 0xFFA70000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_OCM_XMPU_CFG]
  exclude_bd_addr_seg -offset 0xFFD80000 -range 0x00040000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_PMU_GLOBAL]
  exclude_bd_addr_seg -offset 0xFF9A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_RPU]
  exclude_bd_addr_seg -offset 0xFFCE0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_RSA]
  exclude_bd_addr_seg -offset 0xFFA60000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_RTC]
  exclude_bd_addr_seg -offset 0xFF170000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_SD1]
  exclude_bd_addr_seg -offset 0xFF110000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC0]
  exclude_bd_addr_seg -offset 0xFF120000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC1]
  exclude_bd_addr_seg -offset 0xFF130000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC2]
  exclude_bd_addr_seg -offset 0xFF140000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_TTC3]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_UART0]
  exclude_bd_addr_seg -offset 0xFF010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces usxgmii/axi_dma_0/Data_SG] [get_bd_addr_segs zusp_ps/SAXIGP2/HP0_UART1]


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


