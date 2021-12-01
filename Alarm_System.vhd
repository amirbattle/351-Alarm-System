library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Inputs and Outputs
entity Alarm_System is
  Port ( clk, btn : IN std_logic;
         is_on: IN std_logic;
         inputs : IN std_logic_vector(3 downto 0);
         pir : IN std_logic;
         buzzer_out : OUT std_logic;
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

-- Buzzer
component buzzer IS
    PORT (
      clk: IN STD_LOGIC; ---assumes 100 MHz input
      buzz_en: IN STD_LOGIC;  -- active high if buzzer_out is to be sounded
      output_sig: OUT STD_LOGIC);
END component;

-- Signals for logic
signal code : std_logic_vector(3 downto 0);
signal LED_act : std_logic_vector(1 downto 0) := "00";
signal LED_out : std_logic_vector(3 downto 0) := "0000";
signal press : std_logic;
signal counter : std_logic_vector(7 downto 0) := "11111111";
signal rst_count: std_logic := '0';
signal en_count: std_logic := '0';
signal is_actually_on: std_logic := '0';
signal trigger_buzzer: std_logic := '0';
signal ticks : integer range 0 to 1999999 := 0; -- Signal for counting clock periods
signal pir_pos_ticks : integer range 0 to 1999999 := 0; -- Signal for counting clock periods in which PIR is high

begin
    
    rst_count <= '1' when press = '1' and inputs = "1011" else '0';
    is_actually_on <= '1' when is_on = '1' or en_count = '1' or trigger_buzzer = '1' else '0';

    btn_pulse_inst: button_pulse port map(CLK => clk, BTNC => btn, DB => press);
    timer_count_inst: timer_countdown port map (clk => clk, rst => rst_count, en => en_count, counter => counter);
    sev_seg_inst: sev_seg port map(clk => clk, d0 => counter(3 downto 0), d1 => counter(7 downto 4), is_on => is_actually_on, LED => LED, AN => anode);
    buzzer_inst: buzzer port map(clk => clk, buzz_en => trigger_buzzer, output_sig => buzzer_out);
    
    -- Trigger buzzer_out when countdown reaches zero
    process(counter, rst_count)
    begin
        if counter = "00000000" then
            trigger_buzzer <= '1';
        else
            trigger_buzzer <= '0';
        end if;
        
        if rst_count = '1' then
            trigger_buzzer <= '0';
        end if;
    end process;

    --  If PIR signal is high for long enough in given time chunk, trigger alarm countdown
    process(clk, rst_count)
    begin
        if rising_edge(clk) and is_actually_on = '1' then
            if ticks = 199999999 then
                if pir_pos_ticks > 149999999 then
                    en_count <= '1';
                end if;
                
                ticks <= 0;
                pir_pos_ticks <= 0;
            else
                ticks <= ticks + 1;
                
                if pir = '1' then
                    pir_pos_ticks <= pir_pos_ticks + 1;
                end if;
            end if;
        end if;
        
        if rst_count = '1' then
            en_count <= '0';
        end if;
    end process;

end Behavioral;
