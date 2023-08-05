
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity op_bsc is
 port(clock_dr       : IN std_logic;
      update_dr     : IN std_logic;
      shift_dr      : IN std_logic;
      system_logic_out  : IN std_logic;
      mode          : IN std_logic;
      last_cell     : IN std_logic;
      next_cell     : OUT std_logic;
      system_output : OUT std_logic
      );
end entity op_bsc;

architecture behavioral of op_bsc is
  signal ff1_d, ff1_q, ff2_d, ff2_q : std_logic;
    begin
    process(clock_dr)
      begin
      if (rising_edge(clock_dr)) then
        ff1_q <= ff1_d;  
      end if;
    end process;
  
    ff1_d <= system_logic_out when shift_dr = '0' else last_cell when shift_dr = '1';
  
    process(update_dr)
      begin
      if (falling_edge(update_dr)) then
        ff2_q <= ff2_d;  
      end if;
    end process;
    
    next_cell <= ff1_q;
    ff2_d <= ff1_q;
    system_output <= system_logic_out when mode = '0' else ff2_q when mode = '1';
end architecture behavioral;