----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:47:22 12/02/2017 
-- Design Name: 
-- Module Name:    Procesador_segmentado - Behavioral 
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

entity Procesador_segmentado is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           DATA_TO_REG : out  STD_LOGIC_VECTOR(31 downto 0));
end Procesador_segmentado;

architecture Behavioral of Procesador_segmentado is

COMPONENT Instruction_Fetch
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		MUX_TO_PC : IN std_logic_vector(31 downto 0);          
		PC_OUT : OUT std_logic_vector(31 downto 0);
		SUMA_OUT : OUT std_logic_vector(31 downto 0);
		INSTRUCTION_OUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT IF_ID
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		INSTRUCTION_IN : IN std_logic_vector(31 downto 0);
		PC_IN : IN std_logic_vector(31 downto 0);          
		INSTRUCTION_OUT : OUT std_logic_vector(31 downto 0);
		PC_OUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Instruction_Decode
	PORT(
		RST : IN std_logic;
		IN_INSTRUCTION : IN std_logic_vector(31 downto 0);
		ICC : IN std_logic_vector(3 downto 0);
		COND : IN std_logic_vector(3 downto 0);
		CWP : IN std_logic_vector(0 to 0);
		DATA_TO_REG : IN std_logic_vector(31 downto 0);          
		RFSOURCE : OUT std_logic_vector(1 downto 0);
		WRDENMEM : OUT std_logic;
		PCSOURCE : OUT std_logic_vector(1 downto 0);
		ALUOP : OUT std_logic_vector(5 downto 0);
		cRD : OUT std_logic_vector(31 downto 0);
		CRS1 : OUT std_logic_vector(31 downto 0);
		CRS2 : OUT std_logic_vector(31 downto 0);
		SEU : OUT std_logic_vector(31 downto 0);
		NCWP : OUT std_logic_vector(0 to 0)
		);
	END COMPONENT;
	
	COMPONENT ID_EX
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		DISP22_IN : IN std_logic_vector(31 downto 0);
		DISP30_IN : IN std_logic_vector(31 downto 0);
		DISP22_OUT : OUT std_logic_vector(31 downto 0);
		DISP30_OUT : OUT std_logic_vector(31 downto 0);
		RFSOURCE_IN : IN std_logic_vector(1 downto 0);
		WRENMEM_IN : IN std_logic;
		ALUOP_IN : IN std_logic_vector(5 downto 0);
		PCSOURCE_IN : IN std_logic_vector(1 downto 0);
		CRD_IN : IN std_logic_vector(31 downto 0);
		CRS1_IN : IN std_logic_vector(31 downto 0);
		CRS2_IN : IN std_logic_vector(31 downto 0);
		i_IN : IN std_logic;
		SEU_IN : IN std_logic_vector(31 downto 0);
		PC_IN : IN std_logic_vector(31 downto 0);          
		PC_OUT : OUT std_logic_vector(31 downto 0);
		RFSOURCE_OUT : OUT std_logic_vector(1 downto 0);
		WRENMEM_OUT : OUT std_logic;
		ALUOP_OUT : OUT std_logic_vector(5 downto 0);
		PCSOURCE_OUT : OUT std_logic_vector(1 downto 0);
		CRD_OUT : OUT std_logic_vector(31 downto 0);
		CRS1_OUT : OUT std_logic_vector(31 downto 0);
		CRS2_OUT : OUT std_logic_vector(31 downto 0);
		i_OUT : OUT std_logic;
		SEU_OUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT execute
	PORT(
		aluop : IN std_logic_vector(5 downto 0);
		crs1 : IN std_logic_vector(31 downto 0);
		crs2 : IN std_logic_vector(31 downto 0);
		seu : IN std_logic_vector(31 downto 0);
		cwp : OUT std_logic_vector(0 to 0);
		clk : IN std_logic;
		rst : IN std_logic;
		i : IN std_logic;          
		ncwp : in std_logic_vector(0 to 0);
		alu_result : OUT std_logic_vector(31 downto 0);
		icc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT EX_MEM
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		PC_IN : IN std_logic_vector(31 downto 0);
		RFSOURCE_IN : IN std_logic_vector(1 downto 0);
		WRENMEM_IN : IN std_logic;
		CRD_IN : IN std_logic_vector(31 downto 0);
		ALU_RESULT_IN : IN std_logic_vector(31 downto 0);          
		CRD_OUT : OUT std_logic_vector(31 downto 0);
		ALU_RESULT_OUT : OUT std_logic_vector(31 downto 0);
		RFSOURCE_OUT : OUT std_logic_vector(1 downto 0);
		WRENMEM_OUT : OUT std_logic;
		PC_OUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT DATA_MEMORY_MODULE
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		ALU_RESULT : IN std_logic_vector(4 downto 0);
		cRD : IN std_logic_vector(31 downto 0);
		WRDENMEM : IN std_logic;          
		DATATOMEM : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MEM_WB
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		DATA_TO_MEM_IN : IN std_logic_vector(31 downto 0);
		ALU_RESULT_IN : IN std_logic_vector(31 downto 0);
		PC_IN : IN std_logic_vector(31 downto 0);
		RFSOURCE_IN : IN std_logic_vector(1 downto 0);          
		DATA_TO_MEM_OUT : OUT std_logic_vector(31 downto 0);
		ALU_RESULT_OUT : OUT std_logic_vector(31 downto 0);
		PC_OUT : OUT std_logic_vector(31 downto 0);
		RFSOURCE_OUT : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUX_DM_MODULE
	PORT(
		RFSOURCE : IN std_logic_vector(1 downto 0);
		DATATOMEM : IN std_logic_vector(31 downto 0);
		ALU_RESULT : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);          
		DATATOREG : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU_BR_MODULE
	PORT(
		DISP22 : IN std_logic_vector(21 downto 0);          
		SDISP22 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU_CALL_MODULE
	PORT(
		DISP30 : IN std_logic_vector(29 downto 0);          
		SDISP30 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU_CALL_MODULE
	PORT(
		SDISP30 : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);          
		CALL : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU_BR_MODULE
	PORT(
		SDISP22 : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);          
		BRANCHS : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUX_BR_MODULE
	PORT(
		PCSOURCE : IN std_logic_vector(1 downto 0);
		CALL : IN std_logic_vector(31 downto 0);
		BRANCHS : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);
		ALU_RESULT : IN std_logic_vector(31 downto 0);          
		DATATONPC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal INSTRUCTION_IN: std_logic_vector(31 downto 0);
signal INSTRUCTION_OUT: std_logic_vector(31 downto 0);
signal PC1_IN: std_logic_vector(31 downto 0);	
signal PC1_OUT: std_logic_vector(31 downto 0);
signal PC2_IN: std_logic_vector(31 downto 0);
signal PC2_OUT: std_logic_vector(31 downto 0);
signal PC3_IN : std_logic_vector(31 downto 0);
signal RFSOURCE1_IN : std_logic_vector( 1 downto 0);
signal RFSOURCE1_OUT : std_logic_vector( 1 downto 0);
signal RFSOURCE2_IN : std_logic_vector( 1 downto 0);
signal RFSOURCE2_OUT : std_logic_vector( 1 downto 0);
signal WRDENMEM1_IN : std_logic;
signal WRDENMEM2_IN : std_logic;
signal WRDENMEM1_OUT: std_logic;
signal PCSOURCE_IN : std_logic_vector( 1 downto 0);
signal PCSOURCE_OUT : std_logic_vector( 1 downto 0);
signal ALUOP_IN: std_logic_vector(5 downto 0);
signal ALUOP_OUT: std_logic_vector(5 downto 0);
signal AUX_ICC : std_logic_vector(3 downto 0);
signal AUX_COND: std_logic_vector(3 downto 0);
signal AUX_CWP : std_logic_vector(0 downto 0);
signal AUX_NCWP : std_logic_vector(0 downto 0);
signal CRS1_IN : std_logic_vector(31 downto 0);
signal CRS2_IN : std_logic_vector(31 downto 0);
signal CRS1_OUT : std_logic_vector(31 downto 0);
signal CRS2_OUT : std_logic_vector(31 downto 0);
signal CRD_IN : std_logic_vector(31 downto 0);
signal CRD_OUT : std_logic_vector(31 downto 0);
signal CRD2_OUT : std_logic_vector(31 downto 0);
signal i_OUT : std_logic;
signal SEU_IN : std_logic_vector(31 downto 0);
signal SEU_OUT : std_logic_vector(31 downto 0);
signal ALU_RESULT1_IN : std_logic_vector(31 downto 0);
signal ALU_RESULT2_IN : std_logic_vector(31 downto 0);
signal ALU_RESULT1_OUT : std_logic_vector(31 downto 0);
signal DATATOMEM_IN : std_logic_vector(31 downto 0);
signal DATATOMEM_OUT : std_logic_vector(31 downto 0);
signal AUX_DATATOREG : std_logic_vector(31 downto 0);
signal AUX_SDISP30 : std_logic_vector(31 downto 0);
signal AUX_SDISP22 : std_logic_vector(31 downto 0);
signal AUX_BRANCHS : std_logic_vector(31 downto 0);
signal AUX_CALL : std_logic_vector(31 downto 0);
signal AUX_SUMAPC : std_logic_vector(31 downto 0);
signal AUX_MUX : std_logic_vector(31 downto 0);
signal AUX_DISP22 : std_logic_vector( 31 downto 0);
signal AUX_DISP30 : std_logic_vector( 31 downto 0);

begin

DATA_TO_REG<=AUX_DATATOREG;

Inst_Instruction_Fetch: Instruction_Fetch PORT MAP(
		CLK => clk,
		RST => rst,
		MUX_TO_PC => AUX_MUX,
		PC_OUT => PC1_IN,
		SUMA_OUT => AUX_SUMAPC,
		INSTRUCTION_OUT => INSTRUCTION_IN
	);

Inst_IF_ID: IF_ID PORT MAP(
		CLK => clk,
		RST => rst,
		INSTRUCTION_IN => INSTRUCTION_IN,
		PC_IN => PC1_IN,
		INSTRUCTION_OUT => INSTRUCTION_OUT,
		PC_OUT => PC1_OUT
	);

Inst_Instruction_Decode: Instruction_Decode PORT MAP(
		RST => rst,
		IN_INSTRUCTION => INSTRUCTION_OUT,
		ICC => AUX_ICC,
		COND => AUX_COND,
		CWP => AUX_CWP,
		DATA_TO_REG => AUX_DATATOREG,
		RFSOURCE => RFSOURCE1_IN ,
		WRDENMEM => WRDENMEM1_IN,
		PCSOURCE => PCSOURCE_IN,
		ALUOP => ALUOP_IN,
		CRD => CRD_IN,
		CRS1 => CRS1_IN,
		CRS2 => CRS2_IN,
		SEU => SEU_IN,
		NCWP => AUX_NCWP
	);
	
		Inst_ID_EX: ID_EX PORT MAP(
		CLK => clk,
		RST => rst,
		DISP22_IN => AUX_BRANCHS,
		DISP30_IN => AUX_CALL,
		DISP22_OUT => AUX_DISP22,
		DISP30_OUT => AUX_DISP30,
		RFSOURCE_IN => RFSOURCE1_IN ,
		WRENMEM_IN => WRDENMEM1_IN,
		ALUOP_IN => ALUOP_IN,
		PCSOURCE_IN => PCSOURCE_IN,
		CRD_IN => CRD_IN,
		CRS1_IN => CRS1_IN,
		CRS2_IN => CRS2_IN,
		i_IN => INSTRUCTION_OUT(13),
		SEU_IN => SEU_IN,
		PC_IN => PC1_OUT,
		PC_OUT => PC2_IN,
		RFSOURCE_OUT => RFSOURCE1_OUT ,
		WRENMEM_OUT =>  WRDENMEM1_OUT,
		ALUOP_OUT => ALUOP_OUT,
		PCSOURCE_OUT => PCSOURCE_OUT,
		CRD_OUT => CRD_OUT,
		CRS1_OUT => CRS1_OUT,
		CRS2_OUT => CRS2_OUT,
		i_OUT => i_OUT,
		SEU_OUT => SEU_OUT
	);

	Inst_execute: execute PORT MAP(
		aluop => ALUOP_OUT,
		crs1 => CRS1_OUT,
		crs2 => CRS2_OUT,
		seu => SEU_OUT,
		cwp => AUX_CWP,
		ncwp => AUX_NCWP,
		clk => clk,
		rst => rst,
		i => i_OUT,
		alu_result => ALU_RESULT1_IN,
		icc => AUX_ICC
	);
	
	Inst_EX_MEM: EX_MEM PORT MAP(
		CLK => clk,
		RST => rst,
		PC_IN => PC2_IN,
		RFSOURCE_IN => RFSOURCE1_OUT,
		WRENMEM_IN => WRDENMEM1_OUT,
		CRD_IN => CRD_OUT,
		ALU_RESULT_IN => ALU_RESULT1_IN,
		CRD_OUT => CRD2_OUT,
		ALU_RESULT_OUT => ALU_RESULT1_OUT,
		RFSOURCE_OUT => RFSOURCE2_IN,
		WRENMEM_OUT => WRDENMEM2_IN,
		PC_OUT => PC2_OUT
	);
	
	Inst_DATA_MEMORY_MODULE: DATA_MEMORY_MODULE PORT MAP(
		RST => rst,
		CLK => clk,
		ALU_RESULT => ALU_RESULT1_OUT(4 downto 0),
		cRD => CRD2_OUT,
		WRDENMEM => WRDENMEM2_IN,
		DATATOMEM => DATATOMEM_IN
	);
	
	Inst_MEM_WB: MEM_WB PORT MAP(
		CLK => clk,
		RST => rst,
		DATA_TO_MEM_IN => DATATOMEM_IN,
		ALU_RESULT_IN => ALU_RESULT1_OUT,
		PC_IN => PC2_OUT,
		RFSOURCE_IN => RFSOURCE2_IN,
		DATA_TO_MEM_OUT => DATATOMEM_OUT,
		ALU_RESULT_OUT => ALU_RESULT2_IN,
		PC_OUT => PC3_IN,
		RFSOURCE_OUT => RFSOURCE2_OUT
	);
	
	Inst_MUX_DM_MODULE: MUX_DM_MODULE PORT MAP(
		RFSOURCE => RFSOURCE2_OUT,
		DATATOMEM => DATATOMEM_OUT,
		ALU_RESULT => ALU_RESULT2_IN,
		PC => PC3_IN,
		DATATOREG => AUX_DATATOREG
	);
	
	Inst_SEU_BR_MODULE: SEU_BR_MODULE PORT MAP(
		DISP22 => INSTRUCTION_OUT(21 DOWNTO 0),
		SDISP22 => AUX_SDISP22
	);
	
	Inst_ALU_BR_MODULE: ALU_BR_MODULE PORT MAP(
		SDISP22 => AUX_SDISP22,
		PC => PC1_IN,
		BRANCHS => AUX_BRANCHS
	);
	
		Inst_SEU_CALL_MODULE: SEU_CALL_MODULE PORT MAP(
		DISP30 => INSTRUCTION_OUT(29 DOWNTO 0),
		SDISP30 => AUX_SDISP30
	);
	
	Inst_ALU_CALL_MODULE: ALU_CALL_MODULE PORT MAP(
		SDISP30 => AUX_SDISP30,
		PC => PC1_IN,
		CALL => AUX_CALL
	);
	
	Inst_MUX_BR_MODULE: MUX_BR_MODULE PORT MAP(
		PCSOURCE => PCSOURCE_OUT,
		CALL => AUX_DISP30,
		BRANCHS => AUX_DISP22,
		PC => AUX_SUMAPC,
		ALU_RESULT => ALU_RESULT1_IN,
		DATATONPC => AUX_MUX
	);

end Behavioral;

