-- Buzzer sound, assumes 100 MHz clock
LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
USE ieee.STD_LOGIC_UNSIGNED.all;

 

ENTITY buzzer IS

    PORT (
      clk: IN STD_LOGIC; ---assumes 100 MHz input
      buzz_en: IN STD_LOGIC;  -- active high if buzzer is to be sounded
      output_sig: OUT STD_LOGIC);

END buzzer;

-- This will effectively be a clock divider that goes from 100 MHz to about 350 Hz (F4)
ARCHITECTURE behavorial OF buzzer IS

signal counter: std_logic_vector (31 downto 0) := X"00000000";
--00000000000000010000000000000000

BEGIN
  process(clk)
  begin
    if (rising_edge(clk)) then
      counter <= counter + 1;
    end if;
  end process;
  
output_sig <= counter(16) AND buzz_en;

END behavorial;