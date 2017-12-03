
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MEM_WB is
    Port ( CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
			  DATA_TO_MEM_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_RESULT_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           RFSOURCE_IN : in  STD_LOGIC_VECTOR (1 downto 0);
           DATA_TO_MEM_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_RESULT_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           PC_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           RFSOURCE_OUT : out  STD_LOGIC_VECTOR (1 downto 0));
end MEM_WB;

architecture Behavioral of MEM_WB is

signal  AUX_DATA_TO_MEM : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal  AUX_ALU_RESULT : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal  AUX_PC : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal  AUX_RFSOURCE : STD_LOGIC_VECTOR(1 DOWNTO 0);

begin
	process(CLK,RST,AUX_DATA_TO_MEM, AUX_ALU_RESULT,AUX_PC, AUX_RFSOURCE)
	begin
		DATA_TO_MEM_OUT <= AUX_DATA_TO_MEM;
		ALU_RESULT_OUT <= AUX_ALU_RESULT;
		PC_OUT <= AUX_PC;
		RFSOURCE_OUT <= AUX_RFSOURCE;
		if RST = '1' then 
			DATA_TO_MEM_OUT <="00000000000000000000000000000000";
			ALU_RESULT_OUT <="00000000000000000000000000000000";
			PC_OUT <="00000000000000000000000000000000";
			RFSOURCE_OUT <="00";
		elsif clk'event and CLK = '1' then
			AUX_DATA_TO_MEM <= DATA_TO_MEM_IN;
			AUX_ALU_RESULT <= ALU_RESULT_IN;
			AUX_PC <= PC_IN;
			AUX_RFSOURCE <= RFSOURCE_IN;
		
	end if;
	end process;
end Behavioral;

