--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:32:22 12/02/2017
-- Design Name:   
-- Module Name:   C:/Users/equipo/Desktop/arquitectura/Procesador segmentado/IF_ID/IF_ID_tb.vhd
-- Project Name:  IF_ID
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IF_ID
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
 
ENTITY IF_ID_tb IS
END IF_ID_tb;
 
ARCHITECTURE behavior OF IF_ID_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IF_ID
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         INSTRUCTION_IN : IN  std_logic_vector(31 downto 0);
         PC_IN : IN  std_logic_vector(31 downto 0);
         INSTRUCTION_OUT : OUT  std_logic_vector(31 downto 0);
         PC_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal INSTRUCTION_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_IN : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal INSTRUCTION_OUT : std_logic_vector(31 downto 0);
   signal PC_OUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IF_ID PORT MAP (
          CLK => CLK,
          RST => RST,
          INSTRUCTION_IN => INSTRUCTION_IN,
          PC_IN => PC_IN,
          INSTRUCTION_OUT => INSTRUCTION_OUT,
          PC_OUT => PC_OUT
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
		INSTRUCTION_IN <=  "00000000001110000010000011111001";
		PC_IN <=  "00000000000000000001111001100000";

      -- insert stimulus here 

      wait;
   end process;

END;
