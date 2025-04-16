library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top_Level_TB is
end entity Top_Level_TB;

architecture Behavioral of Top_Level_TB is
    -- Component Declaration
    component Top_Level is
        port (
            clk    : in  std_logic;
            reset  : in  std_logic;
            Cal    : in  std_logic;
            A      : in  unsigned(31 downto 0);
            B      : in  unsigned(31 downto 0);
            result : out unsigned(31 downto 0);
            dado   : in  std_logic_vector(7 downto 0);
            start  : in  std_logic;
            done   : out std_logic;
            raiz   : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signal Declarations
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal Cal     : std_logic := '1';
    signal A       : unsigned(31 downto 0) := (others => '0');
    signal B       : unsigned(31 downto 0) := (others => '0');
    signal result  : unsigned(31 downto 0);
    signal dado    : std_logic_vector(7 downto 0) := (others => '0');
    signal start   : std_logic := '0';
    signal done    : std_logic;
    signal raiz    : std_logic_vector(7 downto 0);
	-- Clock period definitions
		constant clk_period : time := 10 ns;
begin

    -- Instantiate the DUT (Design Under Test)
    dut: Top_Level
        port map (
            clk    => clk,
            reset  => reset,
            Cal    => Cal,
            A      => A,
            B      => B,
            result => result,
            dado   => dado,
            start  => start,
            done   => done,
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
      dado <= "00001001";
      reset <= '1', '0' after 10ns;
      start <= '0', '1' after 10ns;

      wait;
   end process;


end Behavioral;
