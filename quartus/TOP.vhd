LIBRARY ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;



entity top is

port (
   CLOCK_50         :in	std_logic;
	reset_pin		:in 	std_logic;
	GPIO   			:out std_logic_vector(7 downto 0) );

end entity;





architecture rtl of top is
component signalgenerator_2 is 
	port(
		clk		:in  std_logic							:= 'X';
		reset 	:in 	std_logic                    := 'X'; 	-- clk
		output 	:out	std_logic 				-- export
	);

end component signalgenerator_2;
--signal output_s  : std_logic;
begin
	signalgenerator_top : component signalgenerator_2
	port map (
		output => GPIO(0),
		reset => reset_pin,
		clk => CLOCK_50 
	);
	
	--GPIO(0)<= output_s;
	--reset_pin<= key;
end architecture;
