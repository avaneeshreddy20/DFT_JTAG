--------------------------------------------------
-- Test Bench for TAP Controller                --
-- Expected Output: Generation of below signals --
-- clock_ir_out, update_ir_out, shift_ir_out    --
-- Testing of TRST signal is also done          --
--------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity tap_tb is
end entity ;


architecture behavioral of tap_tb is
  component tap_controller is port(  
  tms          : IN std_logic;
  tck          : IN std_logic;
  trst         : IN std_logic;
  tlr          : OUT std_logic;
  shift_dr_out : OUT std_logic;
  shift_ir_out : OUT std_logic;
  update_dr_out: OUT std_logic;
  update_ir_out: OUT std_logic;
  clock_dr_out : OUT std_logic;
  clock_ir_out : OUT std_logic;
  tap_select : OUT std_logic);
end component;

signal trst : STD_LOGIC := '1';
constant c_CLK_PERIOD : time := 10 ns;
signal tck, tms,tlr,shift_dr_out, shift_ir_out,update_dr_out, update_ir_out, clock_dr_out, clock_ir_out, tap_select:STD_LOGIC;

begin 
  TAP_operation:tap_controller port map(tck=>tck,trst=>trst,tlr=>tlr,shift_dr_out=>shift_dr_out,tms=>tms,
                            shift_ir_out=>shift_ir_out,update_dr_out=>update_dr_out,update_ir_out=>update_ir_out,clock_dr_out=>clock_dr_out,clock_ir_out=>clock_ir_out, tap_select=>tap_select);

p_CLK : process
 begin
   tck <= '0';
   wait for c_CLK_PERIOD/2;
   tck<='1';
   wait for c_CLK_PERIOD/2;
 end process p_CLK;
 
 process
   begin
     trst <= '1';
     tms<='1'; wait for 5*c_CLK_PERIOD;
     
     tms<='0'; wait for c_CLK_PERIOD;
     tms<='1'; wait for c_CLK_PERIOD;  
     tms<='1'; wait for c_CLK_PERIOD;       
     tms<='0'; wait for c_CLK_PERIOD;           
     tms<='0'; wait for c_CLK_PERIOD;           
            
     tms<='0'; wait for c_CLK_PERIOD;
     tms<='0'; wait for c_CLK_PERIOD;
     tms<='0'; wait for c_CLK_PERIOD;
     tms<='1'; wait for c_CLK_PERIOD;
     
     tms<='1'; wait for c_CLK_PERIOD;
     tms<='0'; wait for c_CLK_PERIOD;
     tms<='0'; wait for c_CLK_PERIOD;   
     
     -- Hard Reset testing using trst irrespective of TMS
     trst <= '1'; wait for c_CLK_PERIOD/2;
     trst <= '0'; wait for c_CLK_PERIOD/2;
  end process;
  end architecture behavioral;
                   