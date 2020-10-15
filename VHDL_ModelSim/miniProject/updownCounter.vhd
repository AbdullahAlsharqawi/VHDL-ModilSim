library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity udcounter is
  generic (n : positive :=3);
  port (clk , reset ,ud ,clear : in std_logic;
        --count : buffer std_logic_vector (n-1 downto 0) 
        d_in: IN unsigned (n-1 downto 0);
        d_out: OUT unsigned (n-1 downto 0));
        
end entity udcounter; 

architecture behav of udcounter is 
 signal counter: unsigned (n-1 downto 0);
 --signal fullflag: std_logic; 
begin
process (clk) is begin
 -- fullflag<='0';
  --if fullflag='0' then 
   if rising_edge(clk) then
    if clear='1' then
      counter <= (others => '0');
    elsif  reset='1' then 
     counter <= d_in;
    elsif ud='1' then
     counter<=counter+1;
    else 
     counter<=counter-1;
    end if; 
  end if;
-- end if; 
 --if counter='7' then
  -- fullflag<='1';
 --end if;  
end process;
d_out <= counter;
end architecture behav; 
   
         
        
        
    
vriable delay:time : = 5 ns;
boolean 