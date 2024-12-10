library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFO is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        DATA_IN : in STD_LOGIC_VECTOR(7 downto 0);
        WRITE_EN : in STD_LOGIC;
        READ_EN : in STD_LOGIC;
        DATA_OUT : out STD_LOGIC_VECTOR(7 downto 0);
        EMPTY : out STD_LOGIC;
        FULL : out STD_LOGIC
    );
end FIFO;

architecture Behavioral of FIFO is
    -- FIFO Internal Memory
    type memory_type is array (0 to 127) of STD_LOGIC_VECTOR(7 downto 0); -- Ajusté à la profondeur
    signal memory : memory_type;
    signal write_ptr, read_ptr : integer range 0 to 127 := 0;

begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                write_ptr <= 0;
                read_ptr <= 0;
            elsif WRITE_EN = '1' and FULL = '0' then
                memory(write_ptr) <= DATA_IN;
                write_ptr <= (write_ptr + 1) mod 128;
            end if;

            if READ_EN = '1' and EMPTY = '0' then
                DATA_OUT <= memory(read_ptr);
                read_ptr <= (read_ptr + 1) mod 128;
            end if;
        end if;
    end process;

    EMPTY <= '1' when read_ptr = write_ptr else '0';
    FULL <= '1' when (write_ptr + 1) mod 128 = read_ptr else '0';

end Behavioral;
