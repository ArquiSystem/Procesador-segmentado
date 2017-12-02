--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:00:00 12/01/2017
-- Design Name:   
-- Module Name:   C:/Users/equipo/Desktop/arquitectura/Instruction_Fetch/Instruction_Fetch_tb.vhd
-- Project Name:  Instruction_Fetch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Instruction_Fetch
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
 
ENTITY Instruction_Fetch_tb IS
END Instruction_Fetch_tb;
 
ARCHITECTURE behavior OF Instruction_Fetch_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Instruction_Fetch
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         MUX_TO_PC : IN  std_logic_vector(31 downto 0);
         PC_OUT : OUT  std_logic_vector(31 downto 0);
         SUMA_OUT : OUT  std_logic_vector(31 downto 0);
         INSTRUCTION_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal MUX_TO_PC : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal PC_OUT : std_logic_vector(31 downto 0);
   signal SUMA_OUT : std_logic_vector(31 downto 0);
   signal INSTRUCTION_OUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Instruction_Fetch PORT MAP (
          CLK => CLK,
          RST => RST,
          MUX_TO_PC => MUX_TO_PC,
          PC_OUT => PC_OUT,
          SUMA_OUT => SUMA_OUT,
          INSTRUCTION_OUT => INSTRUCTION_OUT
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
		MUX_TO_PC <= "00000000000000000000000000000000";
		wait for 10 ns;
		MUX_TO_PC <= "00000000000000000000000000000001";
		wait for 10 ns;
		MUX_TO_PC <= "00000000000000000000000000000010";
		wait for 10 ns;
		MUX_TO_PC <= "00000000000000000000000000000011";
		
      -- insert stimulus here 

      wait;
   end process;

END;
