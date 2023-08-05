------------------------------------------
-- Test Bench for Instruction Decoder   --
-- Given Input : IR 4-flipflops output  --
-- Expected output : mode and Select    --
------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_tb is
end entity;

architecture behavioral of decoder_tb is
  component decoder is 
  port(cell0, cell1, cell2, cell3  : IN std_logic;
        mode   : OUT std_logic;
        select_signal : OUT std_logic);
  end component;
  
  signal cell0, cell1, cell2, cell3, mode, select_signal : std_logic;
  constant c_CLK_PERIOD : time := 10ns;
  begin
  decoder_operation: decoder port map(cell0, cell1, cell2, cell3, mode, select_signal);
  
process
  begin
    cell0 <= '0'; cell1 <= '0';cell2 <= '0';cell3 <= '0'; wait for c_CLK_PERIOD;
    cell0 <= '1'; cell1 <= '1';cell2 <= '1';cell3 <= '1'; wait for c_CLK_PERIOD;
    cell0 <= '0'; cell1 <= '0';cell2 <= '0';cell3 <= '1'; wait for c_CLK_PERIOD;
    cell0 <= '0'; cell1 <= '0';cell2 <= '1';cell3 <= '0'; wait for c_CLK_PERIOD;    
    cell0 <= '0'; cell1 <= '1';cell2 <= '1';cell3 <= '0'; wait for c_CLK_PERIOD;     
end process;
end architecture behavioral;
