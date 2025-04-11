library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sqrt_PO is
    Port (
            clk, reset : in STD_LOGIC;
            radicando : in STD_LOGIC_VECTOR(7 DOWNTO 0);
            resetr, resetd, resets: in STD_LOGIC;
            ldraiz : in STD_LOGIC;
            ldr, lds, ldd : in STD_LOGIC;
            ca : in STD_LOGIC;
            cb : in STD_LOGIC_VECTOR(1 downto 0);
            t : out STD_LOGIC;
            raiz : out STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end Sqrt_PO;

architecture Behavioral of Sqrt_PO is
    signal mux1, mux2, s, d, r, regraiz : std_logic_vector(7 downto 0);
    signal somador : std_logic_vector(7 downto 0);
begin

    process(clk, resetr)
    begin
        if resetr = '1' then 
            r <= "00000000";
        elsif rising_edge(clk) then
            if ldr = '1' then
                r <= somador;
            end if;
        end if;
    end process;

    process(clk, resets)
    begin
        if resets = '1' then 
            s <= "00000100";
        elsif clk'event and clk = '1' then
            if lds = '1' then
                s <= somador;
            end if;
        end if;
    end process;

    process(clk, resetd)
    begin
        if resetd = '1' then 
            d <= "00000010";
        elsif rising_edge(clk) then
            if ldd = '1' then
                d <= somador;
            end if;
        end if;
    end process;

    process(clk, reset)
	 begin
		 if reset = '1' then 
			  regraiz <= "00000000";
		 elsif rising_edge(clk) then
			  if ldraiz = '1' then
					regraiz <= radicando;
			  end if;
		 end if;
	 end process;


    somador <= mux1 + mux2;

    process(d, r, Ca)
    begin
        case Ca is
            when '0' =>
                mux1 <= r;
            when others =>
                mux1 <= d;
        end case;
    end process;

    process(s, Cb)
    begin
        case Cb is
            when "00" =>
                mux2 <= "00000010";
            when "01" =>
                mux2 <= "00000001";
            when others =>
                mux2 <= s;
        end case;
    end process;

    process(regraiz, s)
    begin 
        if s <= regraiz then
            t <= '1';
        else
            t <= '0';
        end if;
    end process;

    raiz <= r;
end Behavioral;

