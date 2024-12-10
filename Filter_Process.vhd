library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Filter_Process is
    Port (
        PIXELS : in STD_LOGIC_VECTOR(8*9-1 downto 0); -- 9 pixels in one vector
        COEFFS : in STD_LOGIC_VECTOR(8*9-1 downto 0); -- 9 coefficients
        CLK : in STD_LOGIC;
        OUTPUT : out STD_LOGIC_VECTOR(15 downto 0)
    );
end Filter_Process;

architecture Behavioral of Filter_Process is
    signal MULTIPLIED : signed(17 downto 0);
    signal SUM : signed(17 downto 0) := (others => '0');
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            -- Multiply and sum in one clock cycle
            for i in 0 to 8 loop
                MULTIPLIED <= signed(PIXELS(i*8+7 downto i*8)) * signed(COEFFS(i*8+7 downto i*8));
                SUM <= SUM + MULTIPLIED;
            end loop;
            OUTPUT <= std_logic_vector(SUM(15 downto 0)); -- Normalized
        end if;
    end process;
end Behavioral;
