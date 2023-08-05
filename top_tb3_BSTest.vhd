-----------------------------------------
-- Test Bench for Sample/Preload Mode  --
-- Input  : TDI/System Pins            --
-- Output : TDO/ System_Logic_in       --
-----------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity top_tb3 is

end top_tb3;

architecture behavioral of top_tb3 is
  
 component top_module is
  port (
    tms          : IN std_logic;
    tck          : IN std_logic;
    trst         : IN std_logic;
    tdi          : IN std_logic;
    input_A      : IN std_logic_vector(7 downto 0);
    input_B      : IN std_logic_vector(7 downto 0);
    output_C     : OUT std_logic_vector(15 downto 0);
    tdo          : OUT std_logic);
end component;

signal tms,tck,tdi,tdo,trst:std_logic;
signal A,B :std_logic_vector(7 downto 0);
signal C:std_logic_vector(15 downto 0);

constant c_CLK_PERIOD : time := 10ns;
begin
top_operation : top_module port map (tms=>tms,tck=>tck,trst => trst, tdi=>tdi, input_A => A, input_B => B, output_C => C, tdo => tdo);

clk_proc : process
  begin
  tck<='0';
  wait for c_CLK_PERIOD/2;
  tck<='1';
  wait for c_CLK_PERIOD/2;
end process;

main:process
  begin
  trst <= '1';

--------- Tap reset ------------
  tms<='1'; wait for c_CLK_PERIOD;
  tms<='1'; wait for c_CLK_PERIOD;
  tms<='1'; wait for c_CLK_PERIOD;
  tms<='1'; wait for c_CLK_PERIOD;
  tms<='1'; wait for c_CLK_PERIOD;

 ---------- In Shift State ------------
  tms<='0'; wait for c_CLK_PERIOD;
  tms<='1'; wait for c_CLK_PERIOD;
  tms<='1'; wait for c_CLK_PERIOD;
  tms<='0'; wait for c_CLK_PERIOD;
  tms<='0'; wait for c_CLK_PERIOD;

---------- Load Instruction ------------
 tms<='0'; tdi<='0'; wait for c_CLK_PERIOD;
 tms<='0'; tdi<='1'; wait for c_CLK_PERIOD;
 tms<='0'; tdi<='0'; wait for c_CLK_PERIOD;
 tms<='1'; tdi<='0'; wait for c_CLK_PERIOD;

---------- Wait at test Idle ------------
 tms<='1'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;
 
---------- Go to Shift State ------------
 tms<='1'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;

-------- Send TDI to System Logic IN  ------
 for i in 1 to 8 loop
   tdi<= not tdi;  
   wait for c_CLK_PERIOD;
end loop; 

for i in 1 to 4 loop
  tdi<='1';  
  wait for c_CLK_PERIOD;
end loop; 

for i in 1 to 3 loop
  tdi<='0';  
  wait for c_CLK_PERIOD;
end loop; 
 
tms<='1'; tdi<='0'; wait for c_CLK_PERIOD;

-----Wait at Test Idle Reset
 tms<='1'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;
 tms<='0';  wait for c_CLK_PERIOD;
 wait;
end process;
end architecture behavioral;