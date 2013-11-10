LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity top is

port (
   --CLK_50 			:IN	std_logic;
	key			:in 	std_logic;
	output_s    :out  std_logic);

end entity;





architecture rtl of top is
component signalgenerator is 
	port(
		reset 			:in 	std_logic                    := 'X'; -- clk
		output 			:out	std_logic 									-- export
	);

end component signalgenerator;




--signal output_s  : std_logic;

BEGIN

signalgenerator_top : component signalgenerator
port map (
	output => output_s,
	reset => key);

	
	gpio_pin(0)<= output_s;
	Key(0)<= key;
END ARCHITECTURE;
