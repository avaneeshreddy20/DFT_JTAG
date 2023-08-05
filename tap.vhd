library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tap_controller is
port ( 
  tms          : IN std_logic;
  tck          : IN std_logic;
  trst         : IN std_logic;
  tlr          : OUT std_logic;
  shift_dr_out : OUT std_logic;
  shift_ir_out : OUT std_logic;
  update_dr_out: OUT std_logic;
  update_ir_out: OUT std_logic;
  clock_dr_out : OUT std_logic;
  clock_ir_out : OUT std_logic;
  tap_select   : OUT std_logic);
end entity tap_controller;

architecture behavioral of tap_controller is 

type state is (test_logic_reset, run_test_idle,select_dr_scan,capture_dr,shift_dr,exit1_dr,pause_dr,exit2_dr,update_dr,
               select_ir_scan,capture_ir,shift_ir,exit1_ir,pause_ir,exit2_ir,update_ir);
               
signal present_state, next_state: state := test_logic_reset;
begin
 
process(tck, trst)
    begin
      if(trst = '0') then present_state <= test_logic_reset;
      elsif (rising_edge(tck)) then present_state <= next_state;
    end if;
end process;


process(present_state, tms, tck)
  begin
    next_state <= present_state;
     case present_state is  
       
      when test_logic_reset => 
        if(tms = '0') then next_state <= run_test_idle;
        end if;
        tlr <= '1';
        shift_ir_out  <= '0';
        shift_dr_out  <= '0';
        
      when run_test_idle =>
        tlr <= '0';
        if (tms = '1') then next_state <= select_dr_scan;
        end if;
    
      when select_dr_scan =>
        if(tms = '1') then next_state <= select_ir_scan;
        else next_state<= capture_dr;
        end if; 
        
      when capture_dr =>
        if(tms = '1') then next_state <= exit1_dr;
        else next_state <= shift_dr;
        end if;
        tap_select <= '0';
    
      when shift_dr =>
        if(tms = '1') then next_state <= exit1_dr;
        end if;
          
        shift_dr_out <= '1';
        tap_select <= '0';
    
        if (rising_edge(tck)) then clock_dr_out <= '1';
        elsif (falling_edge(tck)) then clock_dr_out <= '0'; 
        end if;
        
      when exit1_dr =>
        if (tms = '1') then next_state <= update_dr;
        else next_state <= pause_dr;
        end if;
        shift_dr_out <= '0';
        tap_select <= '0';

      when pause_dr =>
        if (tms = '1') then next_state <= exit2_dr;
        end if;

      when exit2_dr =>
        if (tms = '1') then next_state <= update_dr;
        else next_state <= shift_dr;
        end if;

      when update_dr =>
        if (tms = '1') then next_state <= select_dr_scan;
        else next_state <= run_test_idle;
        end if;
        
        if(falling_edge(tck)) then update_dr_out <= '1';
        elsif(rising_edge(tck)) then update_dr_out <= '0';
    end if;
        
--********* Instruction Register states **********
  
      when select_ir_scan =>
        if(tms = '1') then next_state <= test_logic_reset;
        else next_state<= capture_ir;
        end if;
          
      when capture_ir =>
        if(tms = '1') then next_state <= exit1_ir;
        else next_state <= shift_ir;
        end if;
      tap_select <= '1';
        
      when shift_ir =>
       if(tms = '1') then next_state <= exit1_ir;
       end if;
       shift_ir_out <= '1';
       tap_select <= '1';
       if (rising_edge(tck)) then clock_ir_out <= '1';
       elsif (falling_edge(tck)) then clock_ir_out <= '0';
       end if;
      
      when exit1_ir => 
        if (tms = '1') then next_state <= update_ir;
        else next_state <= pause_ir;
        end if;
      shift_ir_out <= '0';
      tap_select <= '1';
     
      when pause_ir =>
        if (tms = '1') then next_state <= exit2_ir;
        end if;
  
      when exit2_ir =>
        if (tms = '1') then next_state <= update_ir;
        else next_state <= shift_ir;
        end if;
  
      when update_ir =>
        if (tms = '1') then next_state <= select_dr_scan;
        else next_state <= run_test_idle;
        end if;
       
       if (falling_edge(tck)) then update_ir_out <= '1';
       elsif(rising_edge(tck)) then update_ir_out <= '0';
       end if;  
end case;
end process;
end architecture behavioral;
  