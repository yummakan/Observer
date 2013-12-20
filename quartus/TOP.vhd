LIBRARY ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;



entity top is

port (
   CLOCK_50         	:in	std_logic;
	CLOCK2_50         :in	std_logic;
	CLOCK3_50         :in	std_logic;
	KEY					:in 	std_logic_vector(3 downto 0) ;
	GPIO   				:out std_logic_vector(7 downto 0) );

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
signal reset_s  : std_logic;
begin
	signalgenerator_top : component signalgenerator
	port map (
		output => GPIO(1),
		reset => reset_s,
		clk => clk_s  
	);
	clk_s <= CLOCK_50;
	reset_s <= KEY(0);
	GPIO(0) <= clk_s;
	GPIO(2) <= reset_s;
	
	--GPIO(0) <= clk_s ;
	--GPIO(0) <= clk_s;
	
	

end architecture;
