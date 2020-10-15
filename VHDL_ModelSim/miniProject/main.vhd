library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity system is
  PORT ( frontsensor,backsensor,sysreset,sysclk : IN std_logic;
  tcount : IN std_logic_vector ( 1 downto 0);
  fullflag,emptyflag :OUT std_logic ;
  sysSeven_Segment : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
  sysWtime: out std_logic_vector (13 downto 0) ); 
end entity system;

architecture struct of system is
  signal sysUD ,signalen : std_logic;
  --signal notreset : bit ; 
  signal sysaddr : std_logic_vector (4 Downto 0);
  signal sysPcount : std_logic_vector (2 DOWNTO 0);
  signal sys_preset: std_logic := '0'; 
  signal sys_din: std_logic_vector (2 downto 0):= "000";
component rom
    generic (n: integer := 5;
             m: integer := 14);
    port (addr: in std_logic_vector (n-1 downto 0);
          enable: in std_logic;
          data: out std_logic_vector (m-1 downto 0));
end component rom;  

component udcounter
    generic (n : positive :=3);
    port (clk ,ud ,clear ,enable: in std_logic;
        preset: IN std_logic;
        d_in: IN std_logic_vector (n-1 downto 0);
        d_out: OUT std_logic_vector (n-1 downto 0));
end component udcounter; 

component fsm 
    PORT( clk, reset: IN std_logic;
    
        Tcount: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        Pcount: IN std_logic_vector (2 DOWNTO 0);
        BackSensor, FrontSensor: IN std_logic;
        EnCounter: OUT std_logic;
        FullFlag,EmptyFlag: OUT std_logic;
        Address: BUFFER STD_LOGIC_VECTOR (4 DOWNTO 0);
        UD: OUT std_logic);
end component fsm ; 

component bcd_7segment
  PORT ( BCDin : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
         Seven_Segment : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
end component bcd_7segment; 


for m: rom
use entity work.rom(flag_arch);

for c: udcounter
use entity work.udcounter(behav);

for f: fsm 
use entity work.fsm(mealy_1p);

for d: bcd_7segment
use entity work.bcd_7segment(Behavioral);



begin
  --if reset = '1'  then 
   -- notreset <= '0';
  --else 
   -- notreset <= '1';
  --end if;
  --notreset <= (not reset);
  
  --generic (n: integer := 5;
  --         m: integer := 14);
  --port (addr: in std_logic_vector (n-1 downto 0);
  --      enable: in bit;
  --     data: out std_logic_vector (m-1 downto 0));
  m:rom port map (addr => sysaddr, enable=> sysreset, data=> sysWtime);
      --generic (n : positive :=3);
      --port (clk ,ud ,clear ,enable: in std_logic;
      -- preset: IN std_logic;
      --d_in: IN std_logic_vector (n-1 downto 0);
      --d_out: OUT std_logic_vector (n-1 downto 0));
  c:udcounter port map (clk => sysclk, ud=> sysUD,clear=> sysreset ,enable=> signalen ,preset=> sys_preset ,d_in=>sys_din,d_out=> sysPcount);
      --PORT( clk, reset: IN std_logic;
      --  Tcount: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      --  Pcount: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      --  BackSensor, FrontSensor: IN std_logic;
      --  EnCounter: OUT std_logic;
      --  FullFlag,EmptyFlag: OUT std_logic;
      --  Address: BUFFER STD_LOGIC_VECTOR (4 DOWNTO 0);
      --  UD: OUT std_logic);
  f:fsm port map (clk=> sysclk, reset=> sysreset, Tcount=> tcount,Pcount=> sysPcount,BackSensor=>backsensor , FrontSensor=>frontsensor , EnCounter=>signalen , FullFlag=> fullflag, EmptyFlag=> emptyflag, Address=> sysaddr, UD=> sysUD);
  --PORT ( BCDin : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
  --Seven_Segment : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
  d:bcd_7segment port map (BCDin=> sysPcount, Seven_Segment=> sysSeven_Segment);
end architecture struct;