library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sqrt_PC is
    Port (
        clk, res, start : in STD_LOGIC;
        t : in STD_LOGIC;
        resetr, resetd, resets : out STD_LOGIC;
        ldraiz, ldr, lds, ldd : out STD_LOGIC;
        ca : out STD_LOGIC;
        cb : out STD_LOGIC_VECTOR (1 downto 0)
    );
end Sqrt_PC;

architecture Behavioral of Sqrt_PC is
    type outings is (idle, s0, s1, s2, s3, done);
    signal state, next_state : outings;
    signal outing : STD_LOGIC_VECTOR (10 downto 0);
begin
    process (clk, res)
    begin
        if res = '1' then
            state <= idle;
        elsif (clk'event and clk = '1') then
            case state is
                when idle =>
                    outing <= (10 downto 8 => '1', others => '0');
                    if start = '0' then
                        state <= idle;
                    else
                        state <= s0;
                    end if;
                when s0 =>
                    outing <= (7 => '1', others => '0');
                    state <= s1;
                when s1 =>
                    outing <= (4 => '1', 3 => '1', others => '0');
                    state <= s2;
                when s2 =>
                    outing <= (5 => '1', 3 => '1', 2 => '1', others => '0');
                    state <= s3;
                when s3 =>
                    outing <= (6 => '1', 1 => '1', others => '0');
                    if t = '1' then
                        state <= s1;
                    else
                        state <= done;
                    end if;
                when done =>
                    outing <= "00000000000";
                    state <= idle;
            end case;
        end if;
    end process;

    resetr <= outing(10);
    resetd <= outing(9);
    resets <= outing(8);
    ldraiz <= outing(7);
    ldr <= outing(6);
    lds <= outing(5);
    ldd <= outing(4);
    ca <= outing(3);
    cb <= outing(2 downto 1);
end Behavioral;
