
ENTITY counter IS
  PORT( rst, clk: IN bit;
        q: OUT integer);
END ENTITY counter;   

ARCHITECTURE behav OF counter IS
BEGIN
  p1: PROCESS( rst, clk) IS
     VARIABLE temp: integer := 0;
  BEGIN
    IF rst = '1' AND clk = '1' AND clk'event THEN
      temp := 0;
    END IF;
    IF rst = '0' AND clk = '1' AND clk'event THEN
      temp := temp + 1;
    END IF;
    q <= temp;
  END PROCESS p1;
END ARCHITECTURE behav;
