library IEEE;
use ieee.std_logic_1164.ALL;

entity falling_flipflop is
  port(
    D,clk: IN std_logic;
    Q : OUT std_logic
  );
end entity;

architecture behavioral of falling_flipflop is
begin
  process(clk)
  begin
    if(falling_edge(clk)) then Q<=D;
    end if;
  end process;
end behavioral;
 