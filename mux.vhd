library ieee;
use ieee.std_logic_1164.all; 

entity mux is
  port (a, b, s : in std_logic;
        y : out std_logic); 
end mux;

architecture behavioral of mux is 
begin
  process (a,b,s)
  begin
    if s = '0' then
      y<= a;
    else
      y<= b;
    end if;
  end process;
end behavioral;
