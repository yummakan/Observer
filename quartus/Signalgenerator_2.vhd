LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity signalgenerator_2 is
-- Generic ( n: integer   := 100;  -- counter maximum for outer loop 
 --      ); 
port (

   clk 		:in	std_logic;
	reset		:in 	std_logic;
	--divider	:in 	std_logic_vector(3 downto 0);
	output	:out  std_logic :='0');

end entity;


architecture Behavioural of signalgenerator_2 is
--Declaration in the whole architecture
constant counter_max : integer := 10;
shared variable counter : integer := 0;
shared variable j : integer := 0;
shared variable n : integer := 1;
shared variable is_output_cycle : boolean := false;
shared variable periodic_cylce : integer :=0;

signal drive_output : std_logic := '0';
begin --BEGIN ARCHITECTURE
  


-- COMBINATORICAL DATAFLOW
generator_controll : process (clk) is --  BEGIN PROCESS GENERATORE
begin
    if(clk'event) then
     -- controlling flow 
    	if( is_output_cycle = false and reset = '0') then
    		-- controll n
    		if n = counter_max then  
    			n := 1;
    			j := 0;--will be incremented in th next if statement
    		end if;
    		--controll j
    		if(j < n) then --if j reaches maximum n , than n will be incremented
    			j := j + 1;
    		else
    			j := 1;
    			n := n + 1;
    		end if;
    		-- intialize anything else
    		periodic_cylce := 0;
    		counter := j;
    		is_output_cycle :=  true;    		
    	end if;
  	end if;
end process generator_controll; --  END PROCESS GENERATORE

-- COMBINATORICAL DATAFLOW
generator_drive: process(clk) -- BEGIN PROCESS SYNC
variable initialize : boolean := true ;
begin
  if(initialize = true) then
      drive_output <= '0';
      initialize := false;
  end if;
  if(rising_edge(clk)) then
    	-- driven flow
    	if(is_output_cycle = true and reset = '0')  then -- this is processing part which controls output
      		if(periodic_cylce = 0) then -- first half of a period starts with output = 0
      			if (counter > 0) then
      				output <= '0';
      				counter := counter - 1;
      			else
      				counter := j; --prepare for next periodic cycle
      				periodic_cylce := 1;
      			end if;
      		end if;
      
      		if(periodic_cylce = 1) then-- second half of a period starts with output = 1
      			if(counter > 0) then
      				output <= '1';
      				counter := counter - 1;
      			else
      				is_output_cycle := false;
      			end if;
      		end if;
   	 end if;
 	end if;
end process generator_drive; -- END PROCESS SYNC

-- REGISTERED PROCESS
reset_process : process(reset) is -- BEGIN PROCESS RESET_PROCESS
begin
  if(reset = '1') then 
    n := 1;
	  j := 0;
	  --output <= '0';
	  is_output_cycle := true;
	end if;
end process reset_process; -- END PROCESS RESET_PROCESS








end architecture ; --END ARCHITECTURE
