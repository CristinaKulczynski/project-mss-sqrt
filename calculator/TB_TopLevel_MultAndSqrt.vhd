library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_TopLevel_MultAndSqtr is
end entity TB_TopLevel_MultAndSqtr;

architecture Behavioral of TB_TopLevel_MultAndSqtr is
    -- Component Declaration
    component TopLevel_MultiplyAndSqrt is
        port (
            clk    : in  std_logic;
            reset  : in  std_logic;
            A      : in  unsigned(31 downto 0);
            B      : in  unsigned(31 downto 0);
            result : out unsigned(31 downto 0);
            radicando   : in  std_logic_vector(7 downto 0);
            start  : in  std_logic;
            raiz   : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signal Declarations
    signal clk     : std_logic := '0';
    signal reset   : std_logic;
    signal A       : unsigned(31 downto 0) := (others => '0');
    signal B       : unsigned(31 downto 0) := (others => '0');
    signal result  : unsigned(31 downto 0);
    signal radicando    : std_logic_vector(7 downto 0) := (others => '0');
    signal start   : std_logic:= '0';
    signal raiz    : std_logic_vector(7 downto 0);
	-- Clock period definitions
		constant clk_period : time := 10 ns;
begin

    -- Instantiate the DUT (Design Under Test)
    TopLevel: TopLevel_MultiplyAndSqrt
        port map (
            clk    => clk,
            reset  => reset,
            A      => A,
            B      => B,
            result => result,
            radicando   => radicando,
            start  => start,
            raiz   => raiz
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
		A <= to_unsigned(2, 32);
      B <= to_unsigned(4, 32);
      radicando <= "00001001";
      reset <= '1', '0' after 10ns;
      start <= '0', '1' after 10ns;

      wait;
   end process;


end Behavioral;
