--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:37:42 12/01/2017
-- Design Name:   
-- Module Name:   C:/Users/equipo/Desktop/arquitectura/EX_MEM/EX_MEM_tb.vhd
-- Project Name:  EX_MEM
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EX_MEM
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
 
ENTITY EX_MEM_tb IS
END EX_MEM_tb;
 
ARCHITECTURE behavior OF EX_MEM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EX_MEM
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         CRD_IN : IN  std_logic_vector(31 downto 0);
         ALU_RESULT_IN : IN  std_logic_vector(31 downto 0);
         CRD_OUT : OUT  std_logic_vector(31 downto 0);
         ALU_RESULT_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal CRD_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_RESULT_IN : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal CRD_OUT : std_logic_vector(31 downto 0);
   signal ALU_RESULT_OUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EX_MEM PORT MAP (
          CLK => CLK,
          RST => RST,
          CRD_IN => CRD_IN,
          ALU_RESULT_IN => ALU_RESULT_IN,
          CRD_OUT => CRD_OUT,
          ALU_RESULT_OUT => ALU_RESULT_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '1';
      wait for 15 ns;	
		RST <= '0';
		CRD_IN <= "10100000000100000010000011111000";
		ALU_RESULT_IN <= "10100000000100000010000000001111";
		wait for 10 ns;
		CRD_IN <= "10100000000100000010000000000000";
		ALU_RESULT_IN <= "10100000000100000000000000000000";
		
		
      -- insert stimulus here 

      wait;
   end process;

END;
