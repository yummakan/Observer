LIBRARY ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;



entity top is

port (
   CLOCK_50         :in	std_logic;
	reset_pin			:in 	std_logic;
	GPIO   			:out std_logic_vector(7 downto 0) );

end entity;





architecture rtl of top is
component signalgenerator is 
	port(
		clk		:in  std_logic							:= 'X';
		reset 	:in 	std_logic                    := 'X'; 	-- clk
		output 	:out	std_logic 				-- export
);

end component signalgenerator;
signal clk_s  : std_logic;
begin
	signalgenerator_top : component signalgenerator
	port map (
		output => GPIO(1),
		reset => reset_pin,
		clk => clk_s  
	);
	clk_s <= CLOCK_50;
	--GPIO(0) <= clk_s ;
	--GPIO(1) <= clk_s;
	--GPIO(2) <= reset_pin;
	
	--GPIO(0)<= output_s;
	--reset_pin<= key;
end architecture;
