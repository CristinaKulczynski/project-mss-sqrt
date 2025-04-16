
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY TB_TopLevel_Sqrt IS
END TB_TopLevel_Sqrt;
 
ARCHITECTURE behavior OF TB_TopLevel_Sqrt IS 
 
    COMPONENT TopLevel_Sqrt
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         radicando : IN  std_logic_vector(7 downto 0);
         start : IN  std_logic;
         raiz : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic;
   signal radicando : std_logic_vector(7 downto 0) := (others => '0');
   signal start : std_logic := '0';

 	--Outputs
   signal raiz : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TopLevel_Sqrt PORT MAP (
          clk => clk,
          reset => reset,
          radicando => radicando,
          start => start,
          raiz => raiz
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      radicando <= "00001001";
      reset <= '1', '0' after 10ns;
      start <= '0', '1' after 10ns;

      wait;
   end process;

END;
