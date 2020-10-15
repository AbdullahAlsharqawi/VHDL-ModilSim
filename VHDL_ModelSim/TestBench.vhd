LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY system_tb IS
END ENTITY system_tb;

ARCHITECTURE tb_arch OF system_tb IS
  COMPONENT system
   PORT ( frontsensor,backsensor,sysreset,sysclk : IN std_logic;
   tcount : IN std_logic_vector ( 1 downto 0);
   fullflag,emptyflag :OUT std_logic ;
   sysSeven_Segment : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
   sysWtime: out std_logic_vector (13 downto 0) );
   END COMPONENT system;
    
    SIGNAL frontsensor,backsensor,sysreset,sysclk : std_logic;
 SIGNAL  tcount : std_logic_vector ( 1 downto 0);
  SIGNAL fullflag,emptyflag : std_logic ;
  SIGNAL sysSeven_Segment :  STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL sysWtime:  std_logic_vector (13 downto 0) ;
   
    FOR system_mealy_2p:system USE ENTITY work.system (tb_arch);
    BEGIN
      clock: PROCESS IS
      BEGIN
        clk <= '0','1' after 10 ns;
        WAIT FOR 20 ns;
      END PROCESS clock;
      
      sg: PROCESS IS
      BEGIN
        frontsensor <='1';
        WAIT FOR 10 ns;
        
      
  
