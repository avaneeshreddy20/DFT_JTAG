library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
 
 entity FA_tb is
 end entity FA_tb;
 
 
architecture behavioral of FA_tb is
  
component fullAdder is
 Port ( A : in STD_LOGIC;
        B : in STD_LOGIC;
      Cin : in STD_LOGIC;
        S : out STD_LOGIC;
     Cout : out STD_LOGIC);
end component fullAdder;
 

constant c_CLK_PERIOD : time := 10 ns;
signal a,b,cin,s,cout : STD_LOGIC;

begin
  FA_Operation : fullAdder port map(A=>a, B=>b, Cin=>cin, S=>s, Cout=>cout);
  process
    begin
      a<='0';b<='0';cin<='0'; wait for c_CLK_PERIOD;
      a<='0';b<='0';cin<='1'; wait for c_CLK_PERIOD;
      a<='0';b<='1';cin<='0'; wait for c_CLK_PERIOD;
      a<='0';b<='1';cin<='1'; wait for c_CLK_PERIOD;
      a<='1';b<='0';cin<='0'; wait for c_CLK_PERIOD;
      a<='1';b<='0';cin<='1'; wait for c_CLK_PERIOD;
      a<='1';b<='1';cin<='0'; wait for c_CLK_PERIOD;
      a<='1';b<='1';cin<='1'; wait for c_CLK_PERIOD;      
end process;
end architecture;
