
ENTITY and2 IS
PORT(a,b: IN bit ;
      c: OUT bit);
    END ENTITY and2;
    
    ARCHITECTURE and2 OF and2 IS
      BEGIN 
        p1: PROCESS(a,b) IS BEGIN
        c<= a AND b;
      END PROCESS p1;
    END ARCHITECTURE and2;
    
  