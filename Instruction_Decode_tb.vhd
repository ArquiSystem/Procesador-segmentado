--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:32:30 12/01/2017
-- Design Name:   
-- Module Name:   C:/Users/equipo/Desktop/arquitectura/Procesador_Segmentado/Instruction_Decode_tb.vhd
-- Project Name:  Procesador_Segmentado
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Instruction_Decode
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Instruction_Decode_tb IS
END Instruction_Decode_tb;
 
ARCHITECTURE behavior OF Instruction_Decode_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Instruction_Decode
    PORT(
         RST : IN  std_logic;
         IN_INSTRUCTION : IN  std_logic_vector(31 downto 0);
         ICC : IN  std_logic_vector(3 downto 0);
         COND : IN  std_logic_vector(3 downto 0);
         CWP : IN  std_logic_vector(0 downto 0);
         DATA_TO_REG : IN  std_logic_vector(31 downto 0);
         RFSOURCE : OUT  std_logic_vector(1 downto 0);
         WRDENMEM : OUT  std_logic;
         PCSOURCE : OUT  std_logic_vector(1 downto 0);
         ALUOP : OUT  std_logic_vector(5 downto 0);
         cRD : OUT  std_logic_vector(31 downto 0);
         CRS1 : OUT  std_logic_vector(31 downto 0);
         CRS2 : OUT  std_logic_vector(31 downto 0);
         SEU : OUT  std_logic_vector(31 downto 0);
         NCWP : OUT  std_logic_vector(0 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal IN_INSTRUCTION : std_logic_vector(31 downto 0) := (others => '0');
   signal ICC : std_logic_vector(3 downto 0) := (others => '0');
   signal COND : std_logic_vector(3 downto 0) := (others => '0');
   signal CWP : std_logic_vector(0 downto 0) := (others => '0');
   signal DATA_TO_REG : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal RFSOURCE : std_logic_vector(1 downto 0);
   signal WRDENMEM : std_logic;
   signal PCSOURCE : std_logic_vector(1 downto 0);
   signal ALUOP : std_logic_vector(5 downto 0);
   signal cRD : std_logic_vector(31 downto 0);
   signal CRS1 : std_logic_vector(31 downto 0);
   signal CRS2 : std_logic_vector(31 downto 0);
   signal SEU : std_logic_vector(31 downto 0);
   signal NCWP : std_logic_vector(0 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Instruction_Decode PORT MAP (
          RST => RST,
          IN_INSTRUCTION => IN_INSTRUCTION,
          ICC => ICC,
          COND => COND,
          CWP => CWP,
          DATA_TO_REG => DATA_TO_REG,
          RFSOURCE => RFSOURCE,
          WRDENMEM => WRDENMEM,
          PCSOURCE => PCSOURCE,
          ALUOP => ALUOP,
          cRD => cRD,
          CRS1 => CRS1,
          CRS2 => CRS2,
          SEU => SEU,
          NCWP => NCWP
        );


   -- Stimulus process
   stim_proc: process
   begin		
      
		RST <= '1';
		wait for 100 ns;	
		RST <= '0';
		IN_INSTRUCTION <= "10100000000100000010000000001000";
		COND <= "0000";
		ICC <= "0000";
		CWP <= "0";
		DATA_TO_REG <= "01111111111111010111111111011111";

		
      -- insert stimulus here 

      wait;
   end process;

END;
