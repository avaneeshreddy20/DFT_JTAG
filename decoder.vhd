library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity decoder is 
  port( cell0, cell1, cell2, cell3  : IN std_logic;
        mode   : OUT std_logic;
        select_signal : OUT std_logic);
end entity decoder;

architecture behavioral of decoder is
  signal decoder_input : std_logic_vector(3 downto 0);
  begin
  decoder_input <= cell0 & cell1 & cell2 & cell3;
  process(decoder_input)
    begin
    case decoder_input is
      when "0000" => mode <= '1'; select_signal <= '0';  -- Selects boundary scan 
      when "1111" => mode <= 'U'; select_signal <= '1';  -- Mode is irrelevant here, it is bypass
      when "0001" => mode <= '0'; select_signal <= '0';  -- Normal 
      when "0010" => mode <= '1'; select_signal <= '0';  -- shift
      when others => mode <= 'U'; select_signal <= 'U'; 
    end case;
end process;
end architecture behavioral;