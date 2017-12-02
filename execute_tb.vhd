--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:18:26 12/01/2017
-- Design Name:   
-- Module Name:   C:/Users/Daniel/Documents/Arquitectura/Excecute/execute_tb.vhd
-- Project Name:  Excecute
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: execute
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
 
ENTITY execute_tb IS
END execute_tb;
 
ARCHITECTURE behavior OF execute_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT execute
    PORT(
         aluop : IN  std_logic_vector(5 downto 0);
         crs1 : IN  std_logic_vector(31 downto 0);
         crs2 : IN  std_logic_vector(31 downto 0);
         seu : IN  std_logic_vector(31 downto 0);
         cwp : IN  std_logic_vector(0 downto 0);
         ncwp : OUT  std_logic_vector(0 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         i : IN  std_logic;
         alu_result : OUT  std_logic_vector(31 downto 0);
         icc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal aluop : std_logic_vector(5 downto 0) := (others => '0');
   signal crs1 : std_logic_vector(31 downto 0) := (others => '0');
   signal crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal seu : std_logic_vector(31 downto 0) := (others => '0');
   signal cwp : std_logic_vector(0 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal i : std_logic := '0';

 	--Outputs
   signal ncwp : std_logic_vector(0 downto 0);
   signal alu_result : std_logic_vector(31 downto 0);
   signal icc : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: execute PORT MAP (
          aluop => aluop,
          crs1 => crs1,
          crs2 => crs2,
          seu => seu,
          cwp => cwp,
          ncwp => ncwp,
          clk => clk,
          rst => rst,
          i => i,
          alu_result => alu_result,
          icc => icc
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		aluop <= "000100";
		crs2 <= "00000000000000000000000000000001";
		crs1 <= "00000000000000000000000000000010";
		seu <= "00000000000000000000000000000000";
		cwp <= "0";
		i <= '0';
      wait;
   end process;

END;
