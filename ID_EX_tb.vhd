--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:40:30 12/02/2017
-- Design Name:   
-- Module Name:   C:/Users/equipo/Desktop/arquitectura/Procesador segmentado/Procesador_Segmentado/ID_EX_tb.vhd
-- Project Name:  Procesador_Segmentado
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ID_EX
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
 
ENTITY ID_EX_tb IS
END ID_EX_tb;
 
ARCHITECTURE behavior OF ID_EX_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ID_EX
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         DISP22_IN : IN  std_logic_vector(31 downto 0);
         DISP30_IN : IN  std_logic_vector(31 downto 0);
         DISP22_OUT : OUT  std_logic_vector(31 downto 0);
         DISP30_OUT : OUT  std_logic_vector(31 downto 0);
         RFSOURCE_IN : IN  std_logic_vector(1 downto 0);
         WRENMEM_IN : IN  std_logic;
         ALUOP_IN : IN  std_logic_vector(5 downto 0);
         PCSOURCE_IN : IN  std_logic_vector(1 downto 0);
         CRD_IN : IN  std_logic_vector(31 downto 0);
         CRS1_IN : IN  std_logic_vector(31 downto 0);
         CRS2_IN : IN  std_logic_vector(31 downto 0);
         i_IN : IN  std_logic;
         SEU_IN : IN  std_logic_vector(31 downto 0);
         PC_IN : IN  std_logic_vector(31 downto 0);
         PC_OUT : OUT  std_logic_vector(31 downto 0);
         RFSOURCE_OUT : OUT  std_logic_vector(1 downto 0);
         WRENMEM_OUT : OUT  std_logic;
         ALUOP_OUT : OUT  std_logic_vector(5 downto 0);
         PCSOURCE_OUT : OUT  std_logic_vector(1 downto 0);
         CRD_OUT : OUT  std_logic_vector(31 downto 0);
         CRS1_OUT : OUT  std_logic_vector(31 downto 0);
         CRS2_OUT : OUT  std_logic_vector(31 downto 0);
         i_OUT : OUT  std_logic;
         SEU_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal DISP22_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal DISP30_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal RFSOURCE_IN : std_logic_vector(1 downto 0) := (others => '0');
   signal WRENMEM_IN : std_logic := '0';
   signal ALUOP_IN : std_logic_vector(5 downto 0) := (others => '0');
   signal PCSOURCE_IN : std_logic_vector(1 downto 0) := (others => '0');
   signal CRD_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal CRS1_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal CRS2_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal i_IN : std_logic := '0';
   signal SEU_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_IN : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal DISP22_OUT : std_logic_vector(31 downto 0);
   signal DISP30_OUT : std_logic_vector(31 downto 0);
   signal PC_OUT : std_logic_vector(31 downto 0);
   signal RFSOURCE_OUT : std_logic_vector(1 downto 0);
   signal WRENMEM_OUT : std_logic;
   signal ALUOP_OUT : std_logic_vector(5 downto 0);
   signal PCSOURCE_OUT : std_logic_vector(1 downto 0);
   signal CRD_OUT : std_logic_vector(31 downto 0);
   signal CRS1_OUT : std_logic_vector(31 downto 0);
   signal CRS2_OUT : std_logic_vector(31 downto 0);
   signal i_OUT : std_logic;
   signal SEU_OUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ID_EX PORT MAP (
          CLK => CLK,
          RST => RST,
          DISP22_IN => DISP22_IN,
          DISP30_IN => DISP30_IN,
          DISP22_OUT => DISP22_OUT,
          DISP30_OUT => DISP30_OUT,
          RFSOURCE_IN => RFSOURCE_IN,
          WRENMEM_IN => WRENMEM_IN,
          ALUOP_IN => ALUOP_IN,
          PCSOURCE_IN => PCSOURCE_IN,
          CRD_IN => CRD_IN,
          CRS1_IN => CRS1_IN,
          CRS2_IN => CRS2_IN,
          i_IN => i_IN,
          SEU_IN => SEU_IN,
          PC_IN => PC_IN,
          PC_OUT => PC_OUT,
          RFSOURCE_OUT => RFSOURCE_OUT,
          WRENMEM_OUT => WRENMEM_OUT,
          ALUOP_OUT => ALUOP_OUT,
          PCSOURCE_OUT => PCSOURCE_OUT,
          CRD_OUT => CRD_OUT,
          CRS1_OUT => CRS1_OUT,
          CRS2_OUT => CRS2_OUT,
          i_OUT => i_OUT,
          SEU_OUT => SEU_OUT
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
			  DISP22_IN <= "00000001000000000000000000000000";
			  DISP30_IN <= "00000001000000000000000001000000";
           RFSOURCE_IN <= "01";
           WRENMEM_IN <= '0';
           ALUOP_IN <= "001010";
           PCSOURCE_IN <= "00";
           CRD_IN <= "00000001000000000000000000000011";
           CRS1_IN <= "00000001000000000000000000000111";
           CRS2_IN <= "00000001000000000000000000000101";
           i_IN <= '0';
           SEU_IN <= "00000001000000000000000000011101";
			  PC_IN <= "00000001000000000000000000111000";

      -- insert stimulus here 

      wait;
   end process;

END;
