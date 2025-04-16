library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopLevel_Multiply is
    port (
        clk    : in  std_logic;
        reset  : in  std_logic;
		  A      : in  unsigned(31 downto 0);
        B      : in  unsigned(31 downto 0);
        result : out unsigned(31 downto 0)
    );
end entity TopLevel_Multiply;

architecture Behavioral_Top of TopLevel_Multiply is
signal calcula, termina : std_logic;
begin
	Control: entity work.Multiplication_PC
	  Port map (
			clk    => clk,
			reset  => reset,
			termina => termina,
			calcula => calcula
	  );

	Operational: entity work.Multiplication_PO
	  Port map (
			clk    => clk,
			reset  => reset,
			result => result,
			termina => termina, 
			calcula => calcula,
			A		 => A,
			B		 => B
	  );
end;
