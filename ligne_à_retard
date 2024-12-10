library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Delay_Line is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        PIXEL_IN : in STD_LOGIC_VECTOR(7 downto 0);  -- Pixel entrant
        LINE_0 : out STD_LOGIC_VECTOR(7 downto 0);   -- Ligne actuelle
        LINE_1 : out STD_LOGIC_VECTOR(7 downto 0);   -- Ligne précédente
        LINE_2 : out STD_LOGIC_VECTOR(7 downto 0)    -- Deux lignes précédentes
    );
end Delay_Line;

architecture Behavioral of Delay_Line is
    -- FIFO instances
    signal FIFO_OUT_1, FIFO_OUT_2 : STD_LOGIC_VECTOR(7 downto 0);
    signal FIFO_EMPTY_1, FIFO_EMPTY_2 : STD_LOGIC;
    signal FIFO_FULL_1, FIFO_FULL_2 : STD_LOGIC;

    -- Control signals
    signal WRITE_EN, READ_EN : STD_LOGIC;
begin
    -- First FIFO (delays by one line)
    FIFO1: entity work.FIFO
        port map (
            CLK => CLK,
            RESET => RESET,
            DATA_IN => PIXEL_IN,
            WRITE_EN => WRITE_EN,
            READ_EN => READ_EN,
            DATA_OUT => FIFO_OUT_1,
            EMPTY => FIFO_EMPTY_1,
            FULL => FIFO_FULL_1
        );

    -- Second FIFO (delays by another line)
    FIFO2: entity work.FIFO
        port map (
            CLK => CLK,
            RESET => RESET,
            DATA_IN => FIFO_OUT_1,
            WRITE_EN => WRITE_EN,
            READ_EN => READ_EN,
            DATA_OUT => FIFO_OUT_2,
            EMPTY => FIFO_EMPTY_2,
            FULL => FIFO_FULL_2
        );

    -- Output assignment
    LINE_0 <= PIXEL_IN;       -- Ligne actuelle
    LINE_1 <= FIFO_OUT_1;     -- Ligne précédente
    LINE_2 <= FIFO_OUT_2;     -- Deux lignes précédentes

    -- Control logic (assuming synchronous operation)
    WRITE_EN <= '1';          -- Écriture activée en continu
    READ_EN <= '1';           -- Lecture activée en continu
end Behavioral;
