library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bsr_tb is
end bsr_tb;

architecture behavioral of bsr_tb is  
  component  boundary_scan is 
 port ( 
       shift_dr        : IN std_logic;
       mode            : IN std_logic;
       system_input_A  : IN std_logic_vector(7 downto 0);
       system_input_B  : IN std_logic_vector(7 downto 0);
       system_output   : OUT std_logic_vector(15 downto 0);
       clock_dr        : IN std_logic; 
       update_dr       : IN std_logic;
       tdi             : IN std_logic;
       system_logic_in : OUT std_logic_vector(15 downto 0);
       system_logic_out: IN std_logic_vector(15 downto 0));
end component boundary_scan;

signal   shift_dr,mode,sys_clk,tdi,tdo:std_logic;
signal   system_input_A,system_input_B:std_logic_vector(7 downto 0);
signal   system_output, system_logic_in,system_logic_out:std_logic_vector(15 downto 0);
signal   clock_dr:std_logic := '0';
signal   update_dr:std_logic := '1';
signal   clk: std_logic;
constant c_CLK_PERIOD : time := 10ns;

begin 
  BSR_Operation:boundary_scan
  port map
  (shift_dr=>shift_dr,mode=>mode,system_input_A=>system_input_A,system_input_B=>system_input_B,system_output=>system_output,clock_dr=>clock_dr,update_dr=>update_dr,tdi=>tdi,system_logic_in=>system_logic_in,system_logic_out=>system_logic_out);
  
  clk_proc : process
    begin
    clk<='0';
    wait for c_CLK_PERIOD/2;
    clk<='1';
    wait for c_CLK_PERIOD/2;
  end process;
  
  process
  begin
    mode<='0';                      -- Testing of Normal Mode
    system_input_A<="00110011";
    system_input_B<="00001111";
    wait for c_CLK_PERIOD;
    mode<='1';
    
    tdi<='0';                   
    shift_dr<='1';
    for i in 1 to 16 loop          -- TDI = 0000 0000 0000 0000 then System Logic In = 0000 0000 0000 0000
      wait for c_CLK_PERIOD/2;
      clock_dr<='1';
      wait for c_CLK_PERIOD/2;      
      clock_dr<='0';
    end loop;
      
    wait for c_CLK_PERIOD/2;
    update_dr<='0';
    wait for c_CLK_PERIOD/2;
    update_dr<='1';      

      
    tdi<='1';
    shift_dr<='1';      
    for i in 1 to 32 loop          -- TDI = 1111 1111 1111 1111 then Output = 1111 1111 1111 1111
      wait for c_CLK_PERIOD/2;
      clock_dr<='1';
      wait for c_CLK_PERIOD/2;
      clock_dr<='0'; 
    end loop;
    
    wait for c_CLK_PERIOD/2;
    update_dr<='0';
    wait for c_CLK_PERIOD/2;
    update_dr<='1'; 

    end process;  
  end architecture behavioral;