library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity rom is
  generic (n: integer := 5;
           m: integer := 14);
  port (addr: in std_logic_vector (n-1 downto 0);
        enable: in std_logic;
        data: out std_logic_vector (m-1 downto 0));
end entity rom;


architecture flag_arch of rom is
  type rm is array(0 to 2**n-1) of std_logic_vector (m-1 downto 0);
  signal word: rm;
  signal initialized: boolean := false;
begin
  memory: process (enable ,addr) is 
    begin
      if not initialized then 
        --for index in word'range loop 
         --word(index) <= conv_std_logic_vector(index*index,m);
        --end loop;
        
        --writing to rom
        word(0) <= conv_std_logic_vector(129,m); --00
        word(1) <= conv_std_logic_vector(134,m); --03
        word(2) <= conv_std_logic_vector(160,m);  --06
        word(3) <= conv_std_logic_vector(132,m); --09
        word(4) <= conv_std_logic_vector(10130,m); --12
        word(5) <= conv_std_logic_vector(10148,m); --15
        word(6) <= conv_std_logic_vector(10112,m); --18
        word(7) <= conv_std_logic_vector(2383,m); --21
        word(8) <= conv_std_logic_vector(129,m); --00
        word(9) <= conv_std_logic_vector(134,m); --03
        word(10) <= conv_std_logic_vector(204,m); --04
        word(11) <= conv_std_logic_vector(160,m); --06
        word(12) <= conv_std_logic_vector(143,m); --07
        word(13) <= conv_std_logic_vector(132,m); --09
        word(14) <= conv_std_logic_vector(10,m); --10
        word(15) <= conv_std_logic_vector(10130,m); --12
        word(16) <= conv_std_logic_vector(129,m); --00
        word(17) <= conv_std_logic_vector(134,m); --03
        word(18) <= conv_std_logic_vector(204,m); --04
        word(19) <= conv_std_logic_vector(164,m); --05
        word(20) <= conv_std_logic_vector(160,m); --06
        word(21) <= conv_std_logic_vector(143,m); --07
        word(22) <= conv_std_logic_vector(128,m); --08
        word(23) <= conv_std_logic_vector(132,m); --09
        ------------------------------
        initialized <= true;
      end if ;
      --reading from rom
      if enable = '1' then 
        data <= word (conv_integer(addr));
      else 
        data <= (others => 'Z');
      end if;
    end process memory;
  end architecture flag_arch;
  
    
        
      
   
   

      
              
  
  
