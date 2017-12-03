
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ID_EX is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  DISP22_IN : IN std_logic_vector(31 downto 0);
			  DISP30_IN : IN std_logic_vector(31 downto 0);
			  DISP22_OUT : OUT std_logic_vector(31 downto 0);
			  DISP30_OUT : OUT std_logic_vector(31 downto 0);
           RFSOURCE_IN : in  STD_LOGIC_VECTOR (1 downto 0);
           WRENMEM_IN : in  STD_LOGIC;
           ALUOP_IN : in  STD_LOGIC_VECTOR (5 downto 0);
           PCSOURCE_IN : in  STD_LOGIC_VECTOR (1 downto 0);
           CRD_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS1_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS2_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           i_IN : in  STD_LOGIC;
           SEU_IN : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC_IN : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			  PC_OUT : out STD_LOGIC_VECTOR( 31 DOWNTO 0);
           RFSOURCE_OUT : out  STD_LOGIC_VECTOR (1 downto 0);
           WRENMEM_OUT : out  STD_LOGIC;
           ALUOP_OUT : out  STD_LOGIC_VECTOR (5 downto 0);
           PCSOURCE_OUT : out  STD_LOGIC_VECTOR (1 downto 0);
           CRD_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           CRS1_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           CRS2_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           i_OUT : out  STD_LOGIC;
           SEU_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end ID_EX;

architecture Behavioral of ID_EX is

signal AUX_CRD: std_logic_vector(31 downto 0);
signal AUX_CRS1: std_logic_vector(31 downto 0);
signal AUX_CRS2: std_logic_vector(31 downto 0);
signal AUX_WRENMEM: std_logic;
signal AUX_I: std_logic;
signal AUX_ALUOP: std_logic_vector(5 downto 0);
signal AUX_RFSOURCE : std_logic_vector(1 downto 0);
signal AUX_PCSOURCE :std_logic_vector( 1 downto 0);
signal AUX_SEU: std_logic_vector(31 downto 0);
signal AUX_PC: std_logic_vector(31 downto 0);
signal AUX_DISP22 : std_logic_vector(31 downto 0);
signal AUX_DISP30 : std_logic_vector(31 downto 0);

begin

	process(CLK,RST,AUX_CRD,AUX_DISP22,AUX_DISP30,AUX_CRS1,AUX_CRS2,AUX_WRENMEM,AUX_I,AUX_ALUOP,AUX_RFSOURCE,AUX_PCSOURCE,AUX_SEU,AUX_PC)
	begin
			
		  DISP22_OUT <= AUX_DISP22;
		  DISP30_OUT <= AUX_DISP30;
		  PC_OUT <= AUX_PC ;
		  RFSOURCE_OUT <= AUX_RFSOURCE;
		  WRENMEM_OUT <= AUX_WRENMEM;
		  ALUOP_OUT <= AUX_ALUOP;
		  PCSOURCE_OUT <= AUX_PCSOURCE;
		  CRD_OUT <= AUX_CRD;
		  CRS1_OUT <= AUX_CRS1;
		  CRS2_OUT <= AUX_CRS2;
		  i_OUT <= AUX_I;
		  SEU_OUT <= AUX_SEU;
		if RST = '1' then
			DISP22_OUT <= X"00000000";
			DISP30_OUT <= X"00000000";
			RFSOURCE_OUT <=  "00";
         WRENMEM_OUT <=  '0';
         ALUOP_OUT <=  "000000";
         PCSOURCE_OUT <=  "00";
         CRD_OUT <=  X"00000000";
         CRS1_OUT <=  X"00000000";
         CRS2_OUT <=  X"00000000";
         i_OUT <=  '0';
         SEU_OUT <=  X"00000000";
		elsif CLK'event and CLK = '1' then
			AUX_DISP22 <= DISP22_IN;
			AUX_DISP30 <= DISP30_IN;
			AUX_PC <= PC_IN;
			AUX_CRD <= CRD_IN; 
			AUX_CRS1 <= CRS1_IN;
			AUX_CRS2 <= CRS2_IN;
			AUX_WRENMEM <= WRENMEM_IN;
			AUX_I <= i_IN;
			AUX_ALUOP <=  ALUOP_IN;
			AUX_RFSOURCE <= RFSOURCE_IN ;
			AUX_PCSOURCE <= PCSOURCE_IN;
			AUX_SEU <= SEU_IN;
			AUX_PC <=  PC_IN;
		end if;
	end process;


end Behavioral;

