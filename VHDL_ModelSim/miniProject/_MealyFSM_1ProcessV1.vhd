LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fsm IS
  PORT( clk, reset: IN std_logic;
        Tcount: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        Pcount: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        BackSensor, FrontSensor: IN std_logic;
        EnCounter: OUT std_logic;
        FullFlag,EmptyFlag: OUT std_logic;
        Address: BUFFER STD_LOGIC_VECTOR (4 DOWNTO 0);
        UD: OUT std_logic);
END ENTITY fsm;

ARCHITECTURE mealy_1p OF fsm IS
  TYPE state_type IS (Inc, Dec, Idle);
  SIGNAL current_state: state_type;
BEGIN
  same: PROCESS (clk, reset, current_state, BackSensor, FrontSensor, Tcount, Pcount)
  BEGIN
    IF reset = '1' THEN
      current_state <= Idle;
    ELSIF rising_edge (clk) THEN
      CASE current_state IS
      WHEN Idle =>
        IF reset = '0' AND BackSensor'event AND BackSensor = '0' THEN
          current_state <= Inc;
        ELSIF reset = '0' AND FrontSensor'event AND FrontSensor = '0' THEN
          current_state <= Dec;
        ELSE
          current_state <= Idle;
        END IF;
        
      WHEN Inc =>
        IF reset = '1' OR (reset = '0' AND FrontSensor'event AND FrontSensor = '0' AND BackSensor'event AND BackSensor = '0') THEN
          current_state <= Idle;
        ELSIF reset = '0' AND BackSensor'event AND BackSensor = '0' THEN
          current_state <= Inc;
        ELSE
          current_state <= Idle;
        END IF;
        
      WHEN Dec =>
        IF reset = '0' AND FrontSensor'event AND FrontSensor = '0' THEN
          current_state <= Dec;
        ELSE
          current_state <= Idle;
        END IF;
        
      END CASE;
    END IF;
    
    -- output
    CASE current_state IS
    WHEN Inc =>
      EnCounter <= '1';
      UD <= '1';
    
    
    WHEN Dec =>
      EnCounter <= '1';
      UD <= '0';
    
      
     WHEN Idle =>
      EnCounter <= '0';
      
      Address <= ((Tcount - 1) * 8 ) + Pcount;
      
      --Full Flag
      IF Pcount = '111' THEN
        FullFlag <= '1';
      ELSE
        FullFlag <= '0';
      END IF;
      --Empty Flag
      IF Pcount = '000' THEN
        EmptyFlag <= '1';
      ELSE
        EmptyFlag <= '0';
      END IF;
      
      
      
      ELSIF Pcount = '0' THEN
        EmptyFlag <= '1';
        y <= '0';
      End IF;
    END CASE;
    
  END PROCESS same;
END ARCHITECTURE mealy_1p;
      