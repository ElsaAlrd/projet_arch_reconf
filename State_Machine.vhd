library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity State_Machine is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        ENABLE : out STD_LOGIC;
        STATE : out STD_LOGIC_VECTOR(1 downto 0)
    );
end State_Machine;

architecture Behavioral of State_Machine is
    type STATE_TYPE is (IDLE, LOAD, PROCESS, DONE);
    signal current_state, next_state : STATE_TYPE;
begin
    process (CLK, RESET)
    begin
        if RESET = '1' then
            current_state <= IDLE;
        elsif rising_edge(CLK) then
            current_state <= next_state;
        end if;
    end process;

    process (current_state)
    begin
        case current_state is
            when IDLE =>
                ENABLE <= '0';
                next_state <= LOAD;
            when LOAD =>
                ENABLE <= '1';
                next_state <= PROCESS;
            when PROCESS =>
                next_state <= DONE;
            when DONE =>
                ENABLE <= '0';
                next_state <= IDLE;
        end case;
    end process;

    STATE <= std_logic_vector(to_unsigned(current_state, 2));
end Behavioral;
