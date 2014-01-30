LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity observer is
generic ( 
  observernumber:unsigned(15 downto 0):=x"0001"  -- how many observer are instantiated
      ); 
port (

  clk 			:in	std_logic;
  reset			:in 	std_logic;
  enable_in		:in   std_logic;
  invariance_tau	:in 	std_logic_vector(7 downto 0);
  signal_phi		:in	std_logic;
  output		:out  std_logic;
  enable_out		:out	std_logic
  );
	
end entity;

