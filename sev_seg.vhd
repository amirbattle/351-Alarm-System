library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sev_seg is
    Port (
            clk: in std_logic;
            d0: in std_logic_vector(3 downto 0);
            d1: in std_logic_vector(3 downto 0);
            is_on: in std_logic;
            LED: out std_logic_vector(6 downto 0);
            AN: out std_logic_vector(3 downto 0)
          );
end sev_seg;

architecture Behavioral of sev_seg is

    signal cur_disp: integer range 0 to 3 := 0;
    signal clk_counter: integer range 0 to 99999 := 0;
    signal clk_div: std_logic := '0';

begin
    
    process(clk)
    begin
        if rising_edge(clk) then
            if clk_counter = 99999 then
                clk_counter <= 0;
                clk_div <= NOT(clk_div);
            else
                clk_counter <= clk_counter + 1;
            end if;
        end if;
    end process;
    
    process(clk_div)
    begin
        if rising_edge(clk_div) then
            if cur_disp = 0 then
                cur_disp <= 1;
                AN(0) <= '0';
                AN(1) <= '1';
                AN(2) <= '1';
                AN(3) <= '1';
                
                LED(0) <= (NOT(d0(3)) and NOT(d0(2)) and NOT(d0(1)) and d0(0)) or (NOT(d0(3)) and d0(2) and NOT(d0(1)) and NOT(d0(0))) or (d0(3) and d0(2) and NOT(d0(1)) and d0(0)) or (d0(3) and NOT(d0(2)) and d0(1) and d0(0));
                LED(1) <= (d0(2) and d0(1) and NOT(d0(0))) or (d0(3) and d0(1) and d0(0)) or (d0(3) and d0(2) and NOT(d0(0))) or (NOT(d0(3)) and d0(2) and NOT(d0(1)) and d0(0));
                LED(2) <= (NOT(d0(3)) and NOT(d0(2)) and d0(1) and NOT(d0(0))) or (d0(3) and d0(2) and NOT(d0(1)) and NOT(d0(0))) or (d0(3) and d0(2) and d0(1));
                LED(3) <= (d0(2) and d0(1) and d0(0)) or (NOT(d0(3)) and NOT(d0(2)) and NOT(d0(1)) and d0(0)) or (NOT(d0(3)) and d0(2) and NOT(d0(1)) and NOT(d0(0))) or (d0(3) and NOT(d0(2)) and d0(1) and NOT(d0(0)));
                LED(4) <= (NOT(d0(3)) and d0(0)) or (NOT(d0(3)) and d0(2) and NOT(d0(1))) or (NOT(d0(2)) and NOT(d0(1)) and d0(0));
                LED(5) <= (NOT(d0(3)) and NOT(d0(2)) and d0(0)) or (NOT(d0(3)) and NOT(d0(2)) and d0(1)) or (NOT(d0(3)) and d0(1) and d0(0)) or (d0(3) and d0(2) and NOT(d0(1)) and d0(0));
                LED(6) <= (NOT(d0(3)) and NOT(d0(2)) and NOT(d0(1))) or (NOT(d0(3)) and d0(2) and d0(1) and d0(0)) or (d0(3) and d0(2) and NOT(d0(1)) and NOT(d0(0)));
            elsif cur_disp = 1 then
                cur_disp <= 2;
                AN(0) <= '1';
                AN(1) <= '0';
                AN(2) <= '1';
                AN(3) <= '1';
                
                LED(0) <= (NOT(d1(3)) and NOT(d1(2)) and NOT(d1(1)) and d1(0)) or (NOT(d1(3)) and d1(2) and NOT(d1(1)) and NOT(d1(0))) or (d1(3) and d1(2) and NOT(d1(1)) and d1(0)) or (d1(3) and NOT(d1(2)) and d1(1) and d1(0));
                LED(1) <= (d1(2) and d1(1) and NOT(d1(0))) or (d1(3) and d1(1) and d1(0)) or (d1(3) and d1(2) and NOT(d1(0))) or (NOT(d1(3)) and d1(2) and NOT(d1(1)) and d1(0));
                LED(2) <= (NOT(d1(3)) and NOT(d1(2)) and d1(1) and NOT(d1(0))) or (d1(3) and d1(2) and NOT(d1(1)) and NOT(d1(0))) or (d1(3) and d1(2) and d1(1));
                LED(3) <= (d1(2) and d1(1) and d1(0)) or (NOT(d1(3)) and NOT(d1(2)) and NOT(d1(1)) and d1(0)) or (NOT(d1(3)) and d1(2) and NOT(d1(1)) and NOT(d1(0))) or (d1(3) and NOT(d1(2)) and d1(1) and NOT(d1(0)));
                LED(4) <= (NOT(d1(3)) and d1(0)) or (NOT(d1(3)) and d1(2) and NOT(d1(1))) or (NOT(d1(2)) and NOT(d1(1)) and d1(0));
                LED(5) <= (NOT(d1(3)) and NOT(d1(2)) and d1(0)) or (NOT(d1(3)) and NOT(d1(2)) and d1(1)) or (NOT(d1(3)) and d1(1) and d1(0)) or (d1(3) and d1(2) and NOT(d1(1)) and d1(0));
                LED(6) <= (NOT(d1(3)) and NOT(d1(2)) and NOT(d1(1))) or (NOT(d1(3)) and d1(2) and d1(1) and d1(0)) or (d1(3) and d1(2) and NOT(d1(1)) and NOT(d1(0)));
            elsif cur_disp = 2 then
                cur_disp <= 3;
                AN(0) <= '1';
                AN(1) <= '1';
                AN(2) <= '0';
                AN(3) <= '1';
                
                if is_on = '0' then
                    LED(0) <= '0';
                    LED(1) <= '1';
                    LED(2) <= '1';
                    LED(3) <= '1';
                    LED(4) <= '0';
                    LED(5) <= '0';
                    LED(6) <= '0';
                else
                    LED(0) <= '1';
                    LED(1) <= '1';
                    LED(2) <= '0';
                    LED(3) <= '1';
                    LED(4) <= '0';
                    LED(5) <= '1';
                    LED(6) <= '0';
                end if;
            elsif cur_disp = 3 then
                cur_disp <= 0;
                AN(0) <= '1';
                AN(1) <= '1';
                AN(2) <= '1';
                AN(3) <= '0';
                
                LED(0) <= '1';
                LED(1) <= '1';
                LED(2) <= '0';
                LED(3) <= '0';
                LED(4) <= '0';
                LED(5) <= '1';
                LED(6) <= '0';
            end if;
        end if;
    end process;
    
end Behavioral;
