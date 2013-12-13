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
	output	:out  std_logic);

end entity;


architecture Behavioural of signalgenerator_2 is
constant counter_max : integer := 10;
begin

generator : process (clk,reset) is

variable counter : integer := 0;
variable j : integer := 0;
variable n : integer := 1;
variable periodic_cylce : integer :=0;
variable is_output_cycle : integer := 0;
begin
	periodic_cylce := 0; -- prepare first cycle
	--wait until rising_edge(clk);
			--exit when reset='1';
	if reset = '1' then
		n:=1;
		j:=0;
		output <= '0';
		is_output_cycle := 0;
	end if;
			
	if( is_output_cycle = 0) then
		-- controll n
		if n = counter_max then  
			n := 1;
			j:=0;--will be incremented in th next if statement
		end if;
		--controll j
		if(j < n) then --if j reaches maximum n , than n will be incremented
			j := j + 1;
		else
			j:=1;
			n := n + 1;
		end if;
		-- intialize anything else
		is_output_cycle := 1;
		periodic_cylce := 0;
		counter := j;
	end if;
	
	
	if(is_output_cycle = 1)  then -- this is processing part which controls output
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
				is_output_cycle := 0;
			end if;
		end if;
	end if;
				

end process generator;
end architecture ;