

ENTITY latch4 IS
  PORT (d: IN bit_vector (3 DOWNTO 0); 
        q:OUT bit_vector (3 DOWNTO 0);
        en,clk:IN bit);
    END ENTITY latch4 ;
 
CONFIGURATION struct_conf OF latch4 IS
  FOR struct
    FOR ALL:latch USE ENTITY WORK.latch(behave);
    END FOR;
    FOR gate:and2 USE ENTITY WORK.and2(and2);
    END FOR;
  END FOR;
END CONFIGURATION struct_conf;
    

ARCHITECTURE struct2 OF latch4 IS 
COMPONENT latch
  PORT(d,clk:IN bit;q,nq:OUT bit);
  END COMPONENT latch;
COMPONENT and2 
  PORT(a,b:IN bit;c:OUT bit);
  END COMPONENT and2;
  SIGNAL int_clk:bit;  
BEGIN
  bit3:latch
  PORT MAP (d(3),int_clk,q(3));
  bit2:latch
  PORT MAP (d(2),int_clk,q(2));
  bit1:latch
  PORT MAP (d(1),int_clk,q(1));
  bit0:latch
  PORT MAP (d(0),int_clk,q(0));
  gate:and2
  PORT MAP (en,clk,int_clk);   
 END ARCHITECTURE struct2;