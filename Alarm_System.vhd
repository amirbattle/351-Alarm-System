----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2021 11:14:45 PM
-- Design Name: 
-- Module Name: Alarm_System - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Inputs and Outputs
entity Alarm_System is
  Port ( clk, btn : IN std_logic;
         inputs : IN std_logic_vector(3 downto 0);
         sensor : IN std_logic;
         speaker : OUT std_logic;
         LED : OUT std_logic_vector(6 downto 0);
         anode : OUT std_logic_vector(3 downto 0)
       );   
end Alarm_System;

architecture Behavioral of Alarm_System is
  


-- Debounced pulse code
component debounced is
        port(
            clock: in std_logic;
            kkey: in std_logic;
            ppulse: out std_logic);  
end component;

-- Signals for logic
signal code : std_logic_vector(3 downto 0);
signal LED_act : std_logic_vector(1 downto 0) := "00";
signal LED_out : std_logic_vector(3 downto 0) := "0000";
signal press : std_logic;

begin

-- Creating a port map for the debounced pulse button
pulse: debounced port map(clock => clk, kkey => btn, ppulse => press);


end Behavioral;
