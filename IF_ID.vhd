----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:24:26 12/02/2017 
-- Design Name: 
-- Module Name:    IF_ID - Behavioral 
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

entity IF_ID is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           INSTRUCTION_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           INSTRUCTION_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           PC_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_ID;

architecture Behavioral of IF_ID is

signal AUX_INSTRUCTION: std_logic_vector(31 downto 0);
signal AUX_PC: std_logic_vector(31 downto 0);

begin

	process(CLK,RST,AUX_INSTRUCTION,AUX_PC)
	begin
		
		INSTRUCTION_OUT <= AUX_INSTRUCTION;
		PC_OUT <= AUX_PC;
		if RST = '1' then
			INSTRUCTION_OUT <=  X"00000000";
			PC_OUT <=  X"00000000";
		elsif CLK'event and CLK = '1' then
			AUX_INSTRUCTION <= INSTRUCTION_IN;
			AUX_PC <= PC_IN;
		end if;
	end process;


end Behavioral;

