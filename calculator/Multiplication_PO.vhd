library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplication_PO is
    port (
        clk    : in  std_logic;
        reset  : in  std_logic;
		  termina : buffer std_logic;
		  calcula : in std_logic;
		  A      : in  unsigned(31 downto 0);
        B      : in  unsigned(31 downto 0);
        result : out unsigned(31 downto 0)
    );
end entity Multiplication_PO;

architecture Behavioral of Multiplication_PO is
    signal r0, r1, r2, r3 : unsigned(31 downto 0);
	 signal cont : std_logic;
begin
	
	process(clk, reset)
	begin
		if reset = '1' then
			r0 <= (others => '0');
			r1 <= (others => '0');
			r2 <= (others => '0');
			r3 <= (others => '0');
			result <= (others => '0');
			cont <= '0';
		elsif(clk'event and clk = '1') then
			case calcula is
				when '0' => 
					r0 <= to_unsigned(1, 32);
					r1 <= A;
					r2 <= B;
					r3 <= (others => '0');
					cont <= '0';
				when '1' => 
					if r2 = to_unsigned(0, 32) or r1 = to_unsigned(0, 32) then
						 result <= r3;
						 cont <= '1';
					else
						r3 <= r3 + r1;
						r2 <= r2 - r0;
						result <= r3;
					end if;
				when others =>
			end case;
		end if;
	end process;
	
	process(cont)
    begin 
        case cont is
            when '0' =>
                termina <= '0';
            when '1' =>
                termina <= '1';
            when others =>
                termina <= '0';
        end case;
    end process;
end architecture Behavioral;