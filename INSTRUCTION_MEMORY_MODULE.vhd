----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:06:45 10/22/2017 
-- Design Name: 
-- Module Name:    INSTRUCTION_MEMORY_MODULE - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity INSTRUCTION_MEMORY_MODULE is
    Port ( PC : in  STD_LOGIC_VECTOR (5 downto 0);
           RST : in  STD_LOGIC;
           INSTRUCTION : out  STD_LOGIC_VECTOR (31 downto 0));
end INSTRUCTION_MEMORY_MODULE;

architecture IM of INSTRUCTION_MEMORY_MODULE is

	type ROM_TYPE is array (0 to 63) of std_logic_vector (31 downto 0);

	signal ROM: ROM_TYPE := ("10100000000100000010000000001000",
									"10100010000100000010000000000100",
									"10100100000100000010000000000000",
									"10100110000100000010000000000000",
									"01000000000000000000000000000101",
									"10000000000100000010000000000000",
									"10010000000100000000000000010010",
									"00110000100000000000000000001100",
									"10000000000100000010000000000000",
									"10000000101001000100000000010011",
									"00110010100000000000000000000100",
									"10000000000100000010000000000000",
									"10000001110000111110000000000001",
									"10000000000100000010000000000000",
									"10101000000001001110000000000001",
									"10100110000100000000000000010100",
									"10101000000001000000000000010010",
									"10100100000100000000000000010100",
									"00110000101111111111111111110111",
									"10000000000100000010000000000000",
									 others => "00000000000000000000000000000000");

begin
process(RST,ROM,PC)
	begin
		if(RST = '1') then
			INSTRUCTION<="00000000000000000000000000000000";
		else
			INSTRUCTION<=ROM(conv_integer(PC));
		end if;
end process;

end IM;