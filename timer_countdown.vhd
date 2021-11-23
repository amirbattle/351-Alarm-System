library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity timer_countdown is
    Port (
            clk: in std_logic;
            en: in std_logic;
            rst: in std_logic;
            counter: out std_logic_vector(7 downto 0)
         );
end timer_countdown;

architecture Behavioral of timer_countdown is

    signal tick: integer range 0 to 99999999 := 0;
    signal counter_int: integer range 0 to 15 := 15;

begin

    counter(3 downto 0) <= std_logic_vector(to_unsigned(counter_int mod 10, 4));
    counter(7 downto 4) <= std_logic_vector(to_unsigned(counter_int/10, 4));

    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                if tick = 99999999 then
                    tick <= 0;
                    if counter_int /= 0 then
                        counter_int <= counter_int - 1;
                    end if;
                else
                    tick <= tick + 1;
                end if;
            end if;
            
            if rst = '1' then
                tick <= 0;
                counter_int <= 15;
            end if;
        end if;
    end process;

end Behavioral;
