
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_module is 
  port (
        tms          : IN std_logic;
        tck          : IN std_logic;
        trst         : IN std_logic;
        tdi          : IN std_logic;
        input_A      : IN std_logic_vector(7 downto 0);
        input_B      : IN std_logic_vector(7 downto 0);
        output_C     : OUT std_logic_vector(15 downto 0);
        tdo          : OUT std_logic);
end entity;

architecture structural of top_module is
  
component tap_controller is
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
  end component;
    
component instruction_register is
  port(
        tdi, clock_ir, shift_ir, update_ir : IN std_logic;
        system_pin : IN std_logic_vector(3 downto 0);
        Q1,Q2, Q3, Q4, ir_tdo : OUT std_logic);
end component; 

component decoder is 
  port( 
        cell0, cell1, cell2, cell3  : IN std_logic;
        mode   : OUT std_logic;
        select_signal : OUT std_logic);
end component;

component boundary_scan is 
 port ( 
       shift_dr        : IN std_logic;
       mode            : IN std_logic;
       system_input_A  : IN std_logic_vector(7 downto 0);
       system_input_B  : IN std_logic_vector(7 downto 0);
       system_output   : OUT std_logic_vector(15 downto 0);
       clock_dr        : IN std_logic; 
       update_dr       : IN std_logic;
       tdi             : IN std_logic;
       output_bsr      : OUT std_logic;
       system_logic_in : OUT std_logic_vector(15 downto 0);
       system_logic_out: IN std_logic_vector(15 downto 0));
end component;

component mux is
  port (
        a, b, s : IN std_logic;
         y      : OUT std_logic);
end component;

component rising_flipflop is
    port(
         D,clk  : IN std_logic;
         Q      : OUT std_logic);
end component;
  
component bypass is
  port(
        tdi      : IN std_logic;
        shift_dr : IN std_logic;
        clock_dr : IN std_logic;
        tdo      : OUT std_logic);
end component ;

component multi_8bit is
  Port ( 
        a : IN std_logic_vector (7 downto 0);
        x : IN std_logic_vector (7 downto 0);
        p : OUT std_logic_vector (15 downto 0));
end component; 

signal ir1, ir2, ir3, ir4 : std_logic;
signal system_pin : std_logic_vector(3 downto 0);
signal instructionReg_to_mux2, mux2_output: std_logic;
signal system_logic_in, system_logic_out : std_logic_vector(15 downto 0);
signal mode, boundaryScan_to_mux1, bypass_to_mux1, decoder_select,mux1_to_mux2: std_logic;
signal tlr, nottck, shift_dr_out, shift_ir_out, update_dr_out, update_ir_out, clock_dr_out, clock_ir_out, tap_select: std_logic;

begin
  nottck <= not tck;
  TAP_CONROLLER_OPERATION        : tap_controller port map(tms, tck, trst, tlr, shift_dr_out, shift_ir_out, update_dr_out, update_ir_out, clock_dr_out, clock_ir_out, tap_select);
  INSTRUCTION_REGISTER_OPERATION : instruction_register port map(tdi, clock_ir_out, shift_ir_out, update_ir_out, system_pin, ir1, ir2, ir3, ir4, instructionReg_to_mux2);
  DECODER_OPERATION              : decoder port map(ir1, ir2, ir3, ir4, mode, decoder_select);
  BOUNDARY_SCAN_OPERATION        : boundary_scan port map(shift_dr_out, mode, input_A, input_B, output_C, clock_dr_out, update_dr_out,tdi,boundaryScan_to_mux1,system_logic_in,system_logic_out);
  BYPASS_OPERATON                : bypass port map(tdi, shift_dr_out, clock_dr_out, bypass_to_mux1);
  MULTIPLIER                     : multi_8bit port map(system_logic_in(7 downto 0), system_logic_in(15 downto 8), system_logic_out);
  MUX1_OPERATION                 : mux port map(boundaryScan_to_mux1, bypass_to_mux1, decoder_select, mux1_to_mux2);
  MUX2_OPERATION                 : mux port map(mux1_to_mux2, instructionReg_to_mux2, tap_select, mux2_output);
  D_FLIPFLOP_OPERATION           : rising_flipflop port map(mux2_output, nottck, tdo);
end architecture structural;