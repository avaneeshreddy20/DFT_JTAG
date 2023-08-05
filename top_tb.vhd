--------------------------------------
-- Test Bench for JTAG + MULTIPLIER --
--------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity top_tb is
end top_tb;

architecture behavioral of top_tb is
  
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

constant c_CLK_PERIOD : time := 10ns;
signal tms,tck,tdi,tdo,trst:std_logic;
signal A,B :std_logic_vector(7 downto 0);
signal C:std_logic_vector(15 downto 0);

begin
top_operation : top_module port map (tms=>tms,tck=>tck,trst => trst, tdi=>tdi, input_A => A, input_B => B, output_C => C, tdo => tdo);

clk_proc : process
  begin
  tck<='0'; wait for c_CLK_PERIOD/2;
  tck<='1'; wait for c_CLK_PERIOD/2;
end process;

main:process
  variable loop_count1  : integer := 0;
  variable loop_count2  : integer := 0;
  variable loop_count3  : integer := 0;
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
  tms<='0'; tdi<='1'; wait for c_CLK_PERIOD;
  tms<='0'; tdi<='0'; wait for c_CLK_PERIOD;
  tms<='0'; tdi<='0'; wait for c_CLK_PERIOD;
  tms<='1'; tdi<='0'; wait for c_CLK_PERIOD;

---------- Wait at test Idle ------------
  tms<='1'; wait for c_CLK_PERIOD;
  tms<='0'; wait for c_CLK_PERIOD;
  tms<='0'; wait for c_CLK_PERIOD;
 
   ---------------------- Test cases --------------------
  A <= "01110000"; B <= "10001111"; wait for c_CLK_PERIOD;
  A <= "00000010"; B <= "00000011"; wait for c_CLK_PERIOD;
  A <= "00000000"; B <= "00001000"; wait for c_CLK_PERIOD;
  A <= "00001111"; B <= "11110000"; wait for c_CLK_PERIOD;
  A <= "00110011"; B <= "00001100"; wait for c_CLK_PERIOD;
  A <= "01001001"; B <= "10000000"; wait for c_CLK_PERIOD;
  A <= "00001100"; B <= "00000100"; wait for c_CLK_PERIOD;
  A <= "10001000"; B <= "00000010"; wait for c_CLK_PERIOD;
  A <= "01000000"; B <= "10111111"; wait for c_CLK_PERIOD;
  wait for 5*c_CLK_PERIOD; 
  
------------------------------------------
--_____________BYPASS_______________--
------------------------------------------

 tms<='1'; wait for c_CLK_PERIOD;
 tms<='1'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;

---------- Load Instruction ------------
 tms<='0'; tdi<='1'; wait for c_CLK_PERIOD;
 tms<='0'; tdi<='1'; wait for c_CLK_PERIOD;
 tms<='0'; tdi<='1'; wait for c_CLK_PERIOD;
 tms<='1'; tdi<='1'; wait for c_CLK_PERIOD;

---------- Wait at test Idle ------------
 tms<='1'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;
 
  ---- Go to Shift-DR State -----
 tms<='1'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;

  ------ Send TDI to TDO via BYPASS -----
  while loop_count1 <= 4 loop
    tdi<='1'; 
    wait for c_CLK_PERIOD;
    loop_count1 := loop_count1 + 1;
  end loop; 

  while loop_count2 <= 4 loop
    tdi<='0';  
    wait for c_CLK_PERIOD;
    loop_count2 := loop_count2 + 1;
  end loop; 

  while loop_count3<= 7 loop
    tdi<= not tdi; 
    wait for c_CLK_PERIOD;
    loop_count3 := loop_count3 + 1;
  end loop; 
  
  tdi<='0'; tms<='1'; wait for c_CLK_PERIOD;

-----Wait at Test Idle Reset
 tms<='1'; wait for c_CLK_PERIOD;
 tms<='0'; wait for c_CLK_PERIOD;
 tms<='0'; wait for 5*c_CLK_PERIOD;
 
------------------------------------------
--_____________BOUNDARY SCAN_______________--
------------------------------------------
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