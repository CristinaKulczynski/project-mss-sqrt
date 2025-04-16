library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopLevel_MultiplyAndSqrt is
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
end entity TopLevel_MultiplyAndSqrt;

architecture Behavioral of TopLevel_MultiplyAndSqrt is

    component TopLevel_Multiply is
        port (
            clk    : in  std_logic;
            reset  : in  std_logic;
            A      : in  unsigned(31 downto 0);
            B      : in  unsigned(31 downto 0);
            result : out unsigned(31 downto 0)
        );
    end component;

    component TopLevel_Sqrt is
        Port (
            clk   : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            radicando  : in  STD_LOGIC_VECTOR(7 downto 0);
            start : in  STD_LOGIC;
            raiz  : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal multiply_result : unsigned(31 downto 0);

begin

    Multiply: TopLevel_Multiply
        port map (
            clk    => clk,
            reset  => reset,
            A      => A,
            B      => B,
            result => multiply_result
        );

    Sqrt: TopLevel_Sqrt
        port map (
            clk   => clk,
            reset => reset,
            radicando  => radicando,
            start => start,
				raiz  => raiz
        );

    result <= multiply_result;

end Behavioral;