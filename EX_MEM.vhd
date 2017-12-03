----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:57:51 12/01/2017 
-- Design Name: 
-- Module Name:    EX_MEM - Behavioral 
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

entity EX_MEM is
    Port ( CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
			  PC_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			  RFSOURCE_IN : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			  WRENMEM_IN : IN STD_LOGIC ; 
			  CRD_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_RESULT_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           CRD_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_RESULT_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
			  RFSOURCE_OUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			  WRENMEM_OUT: OUT STD_LOGIC;
			  PC_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
end EX_MEM;

architecture Behavioral of EX_MEM is

signal AUX_CRD: std_logic_vector(31 downto 0);
signal AUX_ALURESULT: std_logic_vector(31 downto 0);
signal AUX_WRENMEM: std_logic;
signal AUX_RFSOURCE : std_logic_vector(1 downto 0);
signal AUX_PC :std_logic_vector( 31 downto 0);

begin

	process(CLK,RST,AUX_CRD,AUX_ALURESULT,AUX_WRENMEM, AUX_RFSOURCE,AUX_PC)
	begin
		
		CRD_OUT <= AUX_CRD;
		ALU_RESULT_OUT <= AUX_ALURESULT;
		WRENMEM_OUT <= AUX_WRENMEM;
		RFSOURCE_OUT <= AUX_RFSOURCE;
		PC_OUT <= AUX_PC;
		if RST = '1' then
			CRD_OUT <=  X"00000000";
			ALU_RESULT_OUT <=  X"00000000";
			RFSOURCE_OUT <= "00";
			WRENMEM_OUT <= '0';
			PC_OUT <= X"00000000";
		elsif CLK'event and CLK = '1' then
			AUX_CRD <= CRD_IN;
			AUX_ALURESULT <= ALU_RESULT_IN;
			AUX_WRENMEM <= WRENMEM_IN;
			AUX_RFSOURCE <= RFSOURCE_IN;
			AUX_PC <= PC_IN;
		end if;
	end process;

end Behavioral;

