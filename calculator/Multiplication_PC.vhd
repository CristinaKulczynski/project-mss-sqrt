library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplication_PC is
    port (
        clk      : in  std_logic; 
        reset    : in  std_logic; 
		  termina  : in  std_logic; 
		  calcula : out std_logic
    );
end entity Multiplication_PC;

architecture Behavioral_Control of Multiplication_PC is
    type State_Type is (Idle, Calculating, Pronto);
    signal current_state, next_state : State_Type;
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                current_state <= Idle;
            else
                current_state <= next_state;
            end if;
        end if;
    end process;

    process (current_state)
    begin
        case current_state is
            when Idle =>
					calcula <= '0';
					next_state <= Calculating;
            when Calculating =>
					calcula <= '1';
				   next_state <= Pronto;				
            when Pronto =>
					if termina = '1' then
						next_state <= Idle;
					else 
						next_state <= Calculating;
					end if;
        end case;
    end process;
end architecture Behavioral_Control;

