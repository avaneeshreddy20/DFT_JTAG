library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bypass_tb is 
end entity;

architecture behavioral of bypass_tb is

component bypass is
port(
     tdi      : IN std_logic;
     shift_dr : IN std_logic;
     clock_dr : IN std_logic;
     tdo      : OUT std_logic);
end component;

signal tck : STD_LOGIC;
signal clock_dr:std_logic := '0';
signal tdi, shift_dr,tdo : std_logic;
constant c_CLK_PERIOD : time := 10ns;

begin
bypass_operation : bypass port map (tdi=>tdi, shift_dr=>shift_dr, clock_dr=>clock_dr, tdo=>tdo);


p_CLK : process
 begin
   tck <= '0';
   wait for c_CLK_PERIOD/2;
   tck<='1';
   wait for c_CLK_PERIOD/2;
 end process p_CLK;
 
process
begin
  shift_dr<='1';
  
for i in 1 to 4 loop
  tdi<='1';  
  wait for c_CLK_PERIOD/2;
  clock_dr<='1';
  wait for c_CLK_PERIOD/2;
  clock_dr<='0';
end loop; 

for i in 1 to 4 loop
  tdi<='0';  
  wait for c_CLK_PERIOD/2;
  clock_dr<='1';
  wait for c_CLK_PERIOD/2;
  clock_dr<='0';
end loop; 

for i in 1 to 8 loop
  tdi<= not tdi;  
  wait for c_CLK_PERIOD/2;
  clock_dr<='1';
  wait for c_CLK_PERIOD/2;
  clock_dr<='0';
end loop; 
 
  end process;  
end architecture behavioral;