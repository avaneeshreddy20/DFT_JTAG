library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bypass is
  port(tdi : IN std_logic;
  shift_dr : IN std_logic;
  clock_dr : IN std_logic;
  tdo : OUT std_logic);
end entity bypass;


architecture structural of bypass is
  signal ff_d : std_logic;
 
  component myAND
    port(a,b : in std_logic; y: out std_logic);
  end component;
  
  component rising_flipflop is
    port(
      D,clk: IN std_logic;
      Q : OUT std_logic
    );
  end component;
  
  begin
    ff_input: myAND port map(tdi,shift_dr,ff_d);
   ff_output: rising_flipflop port map(ff_d, clock_dr, tdo);
end architecture structural;