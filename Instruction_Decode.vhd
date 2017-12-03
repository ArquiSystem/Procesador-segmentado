----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:41:47 12/01/2017 
-- Design Name: 
-- Module Name:    Instruction_Decode - Behavioral 
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

entity Instruction_Decode is
    Port ( RST : IN STD_LOGIC;
			  IN_INSTRUCTION : in  STD_LOGIC_VECTOR (31 downto 0);
			  ICC : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			  COND : IN STD_LOGIC_VECTOR (3 DOWNTO 0);	
           CWP : IN  STD_LOGIC_VECTOR (0 downto 0);
			  DATA_TO_REG: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
           RFSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
           WRDENMEM : out  STD_LOGIC;
           PCSOURCE : out  STD_LOGIC_VECTOR (1 downto 0);
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0);
           CRD : out  STD_LOGIC_VECTOR (31 downto 0);
           CRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : out  STD_LOGIC_VECTOR (31 downto 0);
           SEU : out  STD_LOGIC_VECTOR (31 downto 0);
			  NCWP : out STD_LOGIC_VECTOR(0 DOWNTO 0));
end Instruction_Decode;

architecture Behavioral of Instruction_Decode is

COMPONENT WINDOWS_MANAGER_MODULE
	PORT(
		CWP : IN std_logic_vector(0 to 0);
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		RS1 : IN std_logic_vector(4 downto 0);
		RS2 : IN std_logic_vector(4 downto 0);
		RD : IN std_logic_vector(4 downto 0);          
		NCWP : OUT std_logic_vector(0 to 0);
		NRS1 : OUT std_logic_vector(5 downto 0);
		NRS2 : OUT std_logic_vector(5 downto 0);
		NRD : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUX_WM_MODULE
	PORT(
		RFDEST : IN std_logic;
		RD : IN std_logic_vector(5 downto 0);          
		NRD : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT REGITER_FILE_MODULE
	PORT(
		NRS1 : IN std_logic_vector(5 downto 0);
		NRS2 : IN std_logic_vector(5 downto 0);
		NRD : IN std_logic_vector(5 downto 0);
		RST : IN std_logic;
		WE : IN std_logic;
		DATATOREG : IN std_logic_vector(31 downto 0);          
		CRS1 : OUT std_logic_vector(31 downto 0);
		CRD : OUT std_logic_vector(31 downto 0);
		CRS2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT CONTROL_UNIT_MODULE
	PORT(
		OP : IN std_logic_vector(1 downto 0);
		OP2 : IN std_logic_vector(2 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		ICC : IN std_logic_vector(3 downto 0);
		COND : IN std_logic_vector(3 downto 0);          
		PCSOURCE : OUT std_logic_vector(1 downto 0);
		ALUOP : OUT std_logic_vector(5 downto 0);
		WRDENMEM : OUT std_logic;
		RFSOURCE : OUT std_logic_vector(1 downto 0);
		RFDEST : OUT std_logic;
		WE : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT SEU_IMM_MODULE
	PORT(
		IMM : IN std_logic_vector(12 downto 0);          
		SIMM : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
signal AUX_NRS1: std_logic_vector(5 downto 0);
signal AUX_NRS2: std_logic_vector(5 downto 0);
signal AUX_NRD1: std_logic_vector(5 downto 0);
signal AUX_NRD2: std_logic_vector(5 downto 0);
signal AUX_DATA_TO_REG: std_logic_vector(31 downto 0);
signal AUX_RFDEST: STD_LOGIC;
signal AUX_WE: STD_LOGIC;
	
begin


Inst_WINDOWS_MANAGER_MODULE: WINDOWS_MANAGER_MODULE PORT MAP(
		CWP => CWP,
		OP => IN_INSTRUCTION(31 DOWNTO 30),
		OP3 => IN_INSTRUCTION(24 DOWNTO 19),
		RS1 => IN_INSTRUCTION(18 DOWNTO 14),
		RS2 => IN_INSTRUCTION(4 DOWNTO 0),
		RD => IN_INSTRUCTION(29 DOWNTO 25),
		NCWP => NCWP,
		NRS1 => AUX_NRS1,
		NRS2 => AUX_NRS2,
		NRD => AUX_NRD1 
	);
	
	Inst_MUX_WM_MODULE: MUX_WM_MODULE PORT MAP(
		RFDEST => AUX_RFDEST,
		RD => AUX_NRD1,
		NRD => AUX_NRD2
	);
	
	Inst_REGITER_FILE_MODULE: REGITER_FILE_MODULE PORT MAP(
		NRS1 => AUX_NRS1,
		NRS2 => AUX_NRS2,
		NRD => AUX_NRD2,
		RST => RST,
		WE => AUX_WE,
		DATATOREG => DATA_TO_REG,
		CRS1 => CRS1,
		CRD => CRD,
		CRS2 => CRS2
	);
	
	Inst_CONTROL_UNIT_MODULE: CONTROL_UNIT_MODULE PORT MAP(
		OP => IN_INSTRUCTION(31 downto 30),
		OP3 => IN_INSTRUCTION(24 downto 19),
		OP2 => IN_INSTRUCTION(24 downto 22),
		ICC => ICC,
		COND => COND,
		PCSOURCE => PCSOURCE,
		ALUOP => ALUOP,
		WRDENMEM => WRDENMEM,
		RFSOURCE => RFSOURCE,
		RFDEST => AUX_RFDEST,
		WE => AUX_WE
	);
	
	Inst_SEU_IMM_MODULE: SEU_IMM_MODULE PORT MAP(
		IMM => IN_INSTRUCTION(12 downto 0),
		SIMM => SEU
	);

end Behavioral;

