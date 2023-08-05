library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mult_tb is 
end entity mult_tb;

architecture behavioral of mult_tb is

component multi_8bit is
  Port ( a : in std_logic_vector (7 downto 0);
         x : in std_logic_vector (7 downto 0);
         p : out std_logic_vector (15 downto 0));
end component multi_8bit;

constant c_CLK_PERIOD : time := 10 ns;
signal a,b : std_logic_vector(7 downto 0);
signal   c : std_logic_vector(15 downto 0);


begin
  multiplication: multi_8bit port map(a=>a, x=>b, p=>c);
process 
  begin
    a <= "11111111"; b <= "01010101"; wait for c_CLK_PERIOD;
    
    a <= "00000000"; b <= "01110101"; wait for c_CLK_PERIOD;
        
    a <= "00000010"; b <= "00001000"; wait for c_CLK_PERIOD;
            
    a <= "11110000"; b <= "11111111"; wait for c_CLK_PERIOD;
                
    a <= "10101010"; b <= "10101010"; wait for c_CLK_PERIOD;
                    
    a <= "00000111"; b <= "00001000"; wait for c_CLK_PERIOD;
                        
    a <= "11001100"; b <= "00110011"; wait for c_CLK_PERIOD;
                            
    a <= "11111110"; b <= "00000001"; wait for c_CLK_PERIOD;                      
end process;
end architecture;