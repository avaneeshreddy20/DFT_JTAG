-----------------------------------------
-- Test Bench for Instruction Register --
-- Data through TDI = 1->1->0->0       --
-- Expected Instruction Code = 0011    --
-----------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instruction_register_tb is
end entity instruction_register_tb;

architecture behavioral of instruction_register_tb is
  component instruction_register is  port(
    tdi, clock_ir, shift_ir, update_ir : IN std_logic;
    system_pin : IN std_logic_vector(3 downto 0);
    Q1,Q2, Q3, Q4, ir_tdo : OUT std_logic
  );
end component;

signal tdi,  shift_ir, q1, q2, q3, q4, ir_tdo: std_logic;
signal system_pin : std_logic_vector(3 downto 0);

signal tck : STD_LOGIC;
signal clock_ir:std_logic := '0';
signal update_ir:std_logic := '1';
constant c_CLK_PERIOD : time := 10 ns;  -- 10 MHz

begin
ir_operation : instruction_register port map(tdi, clock_ir, shift_ir, update_ir, system_pin,q1, q2, q3, q4,ir_tdo);

p_CLK : process
 begin
   tck <= '0';
   wait for c_CLK_PERIOD/2;
   tck<='1';
   wait for c_CLK_PERIOD/2;
 end process p_CLK;
 
process
  begin
    shift_ir <= '1';
    
    tdi <= '1';
    wait for c_CLK_PERIOD/2;
    clock_ir <= '1';
    wait for c_CLK_PERIOD/2;
    clock_ir <= '0';
    
    tdi <= '1';    
    wait for c_CLK_PERIOD/2;
    clock_ir <= '1';
    wait for c_CLK_PERIOD/2;
    clock_ir <= '0';
    
    tdi <= '0';
    wait for c_CLK_PERIOD/2;
    clock_ir <= '1';
    wait for c_CLK_PERIOD/2;
    clock_ir <= '0';
    
    tdi <= '0';
    wait for c_CLK_PERIOD/2;       
    clock_ir <= '1';
    wait for c_CLK_PERIOD/2;
    clock_ir <= '0';
    
    wait for c_CLK_PERIOD/2;
    update_ir <= '0';   
    wait for c_CLK_PERIOD/2;
    update_ir <= '1';
end process; 
end architecture behavioral;
