library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Generic_FlipFlop is
    Port (
        CLK : in STD_LOGIC;
        D : in STD_LOGIC;
        Q : out STD_LOGIC
    );
end Generic_FlipFlop;

architecture Behavioral of Generic_FlipFlop is
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            Q <= D;
        end if;
    end process;
end Behavioral;
