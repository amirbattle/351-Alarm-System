----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2021 04:14:17 PM
-- Design Name: 
-- Module Name: button_pulse - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button_pulse is
    Port ( CLK : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           DB : out STD_LOGIC);
end button_pulse;

architecture Behavioral of button_pulse is

    component SingPul
        PORT (
            Clk1: IN STD_LOGIC; ---a low frequency Clock from CDiv
            Key: IN STD_LOGIC;  -- active low input
            pulse: OUT STD_LOGIC);
    end component;
    
    component CDiv
        PORT (
            Cin	: IN 	STD_LOGIC ;
	       Cout : OUT STD_LOGIC ) ;
	end component;

    signal CLKS: STD_LOGIC;

begin

    cdiv1: CDiv port map(Cin => CLK, Cout => CLKS);
    
    singpul1: SingPul port map(Clk1 => CLKS, Key => BTNC, Pulse => DB);

end Behavioral;
