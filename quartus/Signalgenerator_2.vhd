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
--signal x	: std_logic;	
--variable count_value : natural := 0;

begin
generator : process is
variable counter_max : integer := 100;
variable counter : integer := 0;
variable j : integer := 0;
variable n : integer := 0;
variable periodic_cylce : integer := 1;
variable reset_value : integer :=0;
	begin
	loop  -- main loop
		loop -- loop for n counter
			wait until (clk'event and clk = '1')or (reset'event and reset = '1');
			exit when (reset = '1');
			if n = counter_max then 
				n := 1;
			else
				n := n + 1; 
			end if;
			j := 1;
			periodic_cylce := 0; -- prepare first cycle
			loop --loop for j counter
				wait until (clk'event and clk = '1')or (reset'event and reset = '1');
				exit when (reset'event and reset = '1');
				if j = n then	
					exit;
				elsif periodic_cylce = 0 then-- indicates that the next output cycle must be low
					counter := j;
					while counter > 0 loop -- loop for zero output
						output <= '0';
						counter := counter -1;
					end loop;
					periodic_cylce := 1;
				elsif periodic_cylce = 1 then-- indicates that the next output cycle must be high
					counter := j;
					while counter > 0 loop -- loop for high output
						output <= '1';
						counter := counter -1;
					end loop;
					periodic_cylce := 0; -- one periodic cycle finished, switch to next cycle
					j := j+1;
				end if;
			end loop;--loop for j counter
		end loop; -- loop for n counter
		-- at this point, reset = '1'
		
		output <= '0';
		n := 1;
		wait until reset = '1';
		end loop; -- main loop


	end process generator;
end architecture ;