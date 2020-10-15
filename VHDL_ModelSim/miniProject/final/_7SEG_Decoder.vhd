
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
 
ENTITY bcd_7segment IS
PORT ( BCDin : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
Seven_Segment : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END bcd_7segment;
 
ARCHITECTURE Behavioral OF bcd_7segment IS
 
BEGIN
 
PROCESS(BCDin)
BEGIN
 
CASE BCDin IS
WHEN "000" =>
Seven_Segment <= "0000001"; ---0
WHEN "001" =>
Seven_Segment <= "1001111"; ---1
WHEN "010" =>
Seven_Segment <= "0010010"; ---2
WHEN "011" =>
Seven_Segment <= "0000110"; ---3
WHEN "100" =>
Seven_Segment <= "1001100"; ---4
WHEN "101" =>
Seven_Segment <= "0100100"; ---5
WHEN "110" =>
Seven_Segment <= "0100000"; ---6
WHEN "111" =>
Seven_Segment <= "0001111"; ---7
WHEN OTHERS =>
Seven_Segment <= "1111111"; ---null
END CASE;
 
END PROCESS;
 
END Behavioral;