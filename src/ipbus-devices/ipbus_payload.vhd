library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.ipbus.all;
use work.ipbus_reg_types.all;
use work.ipbus_decode_payload.all;
use work.drp_decl.all;

entity ipbus_payload is
  generic(
    N_DRP : integer := 2;
    N_CLK : integer := 2
    );
  port(
    ipb_clk : in  std_logic;
    ipb_rst : in  std_logic;
    ipb_in  : in  ipb_wbus;
    ipb_out : out ipb_rbus;

    clk : in std_logic;
    rst : in std_logic;
    
    clk_dac : in std_logic;
    rst_dac : in std_logic;
	
    -- Global
    nuke           : out std_logic;
    soft_rst       : out std_logic;
    -- DAC8568
    dac8568_busy   : in  std_logic;
    dac8568_rst    : out std_logic;
    dac8568_start  : out std_logic;
    dac8568_sel_ch : out std_logic_vector(7 downto 0);

    dac8568_data_a  : out std_logic_vector(15 downto 0);
    dac8568_data_b  : out std_logic_vector(15 downto 0);
    dac8568_data_c  : out std_logic_vector(15 downto 0);
    dac8568_data_d  : out std_logic_vector(15 downto 0);
    dac8568_data_e  : out std_logic_vector(15 downto 0);
    dac8568_data_f  : out std_logic_vector(15 downto 0);
    dac8568_data_g  : out std_logic_vector(15 downto 0);
    dac8568_data_h  : out std_logic_vector(15 downto 0);
    -- MEA
    -- Control Port
    sel_mea_clk     : out std_logic;
    mea_clk_div_cnt : out integer;
    mea_start_scan  : out std_logic;
    mea_reset_scan  : out std_logic;

    -- MMCM DRP Ports
    locked     : in  std_logic_vector(N_DRP-1 downto 0);
    rst_mmcm   : out std_logic_vector(N_DRP-1 downto 0);
    drp_out    : out drp_wbus_array(N_DRP-1 downto 0);
    drp_in     : in  drp_rbus_array(N_DRP-1 downto 0);
    -- FREQ CTR
    clk_ctr_in : in  std_logic_vector(N_CLK-1 downto 0)
    );

end ipbus_payload;

architecture rtl of ipbus_payload is

  signal ipbw : ipb_wbus_array(N_SLAVES - 1 downto 0);
  signal ipbr : ipb_rbus_array(N_SLAVES - 1 downto 0);

begin

-- ipbus address decode

  fabric : entity work.ipbus_fabric_sel
    generic map(
      NSLV      => N_SLAVES,
      SEL_WIDTH => IPBUS_SEL_WIDTH)
    port map(
      ipb_in          => ipb_in,
      ipb_out         => ipb_out,
      sel             => ipbus_sel_payload(ipb_in.ipb_addr),
      ipb_to_slaves   => ipbw,
      ipb_from_slaves => ipbr
      );

  slave0 : entity work.ipbus_global_device
    port map(
      ipb_clk  => ipb_clk,
      ipb_rst  => ipb_rst,
      ipb_in   => ipbw(N_SLV_GLOBAL),
      ipb_out  => ipbr(N_SLV_GLOBAL),
      nuke     => nuke,
      soft_rst => soft_rst
      );


  slave1 : entity work.ipbus_dac8568_device
    port map(
      ipb_clk => ipb_clk,
      ipb_rst => ipb_rst,
      ipb_in  => ipbw(N_SLV_DAC8568),
      ipb_out => ipbr(N_SLV_DAC8568),

      clk => clk_dac,
      rst => rst_dac,

      -- DAC8568  
      dac8568_busy => dac8568_busy,

      dac8568_rst    => dac8568_rst,
      dac8568_start  => dac8568_start,
      dac8568_sel_ch => dac8568_sel_ch,

      dac8568_data_a => dac8568_data_a,
      dac8568_data_b => dac8568_data_b,
      dac8568_data_c => dac8568_data_c,
      dac8568_data_d => dac8568_data_d,
      dac8568_data_e => dac8568_data_e,
      dac8568_data_f => dac8568_data_f,
      dac8568_data_g => dac8568_data_g,
      dac8568_data_h => dac8568_data_h
      );

  slave2 : entity work.ipbus_mea_device
    generic map(
      N_DRP => N_DRP
      )
    port map(
      ipb_clk => ipb_clk,
      ipb_rst => ipb_rst,
      ipb_in  => ipbw(N_SLV_MEA),
      ipb_out => ipbr(N_SLV_MEA),

      clk => clk,
      rst => rst,

      -- MEA IO PORTS
      mea_start_scan  => mea_start_scan,
      mea_reset_scan  => mea_reset_scan,
      sel_mea_clk     => sel_mea_clk,
      mea_clk_div_cnt => mea_clk_div_cnt,

      -- MMCM DRP Ports.
      locked   => locked,
      rst_mmcm => rst_mmcm,
      drp_out  => drp_out,
      drp_in   => drp_in
      );


  slave3 : entity work.ipbus_freq_ctr
    generic map(
      N_CLK => N_CLK
      )
    port map(
      clk     => ipb_clk,
      rst     => ipb_rst,
      ipb_in  => ipbw(N_SLV_FREQ_CTR),
      ipb_out => ipbr(N_SLV_FREQ_CTR),
      clkdiv  => clk_ctr_in
      );



end rtl;

