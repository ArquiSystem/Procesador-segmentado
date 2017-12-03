----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:47:02 12/01/2017 
-- Design Name: 
-- Module Name:    execute - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity execute is
    Port ( aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           seu : in  STD_LOGIC_VECTOR (31 downto 0);
           cwp : out  STD_LOGIC_VECTOR (0 downto 0);
           ncwp : in  STD_LOGIC_VECTOR (0 downto 0);
			  clk : in std_logic;
			  rst : in std_logic;
			  i: in std_logic;
			  alu_result: out std_logic_vector(31 downto 0);
           icc : out  STD_LOGIC_VECTOR (3 downto 0));
end execute;

architecture Behavioral of execute is

COMPONENT PSR_MODULE
	PORT(
		CLK : IN std_logic;
		NZVC : IN std_logic_vector(3 downto 0);
		RST : IN std_logic;
		NCWP : IN std_logic_vector(0 to 0);          
		ICC : OUT std_logic_vector(3 downto 0);
		CWP : OUT std_logic_vector(0 to 0);
		C : OUT std_logic_vector(0 to 0)
		);
	END COMPONENT;

COMPONENT PSR_MODIFIER_MODULE
	PORT(
		CRS1 : IN std_logic_vector(31 downto 0);
		OP2 : IN std_logic_vector(31 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);
		ALU_RESULT : IN std_logic_vector(31 downto 0);          
		NZVC : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

COMPONENT MUX_RF_MODULE
	PORT(
		I : IN std_logic;
		CRS2 : IN std_logic_vector(31 downto 0);
		SIMM : IN std_logic_vector(31 downto 0);          
		OP2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT ALU_MODULE
	PORT(
		ALUOP : IN std_logic_vector(5 downto 0);
		CRS1 : IN std_logic_vector(31 downto 0);
		OP2 : IN std_logic_vector(31 downto 0);
		C : IN std_logic_vector(0 to 0);          
		ALU_RESULT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal nzvc : std_logic_vector(3 downto 0);
signal c : std_logic_vector(0 to 0);
signal mux_out: std_logic_vector(31 downto 0);
signal aux_result:std_logic_vector(31 downto 0);

begin
alu_result<=aux_result;

PSR: PSR_MODULE PORT MAP(
		CLK => clk,
		NZVC => nzvc,
		RST => rst,
		NCWP => ncwp,
		ICC => icc,
		CWP => cwp,
		C => c
	);

PSR_MODIFIER: PSR_MODIFIER_MODULE PORT MAP(
		CRS1 => crs1,
		OP2 => mux_out,
		ALUOP => aluop,
		ALU_RESULT => aux_result,
		NZVC =>nzvc 
	);

Inst_MUX_RF: MUX_RF_MODULE PORT MAP(
		I => i,
		CRS2 => crs2,
		SIMM => seu,
		OP2 => mux_out
	);

ALU: ALU_MODULE PORT MAP(
		ALUOP => aluop,
		CRS1 => crs1,
		OP2 => mux_out,
		C => c,
		ALU_RESULT => aux_result
	);

end Behavioral;

