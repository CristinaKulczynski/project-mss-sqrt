library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_Multiply is
end entity TB_Multiply;

architecture Behavioral of TB_Multiply is
    constant CLK_PERIOD : time := 10 ns;
    
    signal clk    : std_logic := '0';
    signal reset  : std_logic;
	 signal A : unsigned(31 downto 0);	
	 signal B : unsigned(31 downto 0);
    signal result : unsigned(31 downto 0);
begin
	reset <= '1', '0' after 10 ns;
    DUT: entity work.TopLevel_Multiply
    port map (
        clk    => clk,
        reset  => reset,
        result => result,
		  A		 => A,
		  B		 => B
    );

    clk_process: process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clk_process;

    stimulus_process: process
    begin
		  A <= to_unsigned(2, 32);
        B <= to_unsigned(4, 32);
        wait;
    end process stimulus_process;

end architecture Behavioral;