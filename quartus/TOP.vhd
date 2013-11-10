LIBRARY ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;



entity top is

port (
   --CLK_50 :IN	std_logic;
	reset_pin		:in 	std_logic;
	GPIO   			:out std_logic_vector(7 downto 0));

end entity;





architecture rtl of top is
component signalgenerator is 
	port(
		reset 	:in 	std_logic                    := 'X'; 	-- clk
		output 	:out	std_logic 				-- export
	);

end component signalgenerator;
--signal output_s  : std_logic;
begin
	signalgenerator_top : component signalgenerator
	port map (
		output => GPIO(0),
		reset => reset_pin
	);
	
	--GPIO(0)<= output_s;
	--reset_pin<= key;
end architecture;
