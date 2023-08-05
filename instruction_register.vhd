library IEEE;
use ieee.std_logic_1164.ALL;

entity instruction_register is
  port(
    tdi, clock_ir, shift_ir, update_ir : IN std_logic;
    system_pin : IN std_logic_vector(3 downto 0);
    Q1,Q2, Q3, Q4,ir_tdo : OUT std_logic
  );
end entity;

architecture structural of instruction_register is
  
  component mux is
    port (a, b, s : in std_logic;
          y : out std_logic); 
  end component;
  
  component rising_flipflop is
    port(
      D,clk: IN std_logic;
      Q : OUT std_logic
    );
  end component;
  
  component falling_flipflop is
      port(
        D,clk: IN std_logic;
        Q : OUT std_logic
      );
    end component;
  
signal mux1, mux2, mux3, mux4, dff1, dff2, dff3, dff4, temp1, temp2, temp3, temp4 :std_logic;
begin
  
  
  o1 : mux port map(system_pin(3), tdi, shift_ir, temp1);
       mux1 <=  temp1;
  o2 : rising_flipflop port map(mux1, clock_ir, dff1);
    
  o3 : mux port map(system_pin(2), dff1, shift_ir, temp2);
       mux2 <=  temp2;
  o4 : rising_flipflop port map(mux2, clock_ir, dff2);
    
  o5 : mux port map(system_pin(1), dff2, shift_ir, temp3);
       mux3 <=  temp3;
  o6 : rising_flipflop port map(mux3, clock_ir, dff3);
  
  o7 : mux port map(system_pin(0), dff3, shift_ir, mux4);
       --mux4 <=  temp4;
  o8 : rising_flipflop port map(mux4, clock_ir, dff4);    
      
  o9  : falling_flipflop port map(dff1, update_ir, Q1);
  o10 : falling_flipflop port map(dff2, update_ir, Q2);
  o11 : falling_flipflop port map(dff3, update_ir, Q3);
  o12 : falling_flipflop port map(dff4, update_ir, Q4);

  ir_tdo <= dff4;
end structural; 
   
  
