library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Delay_Line is
end TB_Delay_Line;

architecture Behavioral of TB_Delay_Line is
    -- Composant testé
    component Delay_Line
        Port (
            CLK : in STD_LOGIC;
            RESET : in STD_LOGIC;
            PIXEL_IN : in STD_LOGIC_VECTOR(7 downto 0);
            LINE_0 : out STD_LOGIC_VECTOR(7 downto 0);
            LINE_1 : out STD_LOGIC_VECTOR(7 downto 0);
            LINE_2 : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signaux internes pour connecter le composant
    signal CLK : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal PIXEL_IN : STD_LOGIC_VECTOR(7 downto 0);
    signal LINE_0 : STD_LOGIC_VECTOR(7 downto 0);
    signal LINE_1 : STD_LOGIC_VECTOR(7 downto 0);
    signal LINE_2 : STD_LOGIC_VECTOR(7 downto 0);

    -- Constantes pour générer l'horloge
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instanciation du module Delay_Line
    DUT: Delay_Line
        port map (
            CLK => CLK,
            RESET => RESET,
            PIXEL_IN => PIXEL_IN,
            LINE_0 => LINE_0,
            LINE_1 => LINE_1,
            LINE_2 => LINE_2
        );

    -- Génération de l'horloge
    CLK_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimuli de simulation
    stimulus_process : process
    begin
        -- Initialisation
        RESET <= '1';
        PIXEL_IN <= (others => '0');
        wait for 20 ns;

        RESET <= '0';
        wait for 10 ns;

        -- Envoi des pixels simulés
        for i in 0 to 127 loop
            PIXEL_IN <= std_logic_vector(to_unsigned(i, 8)); -- Données en incrément
            wait for CLK_PERIOD;
        end loop;

        -- Arrêt de la simulation
        wait;
    end process;

end Behavioral;
