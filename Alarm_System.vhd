library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Inputs and Outputs
entity Alarm_System is
  Port ( clk, btn : IN std_logic;
         is_on: IN std_logic;
         inputs : IN std_logic_vector(3 downto 0);
         pir : IN std_logic;
         buzzer : OUT std_logic;
         LED : OUT std_logic_vector(6 downto 0);
         anode : OUT std_logic_vector(3 downto 0)
       );   
end Alarm_System;

architecture Behavioral of Alarm_System is

-- Debounced pulse
component button_pulse is
    Port ( CLK : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           DB : out STD_LOGIC);
end component;

-- Seven segment display
component sev_seg is
    Port (
            clk: in std_logic;
            d0: in std_logic_vector(3 downto 0);
            d1: in std_logic_vector(3 downto 0);
            is_on: in std_logic;
            LED: out std_logic_vector(6 downto 0);
            AN: out std_logic_vector(3 downto 0)
          );
end component;

-- Timer countdown
component timer_countdown is
    Port (
            clk: in std_logic;
            en: in std_logic;
            rst: in std_logic;
            counter: out std_logic_vector(7 downto 0)
         );
end component;

-- Signals for logic
signal code : std_logic_vector(3 downto 0);
signal LED_act : std_logic_vector(1 downto 0) := "00";
signal LED_out : std_logic_vector(3 downto 0) := "0000";
signal press : std_logic;
signal counter : std_logic_vector(7 downto 0) := "11111111";
signal rst_count: std_logic := '0';
signal en_count: std_logic := '0';
signal ticks : integer; -- Signal for counting clock periods

begin

    rst_count <= '1' when press = '1' and inputs = "1011" else '0';

    btn_pulse_inst: button_pulse port map(CLK => clk, BTNC => btn, DB => press);
    timer_count_inst: timer_countdown port map (clk => clk, rst => rst_count, en => en_count, counter => counter);
    sev_seg_inst: sev_seg port map(clk => clk, d0 => counter(3 downto 0), d1 => counter(7 downto 4), is_on => is_on, LED => LED, AN => anode);
    
    process(clk)
    begin
        if rising_edge(clk) then
            if pir = '1' then
                if ticks = 5e6 - 1 then
                    en_count <= pir; ticks <= 0;
                    
                else
                    ticks <= ticks + 1;
                end if;
            else
                en_count <= '0';
            end if;
        end if;
    end process;     
                    
                 
    
    process(counter)
    begin
        if counter = "00000000" then
            buzzer <= '1';
        else
            buzzer <= '0';
        end if;
    end process;
end Behavioral;
