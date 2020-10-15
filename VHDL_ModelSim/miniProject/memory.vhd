library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
USE ieee.numeric_std.ALL;
use std.textio.all;
entity text_read is
    port(enable : in bit;
	address : in std_logic_vector(4 downto 0);
        dataout : out integer);
    end entity;
    architecture bev of text_read is
        type mem is array (23 downto 0) of integer;
        signal t_mem : mem;
        begin
            process(address, enable)
	   
                FILE f : TEXT;
                constant filename : string :="C:\Modeltech_pe_edu_10.4a\examples\mem.txt";
                VARIABLE L : LINE;
                variable i : integer:=0;
                variable b : integer;
                begin
		 if enable = '1' then
                    
             File_Open (f,FILENAME, read_mode);	
			while ((i<24) and (not EndFile (f))) loop
				readline (f, l);
				next when l(1) = '#'; 
				read(l, b);
				t_mem(i) <= b;
				i := i + 1;
			end loop;
			File_Close (f);                    
	    end if;
            dataout<=t_mem(to_integer(unsigned(address)-8));	--cdataout<=t_mem(conv_integer(address));	
            end process;
        end bev;
