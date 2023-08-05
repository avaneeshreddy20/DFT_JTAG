library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity boundary_scan is 
 port ( 
      shift_dr        : IN std_logic;
      mode            : IN std_logic;
      system_input_A  : IN std_logic_vector(7 downto 0);
      system_input_B  : IN std_logic_vector(7 downto 0);
      system_output   : OUT std_logic_vector(15 downto 0);
      clock_dr        : IN std_logic; 
      update_dr       : IN std_logic;
      tdi             : IN std_logic;
      output_bsr      : OUT std_logic;
      system_logic_in : OUT std_logic_vector(15 downto 0);
      system_logic_out: IN std_logic_vector(15 downto 0));
end entity boundary_scan;


architecture structural of boundary_scan is
signal to_nxt_cell : std_logic_vector(31 downto 0);

component ip_bsc is 
 port( clock_dr        : IN std_logic;
       update_dr       : IN std_logic;
       shift_dr        : IN std_logic;
       system_input    : IN std_logic;
       mode            : IN std_logic;
       last_cell       : IN std_logic;
       next_cell       : OUT std_logic;
       system_logic_in : OUT std_logic);
end component;

component op_bsc is 
port(clock_dr           : IN std_logic;
      update_dr         : IN std_logic;
      shift_dr          : IN std_logic;
      system_logic_out  : IN std_logic;
      mode              : IN std_logic;
      last_cell         : IN std_logic;
      next_cell         : OUT std_logic;
      system_output     : OUT std_logic);
end component;

begin

  c1:  ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_A(0),  mode,  tdi,             to_nxt_cell(0), system_logic_in(0));
  c2:  ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_A(1),  mode,  to_nxt_cell(0),  to_nxt_cell(1), system_logic_in(1));
  c3:  ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_A(2),  mode,  to_nxt_cell(1),  to_nxt_cell(2), system_logic_in(2));
  c4:  ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_A(3),  mode,  to_nxt_cell(2),  to_nxt_cell(3), system_logic_in(3));
  c5:  ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_A(4),  mode,  to_nxt_cell(3),  to_nxt_cell(4), system_logic_in(4));
  c6:  ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_A(5),  mode,  to_nxt_cell(4),  to_nxt_cell(5), system_logic_in(5));
  c7:  ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_A(6),  mode,  to_nxt_cell(5),  to_nxt_cell(6), system_logic_in(6));
  c8:  ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_A(7),  mode,  to_nxt_cell(6),  to_nxt_cell(7), system_logic_in(7));
  c9:  ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_B(0),  mode,  to_nxt_cell(7),  to_nxt_cell(8), system_logic_in(8));
  c10: ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_B(1),  mode,  to_nxt_cell(8),  to_nxt_cell(9), system_logic_in(9));
  c11: ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_B(2),  mode, to_nxt_cell(9),  to_nxt_cell(10), system_logic_in(10));
  c12: ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_B(3),  mode, to_nxt_cell(10),  to_nxt_cell(11), system_logic_in(11));
  c13: ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_B(4),  mode, to_nxt_cell(11),  to_nxt_cell(12), system_logic_in(12));
  c14: ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_B(5),  mode, to_nxt_cell(12),  to_nxt_cell(13), system_logic_in(13));
  c15: ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_B(6),  mode, to_nxt_cell(13),  to_nxt_cell(14), system_logic_in(14));
  c16: ip_bsc port map(clock_dr, update_dr, shift_dr, system_input_B(7),  mode, to_nxt_cell(14),  to_nxt_cell(15), system_logic_in(15));
  
  c17: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(0),  mode, to_nxt_cell(15), to_nxt_cell(16), system_output(0));
  c18: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(1),  mode, to_nxt_cell(16), to_nxt_cell(17), system_output(1));
  c19: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(2),  mode, to_nxt_cell(17), to_nxt_cell(18), system_output(2));
  c20: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(3),  mode, to_nxt_cell(18), to_nxt_cell(19), system_output(3));
  c21: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(4),  mode, to_nxt_cell(19), to_nxt_cell(20), system_output(4));
  c22: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(5),  mode, to_nxt_cell(20), to_nxt_cell(21), system_output(5));
  c23: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(6),  mode, to_nxt_cell(21), to_nxt_cell(22), system_output(6));
  c24: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(7),  mode, to_nxt_cell(22), to_nxt_cell(23), system_output(7));
  c25: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(8),  mode, to_nxt_cell(23), to_nxt_cell(24), system_output(8));
  c26: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(9),  mode, to_nxt_cell(24), to_nxt_cell(25), system_output(9));
  c27: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(10), mode,  to_nxt_cell(25), to_nxt_cell(26), system_output(10));
  c28: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(11), mode,  to_nxt_cell(26), to_nxt_cell(27), system_output(11));
  c29: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(12), mode,  to_nxt_cell(27), to_nxt_cell(28), system_output(12));
  c30: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(13), mode,  to_nxt_cell(28), to_nxt_cell(29), system_output(13));
  c31: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(14), mode,  to_nxt_cell(29), to_nxt_cell(30), system_output(14));
  c32: op_bsc port map(clock_dr, update_dr, shift_dr, system_logic_out(15), mode,  to_nxt_cell(30), to_nxt_cell(31), system_output(15));
  output_bsr<=to_nxt_cell(31);
  end structural;