----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:35:19 12/01/2017 
-- Design Name: 
-- Module Name:    Instruction_Fetch - Behavioral 
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

entity Instruction_Fetch is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           MUX_TO_PC : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           SUMA_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           INSTRUCTION_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end Instruction_Fetch;

architecture Behavioral of Instruction_Fetch is

	COMPONENT PC_MODULE
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		INSTR : IN std_logic_vector(31 downto 0);          
		PC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT INSTRUCTION_MEMORY_MODULE
	PORT(
		PC : IN std_logic_vector(5 downto 0);
		RST : IN std_logic;          
		INSTRUCTION : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU_PC_MODULE
	PORT(
		NPC : IN std_logic_vector(31 downto 0);
		STATIC : IN std_logic_vector(31 downto 0);          
		PC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal out_nPC : std_logic_vector(31 downto 0);
signal out_PC : std_logic_vector(31 downto 0);

begin

nPC: PC_MODULE PORT MAP(
		PC => out_nPC,
		CLK => CLK,
		RST => RST,
		INSTR => MUX_TO_PC
	);

PC: PC_MODULE PORT MAP(
		PC => out_PC,
		CLK => CLK,
		RST => RST,
		INSTR => out_nPC
	);

SUMADOR: ALU_PC_MODULE PORT MAP(
		NPC => out_nPC,
		STATIC => X"00000001",
		PC => SUMA_OUT
	);

IM: INSTRUCTION_MEMORY_MODULE PORT MAP(
		PC => out_PC(5 downto 0),
		RST => RST,
		INSTRUCTION => INSTRUCTION_OUT
	);
	
	PC_OUT <= out_PC;

end Behavioral;

