LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity signalgenerator is
-- Generic ( n: integer   := 100;  -- counter maximum for outer loop 
 --      ); 
port (

   clk 		        :in	std_logic;
   reset		:in 	std_logic;
   output		:out  std_logic );

end entity;

