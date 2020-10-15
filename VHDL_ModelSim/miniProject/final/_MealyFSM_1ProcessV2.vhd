LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- to convert between integer and std logic vector
use ieee.numeric_std.all;

ENTITY fsm IS
  PORT( clk, reset: IN std_logic;
        Tcount: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        Pcount: IN std_logic_vector(2 DOWNTO 0);
        BackSensor, FrontSensor: IN std_logic;
        EnCounter: OUT std_logic;
        FullFlag,EmptyFlag: OUT std_logic;
        Address: out STD_LOGIC_VECTOR (4 DOWNTO 0);
        UD: OUT std_logic);
END ENTITY fsm;

ARCHITECTURE mealy_1p OF fsm IS
  TYPE state_type IS (Inc, Dec, Idle);
  SIGNAL current_state: state_type := Idle;
  SIGNAL AddressS: INTEGER:=0;
  SIGNAL TcountS: INTEGER:=0;
  SIGNAL PcountS: INTEGER:=0;
BEGIN
  same: PROCESS (clk, reset, current_state, BackSensor, FrontSensor, Tcount, Pcount)
  BEGIN
    IF reset = '1' THEN
      current_state <= Idle;
    ELSE  --ELSIF falling_edge (clk) THEN
      CASE current_state IS
      WHEN Idle =>
        IF  BackSensor'event AND BackSensor = '0' THEN
          current_state <= Inc;
        ELSIF FrontSensor'event AND FrontSensor = '0' THEN
          current_state <= Dec;
        ELSE
          current_state <= Idle;
        END IF;
        
      WHEN Inc =>
        IF  FrontSensor'event AND FrontSensor = '0' AND BackSensor'event AND BackSensor = '0' THEN
          current_state <= Idle;
        ELSIF clk'event AND clk = '1' then 
          current_state <= Idle;
        ELSE --BackSensor'event AND BackSensor = '0' THEN
          current_state <= Inc;
        --ELSE
        --current_state <= Idle;
        END IF;
        
      WHEN Dec =>
        IF FrontSensor'event AND FrontSensor = '0' THEN
          current_state <= Dec;
        ELSIF clk'event AND clk = '1' then 
          current_state <= Idle;
        ELSIF  FrontSensor'event AND FrontSensor = '0' AND BackSensor'event AND BackSensor = '0' THEN
          current_state <= Idle;
        ELSE
          current_state <= Dec;
        END IF;
        
      END CASE;
    END IF;
    
    -- output
    CASE current_state IS
    WHEN Inc =>
      if Pcount = "111" then
        EnCounter <= '0';
     else 
        EnCounter <= '1';
      end if;
      UD <= '1';
    
    
    WHEN Dec =>
      if Pcount = "000" then
        EnCounter <= '0';
     else 
        EnCounter <= '1';
      end if;
      UD <= '0';
    
      
    WHEN Idle =>
      EnCounter <= '0';
      
      --AddressS<=to_integer(unsigned(Address));
      TcountS<= to_integer(unsigned(Tcount));
      PcountS<= to_integer(unsigned(Pcount));
      
      
      ----Address <= ((Tcount - 1) * 8 ) + Pcount; --error
      AddressS <= ((TcountS - 1) * 8 ) + PcountS;
      ----Address <= AddressS;
      ---- This line demonstrates how to convert positive integers
      Address <= std_logic_vector(to_unsigned(AddressS, Address'length));
      
      ----Full Flag
      IF Pcount = "111" THEN --error
        FullFlag <= '1';
      ELSE
        FullFlag <= '0';
      END IF;
      --Empty Flag
      IF Pcount = "000" THEN --error
        EmptyFlag <= '1';
      ELSE
        EmptyFlag <= '0';
      END IF;
      
      
      
      --ELSIF Pcount = '0' THEN
      --  EmptyFlag <= '1';
      --  y <= '0';
      --End IF;
    END CASE;
    
  END PROCESS same;
END ARCHITECTURE mealy_1p;
      
