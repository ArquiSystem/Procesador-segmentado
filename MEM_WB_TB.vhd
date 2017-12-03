
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY MEM_WB_TB IS
END MEM_WB_TB;
 
ARCHITECTURE behavior OF MEM_WB_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEM_WB
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         DATA_TO_MEM_IN : IN  std_logic_vector(31 downto 0);
         ALU_RESULT_IN : IN  std_logic_vector(31 downto 0);
         PC_IN : IN  std_logic_vector(31 downto 0);
         RFSOURCE_IN : IN  std_logic_vector(2 downto 0);
         DATA_TO_MEM_OUT : OUT  std_logic_vector(31 downto 0);
         ALU_RESULT_OUT : OUT  std_logic_vector(31 downto 0);
         PC_OUT : OUT  std_logic_vector(31 downto 0);
         RFSOURCE_OUT : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal DATA_TO_MEM_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_RESULT_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal RFSOURCE_IN : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal DATA_TO_MEM_OUT : std_logic_vector(31 downto 0);
   signal ALU_RESULT_OUT : std_logic_vector(31 downto 0);
   signal PC_OUT : std_logic_vector(31 downto 0);
   signal RFSOURCE_OUT : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEM_WB PORT MAP (
          CLK => CLK,
          RST => RST,
          DATA_TO_MEM_IN => DATA_TO_MEM_IN,
          ALU_RESULT_IN => ALU_RESULT_IN,
          PC_IN => PC_IN,
          RFSOURCE_IN => RFSOURCE_IN,
          DATA_TO_MEM_OUT => DATA_TO_MEM_OUT,
          ALU_RESULT_OUT => ALU_RESULT_OUT,
          PC_OUT => PC_OUT,
          RFSOURCE_OUT => RFSOURCE_OUT
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
      RST <= '1';
      wait for 15 ns;
		RST <='0';
		DATA_TO_MEM_IN <= "00000000000000000000000000000001" ;
      ALU_RESULT_IN <="00000000000000000000000000000010";
      PC_IN <= "00000000000000000000000000000011";
      RFSOURCE_IN <= "100";
		wait for 10 ns;
		DATA_TO_MEM_IN <= "00000000000000000000000000000000" ;
      ALU_RESULT_IN <="00000000000000000000000000000000";
      PC_IN <= "00000000000000000000000000000000";
      RFSOURCE_IN <= "000";
		wait for 10 ns;
		DATA_TO_MEM_IN <= "10000000000000000000000000000000" ;
      ALU_RESULT_IN <="01000000000000000000000000000000";
      PC_IN <= "11000000000000000000000000000000";
      RFSOURCE_IN <= "100";
		

    

      -- insert stimulus here 

      wait;
   end process;

END;
