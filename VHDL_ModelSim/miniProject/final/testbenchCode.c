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
    FOR system_mealy_2p : system USE ENTITY work.system (struct);
        
   SIGNAL frontsensor,backsensor,sysreset,sysclk :  std_logic;
   SIGNAL  tcount : std_logic_vector ( 1 downto 0);
   SIGNAL  fullflag,emptyflag :std_logic ;
   SIGNAL sysSeven_Segment :  STD_LOGIC_VECTOR (6 DOWNTO 0);
   SIGNAL sysWtime: std_logic_vector (13 downto 0);
   

    BEGIN
      system_mealy_2p : system 
      port map (frontsensor,backsensor,sysreset,sysclk,tcount,fullflag,emptyflag,sysSeven_Segment,sysWtime);
      clock: PROCESS IS
      BEGIN
        
        WAIT FOR 20 ns;
      if sysclk <= '0' then sysclk <= '1';
    else sysclk <= '0';
  end if;  
      END PROCESS clock;
      
      sg: PROCESS IS
      
      BEGIN
        frontsensor <='1';  wait for 20 ns;       --1
        backsensor <='1';   wait for 20 ns ; 
        sysreset <='0';   wait for 20 ns  ;
        tcount <= "01";    wait for 20 ns  ;
       
               frontsensor <='1';  wait for 20 ns;       --1
        backsensor <='0';   wait for 20 ns ; 
        sysreset <='0';   wait for 20 ns  ;
        tcount <= "01";    wait for 20 ns  ;
        
        frontsensor <='0';  wait for 20 ns;       --1
        backsensor <='0';   wait for 20 ns ; 
        sysreset <='0';   wait for 20 ns  ;
        tcount <= "01";    wait for 20 ns  ;
        
                frontsensor <='1';  wait for 20 ns;       --1
        backsensor <='1';   wait for 20 ns ; 
        sysreset <='0';   wait for 20 ns  ;
        tcount <= "11";    wait for 20 ns  ; 
     
      ASSERT fullflag='0';
        REPORT "ERROR :     "
        SEVERITY warning;      
      ASSERT emptyflag='0';
        REPORT "ERROR :     "
        SEVERITY warning;
      ASSERT sysSeven_Segment="0000001";
        REPORT "ERROR :     "
        SEVERITY warning;
      ASSERT sysWtime="00000010000001";
        REPORT "ERROR :     "
        SEVERITY warning;
  
      
    end process sg;
  end ARCHITECTURE tb_arch;