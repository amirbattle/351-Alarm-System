
-- For this testbench to work with the alarm_system, you must reduce the period on all the counters in Alarm_System.vhd and in it's components.
-- If you want the btn to work for this simulation then you must speed up the clk in CDiv.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Alarm_tb is
--  Port ( );
end Alarm_tb;

architecture Behavioral of Alarm_tb is

component Alarm_System
port ( clk, btn : IN std_logic;
         is_on: IN std_logic;
         inputs : IN std_logic_vector(3 downto 0);
         pir : IN std_logic;
         buzzer_out : OUT std_logic;
         LED : OUT std_logic_vector(6 downto 0);
         anode : OUT std_logic_vector(3 downto 0);
         Led1 : out std_logic
       );   
end component;

signal clk, btn : std_logic := '0';
signal is_on : std_logic := '0';
signal inputs : std_logic_vector(3 downto 0) := "0000";
signal pir : std_logic := '0';
signal buzzer_out : std_logic := '0';
signal LED : std_logic_vector(6 downto 0);
signal anode : std_logic_vector(3 downto 0);
signal Led1 : std_logic;

begin

uut : Alarm_System port map( clk => clk, btn => btn, is_on => is_on, inputs => inputs, pir => pir, buzzer_out => buzzer_out, LED => LED, anode => anode, LED1 =>LED1);

process
begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
end process;

process
begin
    btn <= '0';
    wait for 30 ns;
    btn <= '1';
    wait for 30 ns;
end process;


process
begin
    is_on <='0'; pir <= '1'; wait for 100 ns;
    is_on <= '1'; pir <= '0'; wait for 100 ns;
    is_on <= '1'; pir <= '1';  wait for 790 ns;
    inputs <= "1011"; wait for 30 ns; inputs <= "0000";
   

end process;


end Behavioral;
