library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity TopLevel_Sqrt is
    Port ( clk, reset, start : in  STD_LOGIC;
           radicando : in  STD_LOGIC_VECTOR (7 downto 0);
           raiz : out STD_LOGIC_VECTOR (7 downto 0)
			  );
end TopLevel_Sqrt;

architecture Behavioral of TopLevel_Sqrt  is

signal resetr , resetd, resets, ldraiz, ldr, lds, ldd, ca, t : std_logic;
signal cb : std_logic_vector(1 downto 0);

begin

Control: entity work.Sqrt_PC 
    Port map ( clk => clk, res => reset, start => start, t => t, resetr => resetr, resetd => resetd,
           resets => resets, ldraiz => ldraiz, ldr => ldr, lds => lds, ldd => ldd,
           ca => ca, cb => cb);

Operational: entity work.Sqrt_PO
    Port map( clk => clk, reset => reset, radicando => radicando, t => t, resetr => resetr, resetd => resetd,
           resets => resets, ldraiz => ldraiz, ldr => ldr, lds => lds, ldd => ldd, ca => ca, cb => cb,
           raiz => raiz);

end Behavioral;



