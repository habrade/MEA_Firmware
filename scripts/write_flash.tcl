set_property CFGMEM_PART {28f00ap30t-bpi-x16} [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.ADDRESS_RANGE  {use_file} [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.FILES [list "/home/sdong/work/sca_test/myFwArea/top.mcs" ] [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.PRM_FILE {/home/sdong/work/sca_test/myFwArea/top.prm} [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.BPI_RS_PINS {none} [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.UNUSED_PIN_TERMINATION {pull-none} [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.BLANK_CHECK  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.ERASE  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.CFG_PROGRAM  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.VERIFY  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.CHECKSUM  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
startgroup 
create_hw_bitstream -hw_device [lindex [get_hw_devices xc7k325t_0] 0] [get_property PROGRAM.HW_CFGMEM_BITFILE [ lindex [get_hw_devices xc7k325t_0] 0]]; program_hw_devices [lindex [get_hw_devices xc7k325t_0] 0]; refresh_hw_device [lindex [get_hw_devices xc7k325t_0] 0];
program_hw_cfgmem -hw_cfgmem [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]

