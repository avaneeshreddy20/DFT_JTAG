-----------------------------------------
-- Test Bench for IP Boundary Scan     --
-- performed 4 modes of Boundary Scan  --
-----------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ip_bsc_tb is
end entity ip_bsc_tb;

architecture behavioral of ip_bsc_tb is
component ip_bsc is 
port(   clock_dr     : IN std_logic;
        update_dr    : IN std_logic;
        shift_dr     : IN std_logic;
        system_input : IN std_logic;
        mode         : IN std_logic;
        last_cell    : IN std_logic;
        next_cell    : OUT std_logic;
     system_logic_in : OUT std_logic);
end component ip_bsc; 

signal clock_dr:std_logic := '0';
signal update_dr:std_logic := '1';
constant c_CLK_PERIOD : time := 10 ns; 
signal shift_dr, system_input, mode, last_cell, next_cell, system_logic_in : std_logic;

begin
  
  ip_bsc_operation: ip_bsc port map(clock_dr => clock_dr, update_dr => update_dr, shift_dr => shift_dr, system_input => system_input, mode => mode, last_cell => last_cell, next_cell => next_cell, system_logic_in => system_logic_in);
       
     process
       begin
         mode <= '0';          --normal mode
         system_input <= '1';
         wait for c_CLK_PERIOD;
      ---------------------------------------------------
        
         mode<='1';            -- shift mode
         system_input <= '0';  -- scan mode
         shift_dr <= '0';
         last_cell <= '1';
         
         
         wait for c_CLK_PERIOD/2;
         clock_dr <= '1';
         wait for c_CLK_PERIOD/2;
         clock_dr <= '0';
         wait for c_CLK_PERIOD/2;
         
         update_dr <= '0';
         wait for c_CLK_PERIOD/2;
         update_dr <= '1';
         
         wait for c_CLK_PERIOD;         
      -------------------------------------------------
         shift_dr <= '1';
         mode<='1';

         wait for c_CLK_PERIOD/2;
         clock_dr <= '1';
         wait for c_CLK_PERIOD/2;
         clock_dr <= '0';
         wait for c_CLK_PERIOD/2;
         
         update_dr <= '0';
         wait for c_CLK_PERIOD/2;
         update_dr <= '1';
         wait for c_CLK_PERIOD/2;
         wait for c_CLK_PERIOD;
                                        
       end process;
     end architecture behavioral;